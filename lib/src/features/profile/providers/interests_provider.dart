import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/interest_model.codegen.dart';

final interestsProvider = Provider<InterestsProvider>((ref) {
  // final _moviesRepository = ref.watch(_moviesRepositoryProvider);
  return InterestsProvider(ref: ref);
});

class InterestsProvider {
  final Ref ref;

  final _interestsMap = const <int, InterestModel>{
    0: InterestModel(interestId: 0, interest: 'Netflix'),
    1: InterestModel(interestId: 1, interest: 'Art'),
    2: InterestModel(interestId: 2, interest: 'History'),
    3: InterestModel(interestId: 3, interest: 'Geography'),
    4: InterestModel(interestId: 4, interest: 'Sports'),
    5: InterestModel(interestId: 5, interest: 'Technology'),
  };

  InterestsProvider({required this.ref});

  UnmodifiableListView<InterestModel> getAllInterests() {
    return UnmodifiableListView(_interestsMap.values);
  }

  InterestModel getInterestById(int id) {
    return _interestsMap[id]!;
  }
}
