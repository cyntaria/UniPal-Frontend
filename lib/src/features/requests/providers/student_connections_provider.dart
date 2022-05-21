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

class StudentConnectionsProvider {
  final StudentConnectionsRepository _studentConnectionsRepository;
  final Reader _read;

  StudentConnectionsProvider(
    this._read, {
    required StudentConnectionsRepository studentConnectionsRepository,
  }) : _studentConnectionsRepository = studentConnectionsRepository;

  Future<List<StudentConnectionModel>> getAllFriends(JSON? queryParams) async {
    return _studentConnectionsRepository.fetchAllConnections(
      queryParameters: queryParams,
    );
  }

  Future<List<StudentConnectionModel>> getAllFriendRequests(
    JSON? queryParams,
  ) async {
    return _studentConnectionsRepository.fetchAllRequests(
      queryParameters: queryParams,
    );
  }

  Future<void> addFriend(String receiverErp) async {
    final data = StudentConnectionModel.toUpdateJson(
      senderErp: _read(currentStudentProvider)!.erp,
      receiverErp: receiverErp,
      sentAt: DateTime.now(),
    );

    await _studentConnectionsRepository.create(data: data);
  }

  Future<void> acceptFriendRequest(int studentConnectionId) async {
    final data = StudentConnectionModel.toUpdateJson(
      connectionStatus: ConnectionStatus.FRIENDS,
      acceptedAt: DateTime.now(),
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
