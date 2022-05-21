import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../requests/providers/student_connections_provider.dart';

// States
import '../../shared/states/future_state.codegen.dart';

final profileConnectionProvider =
    StateNotifierProvider<ProfileConnectionProvider, FutureState<String>>(
  (ref) => ProfileConnectionProvider(ref.read),
);

class ProfileConnectionProvider extends StateNotifier<FutureState<String>> {
  final Reader _read;

  ProfileConnectionProvider(this._read) : super(const FutureState.idle());

  Future<void> addFriend(String receiverErp) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(() async {
      await _read(studentConnectionsProvider).addFriend(receiverErp);
      return 'Friend Request Sent!';
    });
  }

  Future<void> acceptFriendRequest(int id) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(() async {
      await _read(studentConnectionsProvider).acceptFriendRequest(id);
      return 'Friend Request Accepted!';
    });
  }

  Future<void> deleteFriendRequest(int id) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(() async {
      await _read(studentConnectionsProvider).deleteFriendRequest(id);
      return 'Friend Request Accepted!';
    });
  }
}
