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

final receivedHangoutsProvider = FutureProvider((ref) {
  final myErp = ref.watch(currentStudentProvider)!.erp;
  final requestStatus = ref.watch(hangoutsFilterProvider);
  final query = HangoutRequestModel.toUpdateJson(
    receiverErp: myErp,
    requestStatus: requestStatus,
  );
  final hangoutRequestsRepository = ref.watch(
    hangoutRequestsRepositoryProvider,
  );
  return hangoutRequestsRepository.fetchAllHangoutRequests(
    queryParameters: query,
  );
});

final sentHangoutsProvider = FutureProvider((ref) {
  final myErp = ref.watch(currentStudentProvider)!.erp;
  final requestStatus = ref.watch(hangoutsFilterProvider);
  final query = HangoutRequestModel.toUpdateJson(
    senderErp: myErp,
    requestStatus: requestStatus,
  );
  final hangoutRequestsRepository = ref.watch(
    hangoutRequestsRepositoryProvider,
  );
  return hangoutRequestsRepository.fetchAllHangoutRequests(
    queryParameters: query,
  );
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
    await _deleteHangoutRequest(
      successMessage: 'Hangout Request Cancelled',
      errorMessage: 'Cancel Hangout Request Failed',
    );
  }

  Future<void> rejectHangoutRequest() async {
    await _deleteHangoutRequest(
      successMessage: 'Hangout Request Rejected',
      errorMessage: 'Reject Hangout Request Failed',
    );
  }

  Future<void> _deleteHangoutRequest({
    required String successMessage,
    String? errorMessage,
  }) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        await _hangoutRequestsRepository.delete(
          hangoutRequestId: hangoutRequestId,
        );
        return successMessage;
      },
      errorMessage: errorMessage,
    );
  }
}
