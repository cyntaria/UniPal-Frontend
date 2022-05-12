import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/hobby_model.codegen.dart';

// Repositories
import '../repositories/hobbies_repository.dart';

final hobbyByIdProvider = Provider.family<HobbyModel, int>((ref, id) {
  return ref.watch(hobbiesProvider).getHobbyById(id);
});

final hobbiesProvider = Provider<HobbiesProvider>((ref) {
  final _hobbiesRepository = ref.watch(hobbiesRepositoryProvider);
  return HobbiesProvider(_hobbiesRepository);
});

class HobbiesProvider {
  final HobbiesRepository _hobbiesRepository;

  late final Map<int, HobbyModel> _hobbiesMap;

  HobbiesProvider(this._hobbiesRepository);

  Future<void> loadHobbiesInMemory() async {
    final hobbies = await _hobbiesRepository.fetchAll();
    _hobbiesMap = {for (var e in hobbies) e.hobbyId: e};
  }

  UnmodifiableListView<HobbyModel> getAllHobbies() {
    return UnmodifiableListView(_hobbiesMap.values);
  }

  HobbyModel getHobbyById(int id) {
    return _hobbiesMap[id]!;
  }
}
