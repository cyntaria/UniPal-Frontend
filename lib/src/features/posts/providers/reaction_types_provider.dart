import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/reaction_type_model.codegen.dart';

// Repositories
import '../repositories/reaction_types_repository.dart';

final reactionTypeByIdProvider = Provider.family<ReactionTypeModel, int>(
  (ref, id) {
    return ref.watch(reactionTypesProvider).getReactionTypeById(id);
  },
);

final reactionTypesProvider = Provider<ReactionTypesProvider>((ref) {
  final _reactionTypesRepository = ref.watch(
    reactionTypesRepositoryProvider,
  );
  return ReactionTypesProvider(_reactionTypesRepository);
});

class ReactionTypesProvider {
  final ReactionTypesRepository _reactionTypesRepository;

  late final Map<int, ReactionTypeModel> _reactionTypesMap;

  ReactionTypesProvider(this._reactionTypesRepository);

  Future<void> loadReactionTypesInMemory() async {
    final reactionTypes = await _reactionTypesRepository.fetchAll();
    _reactionTypesMap = {for (var e in reactionTypes) e.reactionTypeId: e};
  }

  UnmodifiableListView<ReactionTypeModel> getAllReactionTypes() {
    return UnmodifiableListView(_reactionTypesMap.values);
  }

  ReactionTypeModel getReactionTypeById(int id) {
    return _reactionTypesMap[id]!;
  }
}
