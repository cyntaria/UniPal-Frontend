import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/timeslot_model.codegen.dart';

// Repositories
import '../repositories/timeslots_repository.dart';

final timeslotBySlotProvider = Provider.family<TimeslotModel, int>((ref, slot) {
  return ref.watch(timeslotsProvider).getTimeslotBySlot(slot);
});

final timeslotsProvider = Provider<TimeslotsProvider>((ref) {
  final _timeslotsRepository = ref.watch(timeslotsRepositoryProvider);
  return TimeslotsProvider(_timeslotsRepository);
});

class TimeslotsProvider {
  final TimeslotsRepository _timeslotsRepository;

  late final Map<int, TimeslotModel> _timeslotsMap;

  TimeslotsProvider(this._timeslotsRepository);

  Future<void> loadTimeslotsInMemory() async {
    final timeslots = await _timeslotsRepository.fetchAll();
    _timeslotsMap = {for (var e in timeslots) e.timeslotId: e};
  }

  UnmodifiableListView<TimeslotModel> getAllTimeslots() {
    return UnmodifiableListView(_timeslotsMap.values);
  }

  TimeslotModel getTimeslotById(int id) {
    return _timeslotsMap[id]!;
  }

  TimeslotModel getTimeslotBySlot(int slot) {
    return _timeslotsMap.values.firstWhere((e) => e.slotNumber == slot);
  }
}
