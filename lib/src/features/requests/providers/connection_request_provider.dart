import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../requests/providers/student_connections_provider.dart';

// States
import '../../shared/states/future_state.codegen.dart';

final connectionRequestProvider = StateNotifierProvider.family<
    ConnectionRequestProvider, FutureState<String>, int>(
  (ref, id) => ConnectionRequestProvider(
    ref.read,
    studentConnectionId: id,
  ),
);

class ConnectionRequestProvider extends StateNotifier<FutureState<String>> {
  final Reader _read;
  final int studentConnectionId;

  ConnectionRequestProvider(
    this._read, {
    required this.studentConnectionId,
  }) : super(const FutureState.idle());

  Future<void> acceptFriendRequest() async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        await _read(studentConnectionsProvider).acceptFriendRequest(
          studentConnectionId: studentConnectionId,
          acceptedAt: DateTime.now(),
        );
        return 'Friend Request Accepted!';
      },
      errorMessage: 'Accept Friend Request Failed',
    );
  }

  Future<void> cancelSentRequest() async {
    await _deleteFriendRequest(
      successMessage: 'Friend Request Cancelled',
      errorMessage: 'Cancel Friend Request Failed',
    );
  }

  Future<void> rejectFriendRequest() async {
    await _deleteFriendRequest(
      successMessage: 'Friend Request Rejected',
      errorMessage: 'Reject Friend Request Failed',
    );
  }

  Future<void> _deleteFriendRequest({
    required String successMessage,
    String? errorMessage,
  }) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        await _read(studentConnectionsProvider).deleteFriendRequest(
          studentConnectionId,
        );
        return successMessage;
      },
      errorMessage: errorMessage,
    );
  }
}
