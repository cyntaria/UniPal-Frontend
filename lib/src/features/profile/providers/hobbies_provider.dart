import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/hobby_model.codegen.dart';

final hobbiesProvider = Provider<HobbiesProvider>((ref) {
  // final _moviesRepository = ref.watch(_moviesRepositoryProvider);
  return HobbiesProvider();
});

class HobbiesProvider {
  final _hobbiesMap = const <int, HobbyModel>{
    0: HobbyModel(hobbyId: 0, hobby: 'Cricket'),
    1: HobbyModel(hobbyId: 1, hobby: 'Cycling'),
    2: HobbyModel(hobbyId: 2, hobby: 'Reading'),
    3: HobbyModel(hobbyId: 3, hobby: 'Boxing'),
    4: HobbyModel(hobbyId: 4, hobby: 'Painting'),
    5: HobbyModel(hobbyId: 5, hobby: 'Clubbing'),
  };

  final _student3HobbyIds = const {2, 4, 5};

  UnmodifiableListView<HobbyModel> getAllHobbies() {
    return UnmodifiableListView(_hobbiesMap.values);
  }

  List<HobbyModel> getStudentHobbies() {
    return _student3HobbyIds.map<HobbyModel>((id) => _hobbiesMap[id]!).toList();
  }

  void updateStudentHobbies({
    required bool isSelected,
    required HobbyModel hobby,
  }) {
    if (isSelected && _student3HobbyIds.length < 3) {
      _student3HobbyIds.add(hobby.hobbyId);
    } else {
      _student3HobbyIds.remove(hobby.hobbyId);
    }
  }
}
