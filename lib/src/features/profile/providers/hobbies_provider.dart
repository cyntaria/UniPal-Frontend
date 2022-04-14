import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import 'students_provider.dart';

// Models
import '../models/hobby_model.codegen.dart';

final hobbiesProvider = Provider<HobbiesProvider>((ref) {
  // final _moviesRepository = ref.watch(_moviesRepositoryProvider);
  final studentHobbies = ref.watch(
    studentsProvider.select(
      (value) => value.currentStudent['hobbies']! as Set<int>,
    ),
  );
  return HobbiesProvider(
    ref: ref,
    selectedHobbyIds: studentHobbies,
  );
});

class HobbiesProvider {
  final ProviderRef ref;
  final Set<int> _selectedHobbyIds;

  final _hobbiesMap = const <int, HobbyModel>{
    0: HobbyModel(hobbyId: 0, hobby: 'Cricket'),
    1: HobbyModel(hobbyId: 1, hobby: 'Cycling'),
    2: HobbyModel(hobbyId: 2, hobby: 'Reading'),
    3: HobbyModel(hobbyId: 3, hobby: 'Boxing'),
    4: HobbyModel(hobbyId: 4, hobby: 'Painting'),
    5: HobbyModel(hobbyId: 5, hobby: 'Clubbing'),
  };

  HobbiesProvider({required this.ref, required Set<int> selectedHobbyIds})
      : _selectedHobbyIds = selectedHobbyIds;

  UnmodifiableListView<HobbyModel> getAllHobbies() {
    return UnmodifiableListView(_hobbiesMap.values);
  }

  UnmodifiableSetView<int> getSelectedHobbies() {
    return UnmodifiableSetView(_selectedHobbyIds);
  }

  HobbyModel getHobbyById(int id) {
    return _hobbiesMap[id]!;
  }

  bool selectHobby({
    required bool isSelected,
    required HobbyModel hobby,
  }) {
    if (isSelected && _selectedHobbyIds.length < 3) {
      return _selectedHobbyIds.add(hobby.hobbyId);
    } else {
      return _selectedHobbyIds.remove(hobby.hobbyId);
    }
  }

  void clearSelectedHobbies() => _selectedHobbyIds.clear();
}
