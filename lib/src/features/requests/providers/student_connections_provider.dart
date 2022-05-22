import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/student_connection_model.codegen.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Repositories
import '../repositories/student_connections_repository.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Enums
import '../enums/connection_status_enum.dart';

final studentConnectionsProvider = Provider<StudentConnectionsProvider>((ref) {
  final _studentConnectionsRepository = ref.watch(
    studentConnectionsRepositoryProvider,
  );
  return StudentConnectionsProvider(
    ref.read,
    studentConnectionsRepository: _studentConnectionsRepository,
  );
});

final receivedConnectionsProvider = FutureProvider((ref) {
  final myErp = ref.watch(currentStudentProvider)!.erp;
  final query = StudentConnectionModel.toUpdateJson(receiverErp: myErp);
  return ref.watch(studentConnectionsProvider).getAllFriendRequests(query);
});

final sentConnectionsProvider = FutureProvider((ref) {
  final myErp = ref.watch(currentStudentProvider)!.erp;
  final query = StudentConnectionModel.toUpdateJson(senderErp: myErp);
  return ref.watch(studentConnectionsProvider).getAllFriendRequests(query);
});

class StudentConnectionsProvider {
  final StudentConnectionsRepository _studentConnectionsRepository;
  final Reader _read;

  StudentConnectionsProvider(
    this._read, {
    required StudentConnectionsRepository studentConnectionsRepository,
  }) : _studentConnectionsRepository = studentConnectionsRepository;

  Future<List<StudentConnectionModel>> getAllFriends([
    JSON? queryParams,
  ]) async {
    return _studentConnectionsRepository.fetchAllConnections(
      queryParameters: queryParams,
    );
  }

  Future<List<StudentConnectionModel>> getAllFriendRequests([
    JSON? queryParams,
  ]) async {
    return _studentConnectionsRepository.fetchAllRequests(
      queryParameters: queryParams,
    );
  }

  Future<int> addFriend({
    required String receiverErp,
    required DateTime sentAt,
  }) async {
    final data = StudentConnectionModel.toUpdateJson(
      senderErp: _read(currentStudentProvider)!.erp,
      receiverErp: receiverErp,
      sentAt: sentAt,
    );

    return _studentConnectionsRepository.create(data: data);
  }

  Future<void> acceptFriendRequest({
    required int studentConnectionId,
    required DateTime acceptedAt,
  }) async {
    final data = StudentConnectionModel.toUpdateJson(
      connectionStatus: ConnectionStatus.FRIENDS,
      acceptedAt: acceptedAt,
    );

    await _studentConnectionsRepository.update(
      studentConnectionId: studentConnectionId,
      data: data,
    );
  }

  Future<void> deleteFriendRequest(int studentConnectionId) async {
    await _studentConnectionsRepository.delete(
      studentConnectionId: studentConnectionId,
    );
  }
}
