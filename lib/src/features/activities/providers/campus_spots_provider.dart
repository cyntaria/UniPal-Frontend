import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/campus_spot_model.codegen.dart';

// Repositories
import '../repositories/campus_spots_repository.dart';

final campusSpotByIdProvider = Provider.family<CampusSpotModel, int>(
  (ref, id) {
    return ref.watch(campusSpotsProvider).getCampusSpotById(id);
  },
);

final campusSpotsProvider = Provider<CampusSpotsProvider>((ref) {
  final _campusSpotsRepository = ref.watch(
    campusSpotsRepositoryProvider,
  );
  return CampusSpotsProvider(_campusSpotsRepository);
});

class CampusSpotsProvider {
  final CampusSpotsRepository _campusSpotsRepository;

  late final Map<int, CampusSpotModel> _campusSpotsMap;

  CampusSpotsProvider(this._campusSpotsRepository);

  Future<void> loadCampusSpotsInMemory() async {
    final campusSpots = await _campusSpotsRepository.fetchAll();
    _campusSpotsMap = {for (var e in campusSpots) e.campusSpotId: e};
  }

  UnmodifiableListView<CampusSpotModel> getAllCampusSpots() {
    return UnmodifiableListView(_campusSpotsMap.values);
  }

  CampusSpotModel getCampusSpotById(int id) {
    return _campusSpotsMap[id]!;
  }
}
