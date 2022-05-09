import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import 'students_provider.dart';

// Models
import '../models/interest_model.codegen.dart';
import '../models/hobby_model.codegen.dart';

final prefsProvider = Provider.autoDispose<PreferencesProvider>((ref) {
  // final _moviesRepository = ref.watch(_moviesRepositoryProvider);
  final currentStudent = ref.watch(
    studentsProvider.select((value) => value.currentStudent),
  );
  return PreferencesProvider(
    ref: ref,
    selectedHobbyIds: {...currentStudent['hobbies']! as Set<int>},
    selectedInterestIds: {...currentStudent['interests']! as Set<int>},
    favCampusActivity: currentStudent['favourite_campus_activity']! as String,
    favCampusHangoutSpot:
        currentStudent['favourite_campus_hangout_spot']! as String,
  );
});

class PreferencesProvider {
  final Ref ref;
  final Set<int> _selectedHobbyIds;
  final Set<int> _selectedInterestIds;
  final String favCampusActivity;
  final String favCampusHangoutSpot;

  PreferencesProvider({
    required this.ref,
    required Set<int> selectedHobbyIds,
    required Set<int> selectedInterestIds,
    required this.favCampusActivity,
    required this.favCampusHangoutSpot,
  })  : _selectedHobbyIds = selectedHobbyIds,
        _selectedInterestIds = selectedInterestIds;

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

  void updatePreferences({
    required String newCampusHangoutSpot,
    required String newCampusActivity,
  }) {
    ref.read(studentsProvider).updateStudent(
          interests: _selectedInterestIds,
          hobbies: _selectedHobbyIds,
          favCampusHangoutSpot: newCampusHangoutSpot,
          favCampusActivity: newCampusActivity,
        );
  }

  void clearUnupdatedPrefs() {
    _selectedHobbyIds.clear();
    _selectedInterestIds.clear();
  }
}
