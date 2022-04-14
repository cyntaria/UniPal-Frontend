import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import 'students_provider.dart';

// Models
import '../models/interest_model.codegen.dart';

final interestsProvider = Provider<InterestsProvider>((ref) {
  // final _moviesRepository = ref.watch(_moviesRepositoryProvider);
  final studentInterests = ref.watch(
    studentsProvider.select(
      (value) => value.currentStudent['interests']! as Set<int>,
    ),
  );
  return InterestsProvider(
    ref: ref,
    selectedInterestIds: studentInterests,
  );
});

class InterestsProvider {
  final ProviderRef ref;
  final Set<int> _selectedInterestIds;

  final _interestsMap = const <int, InterestModel>{
    0: InterestModel(interestId: 0, interest: 'Netflix'),
    1: InterestModel(interestId: 1, interest: 'Art'),
    2: InterestModel(interestId: 2, interest: 'History'),
    3: InterestModel(interestId: 3, interest: 'Geography'),
    4: InterestModel(interestId: 4, interest: 'Sports'),
    5: InterestModel(interestId: 5, interest: 'Technology'),
  };

  InterestsProvider({required this.ref, required Set<int> selectedInterestIds})
      : _selectedInterestIds = selectedInterestIds;

  UnmodifiableListView<InterestModel> getAllInterests() {
    return UnmodifiableListView(_interestsMap.values);
  }

  UnmodifiableSetView<int> getSelectedInterests() {
    return UnmodifiableSetView(_selectedInterestIds);
  }

  InterestModel getInterestById(int id) {
    return _interestsMap[id]!;
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

  void clearSelectedInterests() => _selectedInterestIds.clear();
}
