import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/interest_model.codegen.dart';

final interestsProvider = Provider<InterestsProvider>((ref) {
  // final _moviesRepository = ref.watch(_moviesRepositoryProvider);
  return InterestsProvider();
});

class InterestsProvider {
  final _interestsMap = const <int, InterestModel>{
    0: InterestModel(interestId: 0, interest: 'Cricket'),
    1: InterestModel(interestId: 1, interest: 'Cycling'),
    2: InterestModel(interestId: 2, interest: 'Reading'),
    3: InterestModel(interestId: 3, interest: 'Boxing'),
    4: InterestModel(interestId: 4, interest: 'Painting'),
    5: InterestModel(interestId: 5, interest: 'Clubbing'),
  };

  final _student3InterestIds = const {2, 4, 5};

  UnmodifiableListView<InterestModel> getAllInterests() {
    return UnmodifiableListView(_interestsMap.values);
  }

  List<InterestModel> getStudentInterests() {
    return _student3InterestIds.map<InterestModel>((id) => _interestsMap[id]!).toList();
  }

  void updateStudentInterests({
    required bool isSelected,
    required InterestModel interest,
  }) {
    if (isSelected && _student3InterestIds.length < 3) {
      _student3InterestIds.add(interest.interestId);
    } else {
      _student3InterestIds.remove(interest.interestId);
    }
  }
}
