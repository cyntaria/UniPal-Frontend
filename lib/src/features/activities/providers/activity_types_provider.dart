import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/activity_type_model.codegen.dart';

// Repositories
import '../repositories/activity_types_repository.dart';

final activityTypeByIdProvider = Provider.family<ActivityTypeModel, int>(
  (ref, id) {
    return ref.watch(activityTypesProvider).getActivityTypeById(id);
  },
);

final activityTypesProvider = Provider<ActivityTypesProvider>((ref) {
  final _activityTypesRepository = ref.watch(
    activityTypesRepositoryProvider,
  );
  return ActivityTypesProvider(_activityTypesRepository);
});

class ActivityTypesProvider {
  final ActivityTypesRepository _activityTypesRepository;

  late final Map<int, ActivityTypeModel> _activityTypesMap;

  ActivityTypesProvider(this._activityTypesRepository);

  Future<void> loadActivityTypesInMemory() async {
    final activityTypes = await _activityTypesRepository.fetchAll();
    _activityTypesMap = {for (var e in activityTypes) e.activityTypeId: e};
  }

  UnmodifiableListView<ActivityTypeModel> getAllActivityTypes() {
    return UnmodifiableListView(_activityTypesMap.values);
  }

  ActivityTypeModel getActivityTypeById(int id) {
    return _activityTypesMap[id]!;
  }
}
