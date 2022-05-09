import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/hobby_model.codegen.dart';

final hobbiesProvider = Provider<HobbiesProvider>((ref) {
  // final _moviesRepository = ref.watch(_moviesRepositoryProvider);
  return HobbiesProvider(ref.read);
});

class HobbiesProvider {
  final Reader _read;

  final _hobbiesMap = const <int, HobbyModel>{
    0: HobbyModel(hobbyId: 0, hobby: 'Cricket'),
    1: HobbyModel(hobbyId: 1, hobby: 'Cycling'),
    2: HobbyModel(hobbyId: 2, hobby: 'Reading'),
    3: HobbyModel(hobbyId: 3, hobby: 'Boxing'),
    4: HobbyModel(hobbyId: 4, hobby: 'Painting'),
    5: HobbyModel(hobbyId: 5, hobby: 'Clubbing'),
  };

  HobbiesProvider(this._read);

  UnmodifiableMapView<int, HobbyModel> getHobbiesMap() {
    return UnmodifiableMapView(_hobbiesMap);
  }

  UnmodifiableListView<HobbyModel> getAllHobbies() {
    return UnmodifiableListView(_hobbiesMap.values);
  }

  HobbyModel getHobbyById(int id) {
    return _hobbiesMap[id]!;
  }
}
