import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import 'students_provider.dart';

// Models
import '../../profile/models/hobby_model.codegen.dart';
import '../../profile/models/interest_model.codegen.dart';
import '../../profile/models/program_model.codegen.dart';
import '../../profile/models/student_model.codegen.dart';
import '../../profile/models/student_status_model.codegen.dart';

// Enums
import '../../profile/enums/gender_enum.dart';
import '../../profile/enums/student_type_enum.dart';
import '../../profile/models/campus_model.codegen.dart';

final genderFilterProvider = StateProvider<Gender?>((ref) => null);
final programFilterProvider = StateProvider<ProgramModel?>((ref) => null);
final campusFilterProvider = StateProvider<CampusModel?>((ref) => null);
final hobbyFilterProvider = StateProvider<HobbyModel?>((ref) => null);
final interestFilterProvider = StateProvider<InterestModel?>((ref) => null);
final batchFilterProvider = StateProvider<int?>((ref) => null);
final studentTypeFilterProvider = StateProvider<StudentType?>((ref) => null);
final studentStatusFilterProvider =
    StateProvider<StudentStatusModel?>((ref) => null);

final _filteredStudentsProvider = FutureProvider<List<StudentModel>>(
  (ref) {
    final _genderFilter = ref.watch(genderFilterProvider.notifier).state;
    final _programFilter = ref.watch(programFilterProvider.notifier).state;
    final _campusFilter = ref.watch(campusFilterProvider.notifier).state;
    final _hobbyFilter = ref.watch(hobbyFilterProvider.notifier).state;
    final _interestFilter = ref.watch(interestFilterProvider.notifier).state;
    final _batchFilter = ref.watch(batchFilterProvider.notifier).state;
    final _studentTypeFilter =
        ref.watch(studentTypeFilterProvider.notifier).state;
    final _studentStatusFilter =
        ref.watch(studentStatusFilterProvider.notifier).state;

    final queryParams = StudentModel.toUpdateJson(
      gender: _genderFilter,
      programId: _programFilter?.programId,
      campusId: _campusFilter?.campusId,
      currentStatusId: _studentStatusFilter?.studentStatusId,
      hobby1: _hobbyFilter?.hobbyId,
      interest1: _interestFilter?.interestId,
      graduationYear: _studentTypeFilter?.graduationYear ?? _batchFilter,
      isActive: true,
    );

    final students = ref
        .watch(studentsProvider)
        .getAllStudents(queryParams.isEmpty ? null : queryParams);

    return students;
  },
);

final searchFilterProvider = StateProvider<String>((ref) => '');

final searchFilteredStudentsProvider = FutureProvider<List<StudentModel>>(
  (ref) async {
    final _searchTerm = ref.watch(searchFilterProvider);
    final filteredStudents = await ref.watch(_filteredStudentsProvider.future);
    if (_searchTerm.isEmpty) {
      return filteredStudents;
    }
    return filteredStudents
        .where(
          (student) =>
              student.firstName.contains(_searchTerm) ||
              student.lastName.contains(_searchTerm),
        )
        .toList();
  },
);
