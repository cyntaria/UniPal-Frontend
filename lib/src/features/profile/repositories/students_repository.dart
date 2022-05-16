import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/student_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final studentsRepositoryProvider = Provider<StudentsRepository>(
  (ref) {
    final _apiService = ref.watch(apiServiceProvider);
    return StudentsRepository(apiService: _apiService);
  },
);

class StudentsRepository {
  final ApiService _apiService;

  StudentsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<StudentModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<StudentModel>(
      endpoint: ApiEndpoint.students(StudentEndpoint.BASE),
      queryParams: queryParameters,
      converter: StudentModel.fromJson,
    );
  }

  Future<StudentModel> fetchOne({required String erp}) async {
    return _apiService.getDocumentData<StudentModel>(
      endpoint: ApiEndpoint.students(StudentEndpoint.BY_ERP, erp: erp),
      converter: StudentModel.fromJson,
    );
  }

  Future<String> update({
    required String erp,
    required JSON data,
  }) async {
    return _apiService.updateData<String>(
      endpoint: ApiEndpoint.students(StudentEndpoint.BY_ERP, erp: erp),
      data: data,
      converter: (response) => response.headers.message,
    );
  }
}
