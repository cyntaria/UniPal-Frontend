import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Helpers
import '../../../helpers/extensions/string_extension.dart';

// Networking
import '../../../core/networking/custom_exception.dart';

// Models
import '../models/student_model.codegen.dart';

// States
import '../../shared/states/future_state.codegen.dart';

// Repositories
import '../repositories/students_repository.dart';

final profileProvider =
    StateNotifierProvider<ProfileProvider, FutureState<String>>(
  (ref) {
    final _studentsRepository = ref.watch(studentsRepositoryProvider);
    return ProfileProvider(
      ref.read,
      studentsRepository: _studentsRepository,
    );
  },
);

final profileScreenStudentProvider = StateProvider<StudentModel?>((ref) => null);

class ProfileProvider extends StateNotifier<FutureState<String>> {
  final Reader _read;
  final StudentsRepository _studentsRepository;

  ProfileProvider(
    this._read, {
    required StudentsRepository studentsRepository,
  })  : _studentsRepository = studentsRepository,
        super(const FutureState.idle());

  Future<String> updateStudentProfile({
    String? profilePictureUrl,
    List<int>? interests,
    List<int>? hobbies,
    String? favCampusHangoutSpot,
    String? favCampusActivity,
    int? currentStatusId,
  }) async {
    final _hobbies = <String, int?>{};
    if (hobbies != null) {
      _hobbies['hobby_1'] = hobbies.isNotEmpty ? hobbies[0] : null;
      _hobbies['hobby_2'] = hobbies.length > 1 ? hobbies[1] : null;
      _hobbies['hobby_3'] = hobbies.length > 2 ? hobbies[2] : null;
    }
    final _interests = <String, int?>{};
    if (interests != null) {
      _interests['interest_1'] = interests.isNotEmpty ? interests[0] : null;
      _interests['interest_2'] = interests.length > 1 ? interests[1] : null;
      _interests['interest_3'] = interests.length > 2 ? interests[2] : null;
    }
    final data = StudentModel.toUpdateJson(
      hobby1: _hobbies['hobby_1'],
      hobby2: _hobbies['hobby_2'],
      hobby3: _hobbies['hobby_3'],
      interest1: _interests['interest_1'],
      interest2: _interests['interest_2'],
      interest3: _interests['interest_3'],
      favouriteCampusActivity: favCampusActivity,
      favouriteCampusHangoutSpot: favCampusHangoutSpot,
      profilePictureUrl: profilePictureUrl,
      currentStatusId: currentStatusId,
    );

    if (data.isEmpty) {
      throw CustomException(message: 'Nothing to update!');
    }

    final erp = _read(currentStudentProvider)!.erp;

    // Make request
    final message = await _studentsRepository.update(erp: erp, data: data);

    return message;
  }

  Future<void> updateProfilePicture(String filePath) async {
    state = const FutureState.loading();

    try {
      final file = File(filePath);
      final erp = _read(currentStudentProvider)!.erp;
      const folder = 'users';
      final storePath = '$erp/profile_image${filePath.ext}';

      final ref = FirebaseStorage.instance.ref(folder).child(storePath);

      final task = await ref.putFile(file);
      if (task.state == TaskState.success) {
        // Update the image url in server
        final imageURL = await task.ref.getDownloadURL();
        final msg = await updateStudentProfile(profilePictureUrl: imageURL);

        // Update profile provider
        final newStudent = _read(currentStudentProvider.state)
            .state!
            .copyWith(profilePictureUrl: imageURL);
        _read(authProvider.notifier).cacheAuthProfile(newStudent);
        _read(currentStudentProvider.state).state = newStudent;

        state = FutureState.data(data: msg);
      }
    } on CustomException catch (ex) {
      state = FutureState.failed(reason: ex.message);
    } on FirebaseException catch (ex) {
      state = FutureState.failed(reason: ex.message ?? 'Image Upload Error');
    }
  }
}
