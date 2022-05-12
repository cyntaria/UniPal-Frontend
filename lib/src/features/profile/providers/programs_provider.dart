import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/program_model.codegen.dart';

// Repositories
import '../repositories/programs_repository.dart';

final programByIdProvider = Provider.family<ProgramModel, int>((ref, id) {
  return ref.watch(programsProvider).getProgramById(id);
});

final programsProvider = Provider<ProgramsProvider>((ref) {
  final _programsRepository = ref.watch(programsRepositoryProvider);
  return ProgramsProvider(_programsRepository);
});

class ProgramsProvider {
  final ProgramsRepository _programsRepository;

  late final Map<int, ProgramModel> _programsMap;

  ProgramsProvider(this._programsRepository);

  Future<void> loadProgramsInMemory() async {
    final programs = await _programsRepository.fetchAll();
    _programsMap = {for (var e in programs) e.programId: e};
  }

  UnmodifiableListView<ProgramModel> getAllPrograms() {
    return UnmodifiableListView(_programsMap.values);
  }

  ProgramModel getProgramById(int id) {
    return _programsMap[id]!;
  }
}
