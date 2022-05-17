import 'dart:collection';
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

// Repositories
import '../repositories/students_repository.dart';

final studentsProvider = Provider<StudentsProvider>((ref) {
  final _studentsRepository = ref.watch(studentsRepositoryProvider);
  return StudentsProvider(
    ref.read,
    studentsRepository: _studentsRepository,
  );
});

class StudentsProvider {
  final _connectStudent = <String, Object?>{
    'erp': '15030',
    'first_name': 'Mohammad Rafay',
    'last_name': 'Siddiqui',
    'gender': 'male',
    'contact': '+923009999999',
    'email': 'rafaysiddiqui58@gmail.com',
    'birthday': '1999-09-18',
    'profile_picture_url':
        'https://i.pinimg.com/564x/8d/e3/89/8de389c84e919d3577f47118e2627d95.jpg',
    'graduation_year': 2022,
    'uni_email': 'm.rafay.15030@iba.khi.edu.pk',
    'hobby_1': 1,
    'hobby_2': 2,
    'hobby_3': 3,
    'interest_1': 1,
    'interest_2': 2,
    'interest_3': 3,
    'program_id': 1,
    'campus_id': 1,
    'favourite_campus_hangout_spot': 'CED',
    'favourite_campus_activity': 'Lifting',
    'current_status': 'Looking for friends',
    'is_active': 1,
    'role': 'admin',
    'student_connection': {
      'student_connection_id': 5,
      'sender_erp': '17855',
      'receiver_erp': '15030',
      'connection_status': 'request_pending',
      'sent_at': '2021-10-04 17:24:40',
      'accepted_at': null
    }
  };
  final Reader _read;
  final StudentsRepository _studentsRepository;

  StudentsProvider(
    this._read, {
    required StudentsRepository studentsRepository,
  }) : _studentsRepository = studentsRepository;

  // TODO(arafaysaleem): remove after demo
  UnmodifiableMapView<String, Object?> get otherStudent =>
      UnmodifiableMapView(_connectStudent);

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
    final file = File(filePath);
    final erp = _read(currentStudentProvider)!.erp;
    const folder = 'users';
    final storePath = '$erp/profile_image${filePath.ext}';

    final ref = FirebaseStorage.instance.ref(folder).child(storePath);

    final task = await ref.putFile(file);
    if (task.state == TaskState.success) {
      final imageURL = await task.ref.getDownloadURL();
      await updateStudentProfile(profilePictureUrl: imageURL);
    }
  }
}
