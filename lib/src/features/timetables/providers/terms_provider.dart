import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/term_model.codegen.dart';

// Repositories
import '../repositories/terms_repository.dart';

final termByIdProvider = Provider.family<TermModel, int>((ref, id) {
  return ref.watch(termsProvider).getTermById(id);
});

final termsProvider = Provider<TermsProvider>((ref) {
  final _termsRepository = ref.watch(termsRepositoryProvider);
  return TermsProvider(_termsRepository);
});

class TermsProvider {
  final TermsRepository _termsRepository;

  late final Map<int, TermModel> _termsMap;

  TermsProvider(this._termsRepository);

  Future<void> loadTermsInMemory() async {
    final terms = await _termsRepository.fetchAll();
    _termsMap = {for (var e in terms) e.termId: e};
  }

  UnmodifiableListView<TermModel> getAllTerms() {
    return UnmodifiableListView(_termsMap.values);
  }

  TermModel getTermById(int id) {
    return _termsMap[id]!;
  }
}
