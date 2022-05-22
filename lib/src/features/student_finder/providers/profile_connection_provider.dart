import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../profile/models/student_model.codegen.dart';

// Providers
import '../../auth/providers/auth_provider.dart';
import '../../requests/providers/student_connections_provider.dart';

// Enums
import '../../requests/enums/connection_status_enum.dart';

// States
import '../../shared/states/future_state.codegen.dart';

final profileConnectionProvider =
    StateNotifierProvider<ProfileConnectionProvider, FutureState<String>>(
  (ref) => ProfileConnectionProvider(ref.read),
);

class ProfileConnectionProvider extends StateNotifier<FutureState<String>> {
  final Reader _read;

  ProfileConnectionProvider(this._read) : super(const FutureState.idle());

  Future<ProfileStudentConnectionModel?> addFriend(String receiverErp) async {
    state = const FutureState.loading();

    ProfileStudentConnectionModel? connection;

    state = await FutureState.makeGuardedRequest(
      () async {
        final sentAt = DateTime.now();

        final id = await _read(studentConnectionsProvider).addFriend(
          receiverErp: receiverErp,
          sentAt: sentAt,
        );

        connection = ProfileStudentConnectionModel(
          studentConnectionId: id,
          connectionStatus: ConnectionStatus.REQUEST_PENDING,
          sentAt: sentAt,
          senderErp: _read(currentStudentProvider)!.erp,
          receiverErp: receiverErp,
        );

        return 'Friend Request Sent!';
      },
      errorMessage: 'Send Friend Request Failed',
    );

    return connection;
  }

  Future<ProfileStudentConnectionModel> acceptFriendRequest(
    ProfileStudentConnectionModel connection,
  ) async {
    state = const FutureState.loading();

    final acceptedAt = DateTime.now();

    state = await FutureState.makeGuardedRequest(
      () async {
        await _read(studentConnectionsProvider).acceptFriendRequest(
          studentConnectionId: connection.studentConnectionId,
          acceptedAt: acceptedAt,
        );
        return 'Friend Request Accepted!';
      },
      errorMessage: 'Accept Friend Request Failed',
    );

    return connection.copyWith(
      connectionStatus: ConnectionStatus.FRIENDS,
      acceptedAt: acceptedAt,
    );
  }

  Future<bool> cancelSentRequest(int id) async {
    return _deleteFriendRequest(
      id,
      successMessage: 'Friend Request Cancelled',
      errorMessage: 'Cancel Friend Request Failed',
    );
  }

  Future<bool> unFriend(int id) async {
    return _deleteFriendRequest(
      id,
      successMessage: 'Friend Removed Succesfully',
      errorMessage: 'Remove Friend Failed',
    );
  }

  Future<bool> rejectFriendRequest(int id) async {
    return _deleteFriendRequest(
      id,
      successMessage: 'Friend Request Rejected',
      errorMessage: 'Reject Friend Request Failed',
    );
  }

  Future<bool> _deleteFriendRequest(
    int id, {
    required String successMessage,
    String? errorMessage,
  }) async {
    state = const FutureState.loading();

    var success = false;

    state = await FutureState.makeGuardedRequest(
      () async {
        await _read(studentConnectionsProvider).deleteFriendRequest(id);
        success = true;
        return successMessage;
      },
      errorMessage: errorMessage,
    );

    return success;
  }
}
