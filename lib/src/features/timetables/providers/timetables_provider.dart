import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Models
import '../models/class_model.codegen.dart';
import '../models/generated_timetable_model.codegen.dart';
import '../models/timetable_model.codegen.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Repositories
import '../repositories/timetables_repository.dart';

// States
import '../../shared/states/future_state.codegen.dart';

final timetablesProvider = StateNotifierProvider<TimetablesProvider, FutureState<String>>((ref) {
  return TimetablesProvider(
    ref.read,
    timetablesRepository: ref.watch(timetablesRepositoryProvider),
  );
});

final generatedTimetablesProvider = FutureProvider.family<
    List<GeneratedTimetableJSON>, GeneratedTimetableModel>(
  (ref, data) async {
    return ref
        .watch(timetablesProvider.notifier)
        .generateTimetables(generateModel: data);
  },
);

class TimetablesProvider extends StateNotifier<FutureState<String>> {
  final Reader _read;
  final TimetablesRepository _timetablesRepository;

  TimetablesProvider(
    this._read, {
    required TimetablesRepository timetablesRepository,
  })  : _timetablesRepository = timetablesRepository,
        super(const FutureState.idle());

  Future<List<TimetableModel>> getAllTimetables([JSON? queryParams]) async {
    return _timetablesRepository.fetchAllTimetables(
      queryParameters: queryParams,
    );
  }

  Future<TimetableModel> getSingleTimetable(int timetableId) async {
    return _timetablesRepository.fetchOne(
      timetableId: timetableId,
    );
  }

  Future<List<GeneratedTimetableJSON>> generateTimetables({
    required GeneratedTimetableModel generateModel,
  }) async {
    final data = generateModel.toJson();

    return _timetablesRepository.generate(data: data);
  }

  Future<void> createTimetable({
    required int termId,
    required List<ClassModel> classes,
  }) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        final data = TimetableModel(
          studentErp: _read(currentStudentProvider)!.erp,
          termId: termId,
          classes: classes,
        ).toJson();

        await _timetablesRepository.create(
          data: data,
        );

        return 'Timetable created succesfully!';
      },
      errorMessage: 'Create Timetable Failed',
    );
  }

  Future<void> updateTimetable({
    required int timetableId,
    required bool isActive,
  }) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        final data = TimetableModel.toUpdateJson(
          isActive: isActive,
        );

        return _timetablesRepository.update(
          timetableId: timetableId,
          data: data,
        );
      },
      errorMessage: 'Activate timetable failed',
    );
  }

  Future<void> updateTimetableClasses({
    required int timetableId,
    required List<ClassModel>? added,
    required List<ClassModel>? removed,
  }) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        final data = TimetableModel.toUpdateJson(
          added: added,
          removed: removed,
        );

        return _timetablesRepository.update(
          timetableId: timetableId,
          data: data,
        );
      },
      errorMessage: 'Update timetable classes failed',
    );
  }

  Future<void> deleteTimetable(int timetableId) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        return _timetablesRepository.delete(
          timetableId: timetableId,
        );
      },
      errorMessage: 'Delete timetable failed',
    );
  }
}
