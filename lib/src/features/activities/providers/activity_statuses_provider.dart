import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/activity_status_model.codegen.dart';

// Repositories
import '../repositories/activity_statuses_repository.dart';

final activityStatusByIdProvider = Provider.family<ActivityStatusModel, int>(
  (ref, id) {
    return ref.watch(activityStatusesProvider).getActivityStatusById(id);
  },
);

final activityStatusesProvider = Provider<ActivityStatusesProvider>((ref) {
  final _activityStatusesRepository = ref.watch(
    activityStatusesRepositoryProvider,
  );
  return ActivityStatusesProvider(_activityStatusesRepository);
});

class ActivityStatusesProvider {
  final ActivityStatusesRepository _activityStatusesRepository;

  late final Map<int, ActivityStatusModel> _activityStatusesMap;

  ActivityStatusesProvider(this._activityStatusesRepository);

  Future<void> loadActivityStatusesInMemory() async {
    final activityStatuses = await _activityStatusesRepository.fetchAll();
    _activityStatusesMap = {for (var e in activityStatuses) e.activityStatusId: e};
  }

  UnmodifiableListView<ActivityStatusModel> getAllActivityStatuses() {
    return UnmodifiableListView(_activityStatusesMap.values);
  }

  ActivityStatusModel getActivityStatusById(int id) {
    return _activityStatusesMap[id]!;
  }
}
