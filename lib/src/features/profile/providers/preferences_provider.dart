import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
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
      selectedHobbyIds: {...currentStudent.hobbies ?? {}},
      selectedInterestIds: {...currentStudent.interests ?? {}},
      favCampusActivity: currentStudent.favouriteCampusActivity ?? '',
      favCampusHangoutSpot: currentStudent.favouriteCampusHangoutSpot ?? '',
    );
  },
);

class PreferencesProvider extends StateNotifier<FutureState<String>> {
  final Reader _read;
  final Set<int> _selectedHobbyIds;
  final Set<int> _selectedInterestIds;
  final String favCampusActivity;
  final String favCampusHangoutSpot;

  PreferencesProvider(
    this._read, {
    required Set<int> selectedHobbyIds,
    required Set<int> selectedInterestIds,
    required this.favCampusActivity,
    required this.favCampusHangoutSpot,
  })  : _selectedHobbyIds = selectedHobbyIds,
        _selectedInterestIds = selectedInterestIds,
        super(const FutureState.idle());

  UnmodifiableSetView<int> getSelectedHobbies() {
    return UnmodifiableSetView(_selectedHobbyIds);
  }

  UnmodifiableSetView<int> getSelectedInterests() {
    return UnmodifiableSetView(_selectedInterestIds);
  }

  bool selectHobby({
    required bool isSelected,
    required HobbyModel hobby,
  }) {
    if (isSelected && _selectedHobbyIds.length < 3) {
      final isChanged = _selectedHobbyIds.add(hobby.hobbyId);
      return isChanged;
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
      return _selectedInterestIds.add(interest.interestId);
    } else {
      return _selectedInterestIds.remove(interest.interestId);
    }
  }

  Future<void> updatePreferences({
    required String newCampusHangoutSpot,
    required String newCampusActivity,
  }) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(() {
      return _read(studentsProvider).updateStudentProfile(
        interests: _selectedInterestIds,
        hobbies: _selectedHobbyIds,
        favCampusHangoutSpot: newCampusHangoutSpot,
        favCampusActivity: newCampusActivity,
      );
    });
  }

  void clearUnUpdatedPrefs() {
    _selectedHobbyIds.clear();
    _selectedInterestIds.clear();
  }
}
