import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../requests/models/hangout_request_model.codegen.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// States
import '../../shared/states/future_state.codegen.dart';

// Repositories
import '../../requests/repositories/hangout_requests_repository.dart';

final profileHangoutProvider = StateNotifierProvider.autoDispose<
    ProfileHangoutProvider, FutureState<String>>(
  (ref) {
    final hangoutRequestsRepository = ref.watch(
      hangoutRequestsRepositoryProvider,
    );
    return ProfileHangoutProvider(
      ref.read,
      hangoutRequestsRepository: hangoutRequestsRepository,
    );
  },
);

class ProfileHangoutProvider extends StateNotifier<FutureState<String>> {
  final Reader _read;
  final HangoutRequestsRepository _hangoutRequestsRepository;

  ProfileHangoutProvider(
    this._read, {
    required HangoutRequestsRepository hangoutRequestsRepository,
  })  : _hangoutRequestsRepository = hangoutRequestsRepository,
        super(const FutureState.idle());

  Future<void> sendHangoutRequest({
    required String receiverErp,
    required String purpose,
    required int meetupSpotId,
    required DateTime meetupAt,
  }) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        final data = HangoutRequestModel.toUpdateJson(
          senderErp: _read(currentStudentProvider)!.erp,
          receiverErp: receiverErp,
          purpose: purpose,
          meetupSpotId: meetupSpotId,
          meetupAt: meetupAt,
        );

        await _hangoutRequestsRepository.create(data: data);

        return 'Hangout Request Sent!';
      },
      errorMessage: 'Send Hangout Request Failed',
    );
  }
}
