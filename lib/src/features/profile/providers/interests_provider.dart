import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/interest_model.codegen.dart';

// Repositories
import '../repositories/interests_repository.dart';

final interestByIdProvider = Provider.family<InterestModel, int>((ref, id) {
  return ref.watch(interestsProvider).getInterestById(id);
});

final interestsProvider = Provider<InterestsProvider>((ref) {
  final _interestsRepository = ref.watch(interestsRepositoryProvider);
  return InterestsProvider(_interestsRepository);
});

class InterestsProvider {
  final InterestsRepository _interestsRepository;

  late final Map<int, InterestModel> _interestsMap;

  InterestsProvider(this._interestsRepository);

  Future<void> loadInterestsInMemory() async {
    final interests = await _interestsRepository.fetchAll();
    _interestsMap = {for (var e in interests) e.interestId: e};
  }

  UnmodifiableListView<InterestModel> getAllInterests() {
    return UnmodifiableListView(_interestsMap.values);
  }

  InterestModel getInterestById(int id) {
    return _interestsMap[id]!;
  }
}
