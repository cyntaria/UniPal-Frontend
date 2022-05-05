import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/scheduler_class_model.dart';

final schedulerProvider =
    StateNotifierProvider<SchedulerProvider, List<SchedulerClassModel>>(
  (ref) {
    return SchedulerProvider([
      const SchedulerClassModel.initial(),
    ]);
  },
);

class SchedulerProvider extends StateNotifier<List<SchedulerClassModel>> {
  SchedulerProvider(List<SchedulerClassModel> state) : super(state);

  void addClass() {
    state.add(const SchedulerClassModel.initial());
  }

  void updateClass(int i, SchedulerClassModel cls) {
    state[i] = cls;
  }
}
