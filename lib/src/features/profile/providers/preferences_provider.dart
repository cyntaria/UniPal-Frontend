// ignore_for_file: use_setters_to_change_properties

import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../../core/networking/custom_exception.dart';
import '../../auth/providers/auth_provider.dart';
import 'students_provider.dart';

// Models
import '../models/interest_model.codegen.dart';
import '../models/hobby_model.codegen.dart';

// States
import '../../shared/states/future_state.codegen.dart';

final prefsProvider =
    StateNotifierProvider.autoDispose<PreferencesProvider, FutureState<String>>(
  (ref) {
    final currentStudent = ref.watch(currentStudentProvider)!;
    return PreferencesProvider(
      ref.read,
      selectedHobbyIds: currentStudent.hobbies,
      selectedInterestIds: currentStudent.interests,
      favCampusActivity: currentStudent.favouriteCampusActivity,
      favCampusHangoutSpot: currentStudent.favouriteCampusHangoutSpot,
      currentStatusId: currentStudent.currentStatusId,
    );
  },
);

class PreferencesProvider extends StateNotifier<FutureState<String>> {
  final Reader _read;
  final List<int> _selectedHobbyIds;
  final List<int> _selectedInterestIds;
  final String? favCampusActivity;
  final String? favCampusHangoutSpot;
  int? currentStatusId;

  PreferencesProvider(
    this._read, {
    required List<int>? selectedHobbyIds,
    required List<int>? selectedInterestIds,
    required this.favCampusActivity,
    required this.favCampusHangoutSpot,
    required this.currentStatusId,
  })  : _selectedHobbyIds =
            selectedHobbyIds != null ? [...selectedHobbyIds] : [],
        _selectedInterestIds =
            selectedInterestIds != null ? [...selectedInterestIds] : [],
        super(const FutureState.idle());

  UnmodifiableListView<int> getSelectedHobbies() {
    return UnmodifiableListView(_selectedHobbyIds);
  }

  UnmodifiableListView<int> getSelectedInterests() {
    return UnmodifiableListView(_selectedInterestIds);
  }

  bool selectHobby({
    required bool isSelected,
    required HobbyModel hobby,
  }) {
    if (isSelected && _selectedHobbyIds.length < 3) {
      _selectedHobbyIds.add(hobby.hobbyId);
      return true;
    } else if (isSelected && _selectedHobbyIds.length >= 3) {
      return false;
    } else {
      final isChanged = _selectedHobbyIds.remove(hobby.hobbyId);
      return isChanged;
    }
  }

  bool selectInterest({
    required bool isSelected,
    required InterestModel interest,
  }) {
    if (isSelected && _selectedInterestIds.length < 3) {
      _selectedInterestIds.add(interest.interestId);
      return true;
    } else {
      return _selectedInterestIds.remove(interest.interestId);
    }
  }

  void selectStudentStatus(int? newStatusId) {
    currentStatusId = newStatusId;
  }

  Future<void> updatePreferences({
    String? newCampusHangoutSpot,
    String? newCampusActivity,
  }) async {
    state = const FutureState.loading();

    final _interests =
        _selectedInterestIds.isNotEmpty ? _selectedInterestIds : null;
    final _hobbies = _selectedHobbyIds.isNotEmpty ? _selectedHobbyIds : null;

    try {
      final result = await _read(studentsProvider).updateStudentProfile(
        hobbies: _hobbies,
        interests: _interests,
        favCampusHangoutSpot: newCampusHangoutSpot,
        favCampusActivity: newCampusActivity,
        currentStatusId: currentStatusId,
      );
      state = FutureState.data(data: result);

      // Update profile provider
      final newStudent = _read(currentStudentProvider.state).state!.copyWith(
            hobbies: _hobbies,
            interests: _interests,
            favouriteCampusHangoutSpot: newCampusHangoutSpot,
            favouriteCampusActivity: newCampusActivity,
            currentStatusId: currentStatusId,
          );

      _read(authProvider.notifier).cacheAuthProfile(newStudent);
      _read(currentStudentProvider.state).state = newStudent;
    } on CustomException catch (ex) {
      state = FutureState.failed(reason: ex.message);
    }
  }

  void clearUnUpdatedPrefs() {
    _selectedHobbyIds.clear();
    _selectedInterestIds.clear();
  }
}
