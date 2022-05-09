import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

final studentsProvider = ChangeNotifierProvider<StudentsProvider>((ref) {
  // final _moviesRepository = ref.watch(_moviesRepositoryProvider);
  return StudentsProvider(ref.read);
});

class StudentsProvider extends ChangeNotifier {
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

  StudentsProvider(this._read);

  // TODO(arafaysaleem): remove after demo
  UnmodifiableMapView<String, Object?> get otherStudent =>
      UnmodifiableMapView(_connectStudent);

  void updateStudent({
    required Set<int> interests,
    required Set<int> hobbies,
    required String favCampusHangoutSpot,
    required String favCampusActivity,
  }) {
    _read(currentStudentProvider.notifier).update(
      (currentStudent) => currentStudent!.copyWith(
        hobbies: hobbies,
        interests: interests,
        favouriteCampusHangoutSpot: favCampusHangoutSpot,
        favouriteCampusActivity: favCampusActivity,
      ),
    );
    notifyListeners();
  }
}
