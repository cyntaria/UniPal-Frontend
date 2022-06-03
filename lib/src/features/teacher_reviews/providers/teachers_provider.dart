import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/teacher_model.codegen.dart';

final teachersProvider = Provider((_) => TeachersProvider());

final searchFilterProvider = StateProvider.autoDispose<String>((ref) => '');

final searchedTeachersProvider =
    Provider.autoDispose.family<List<TeacherModel>, List<TeacherModel>>(
  (ref, filteredTeachers) {
    final _searchTerm = ref.watch(searchFilterProvider);
    if (_searchTerm.isEmpty) {
      return filteredTeachers;
    }
    return filteredTeachers.where((teacher) {
      return teacher.fullName.toLowerCase().contains(_searchTerm);
    }).toList();
  },
);

class TeachersProvider {
  final _teachers = [
    const TeacherModel(
      teacherId: 1,
      fullName: 'Waseem Arain',
      averageRating: 4.5,
      totalReviews: 2,
    ),
    const TeacherModel(
      teacherId: 2,
      fullName: 'Faisal Iradat',
      averageRating: 3.6,
      totalReviews: 2,
    ),
    const TeacherModel(
      teacherId: 3,
      fullName: 'Maria Rahim',
      averageRating: 5,
      totalReviews: 2,
    ),
    const TeacherModel(
      teacherId: 4,
      fullName: 'Maqsood Alam',
      averageRating: 3.9,
      totalReviews: 40,
    ),
    const TeacherModel(
      teacherId: 5,
      fullName: 'Shafia Imtiaz',
      averageRating: 1.4,
      totalReviews: 200,
    ),
  ];

  List<TeacherModel> getAllTeachers() {
    return [..._teachers, ..._teachers, ..._teachers];
  }
}
