import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/campus_model.codegen.dart';

// Repositories
import '../repositories/campuses_repository.dart';

final campusByIdProvider = Provider.family<CampusModel, int>((ref, id) {
  return ref.watch(campusesProvider).getCampusById(id);
});

final campusesProvider = Provider<CampusesProvider>((ref) {
  final _campusesRepository = ref.watch(campusesRepositoryProvider);
  return CampusesProvider(_campusesRepository);
});

class CampusesProvider {
  final CampusesRepository _campusesRepository;

  late final Map<int, CampusModel> _campusesMap;

  CampusesProvider(this._campusesRepository);

  Future<void> loadCampusesInMemory() async {
    final campuses = await _campusesRepository.fetchAll();
    _campusesMap = {for (var e in campuses) e.campusId: e};
  }

  UnmodifiableListView<CampusModel> getAllCampuses() {
    return UnmodifiableListView(_campusesMap.values);
  }

  CampusModel getCampusById(int id) {
    return _campusesMap[id]!;
  }
}
