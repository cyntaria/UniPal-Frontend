import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Models
import '../models/hangout_request_model.codegen.dart';

// States
import '../../shared/states/future_state.codegen.dart';

// Enums
import '../enums/hangout_request_status_enum.dart';

// Repositories
import '../repositories/hangout_requests_repository.dart';

final hangoutRequestProvider = StateNotifierProvider.family<
    HangoutRequestProvider, FutureState<String>, int>(
  (ref, id) {
    final hangoutRequestsRepository = ref.watch(
      hangoutRequestsRepositoryProvider,
    );
    return HangoutRequestProvider(
      hangoutRequestId: id,
      hangoutRequestsRepository: hangoutRequestsRepository,
    );
  },
);

final hangoutsFilterProvider =
    StateProvider<HangoutRequestStatus?>((ref) => null);

final receivedHangoutsProvider = FutureProvider((ref) async {
  final myErp = ref.watch(currentStudentProvider)!.erp;
  final query = HangoutRequestModel.toUpdateJson(receiverErp: myErp);
  final hangoutRequestsRepository = ref.watch(
    hangoutRequestsRepositoryProvider,
  );
  final list = await hangoutRequestsRepository.fetchAllHangoutRequests(
    queryParameters: query,
  );
  final filter = ref.watch(hangoutsFilterProvider);
  if (filter == null) return list;
  return list.where((status) => status.requestStatus == filter).toList();
});

final sentHangoutsProvider = FutureProvider((ref) async {
  final myErp = ref.watch(currentStudentProvider)!.erp;
  final query = HangoutRequestModel.toUpdateJson(senderErp: myErp);
  final hangoutRequestsRepository = ref.watch(
    hangoutRequestsRepositoryProvider,
  );
  final list = await hangoutRequestsRepository.fetchAllHangoutRequests(
    queryParameters: query,
  );
  // TODO(arafaysaleem): make 2 seperate filtered providers for sent and received
  final filter = ref.watch(hangoutsFilterProvider);
  if (filter == null) return list;
  return list.where((status) => status.requestStatus == filter).toList();
});

class HangoutRequestProvider extends StateNotifier<FutureState<String>> {
  final HangoutRequestsRepository _hangoutRequestsRepository;
  final int hangoutRequestId;

  HangoutRequestProvider({
    required HangoutRequestsRepository hangoutRequestsRepository,
    required this.hangoutRequestId,
  })  : _hangoutRequestsRepository = hangoutRequestsRepository,
        super(const FutureState.idle());

  Future<void> acceptHangoutRequest() async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        final data = HangoutRequestModel.toUpdateJson(
          requestStatus: HangoutRequestStatus.ACCEPTED,
          acceptedAt: DateTime.now(),
        );

        await _hangoutRequestsRepository.update(
          hangoutRequestId: hangoutRequestId,
          data: data,
        );

        return 'Hangout Request Accepted!';
      },
      errorMessage: 'Accept Hangout Request Failed',
    );
  }

  Future<void> cancelSentRequest() async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        await _hangoutRequestsRepository.delete(
          hangoutRequestId: hangoutRequestId,
        );
        return 'Hangout Request Cancelled';
      },
      errorMessage: 'Cancel Hangout Request Failed',
    );
  }

  Future<void> rejectHangoutRequest() async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        final data = HangoutRequestModel.toUpdateJson(
          requestStatus: HangoutRequestStatus.REJECTED,
          acceptedAt: DateTime.now(),
        );

        await _hangoutRequestsRepository.update(
          hangoutRequestId: hangoutRequestId,
          data: data,
        );
        return 'Hangout Request Rejected';
      },
      errorMessage: 'Reject Hangout Request Failed',
    );
  }
}
