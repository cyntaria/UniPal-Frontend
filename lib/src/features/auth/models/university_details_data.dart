import '../../profile/models/campus_model.codegen.dart';
import '../../profile/models/program_model.codegen.dart';

class UniversityDetailsData {
  final int gradYear;
  final ProgramModel program;
  final CampusModel campus;

  const UniversityDetailsData({
    required this.gradYear,
    required this.program,
    required this.campus,
  });
}
