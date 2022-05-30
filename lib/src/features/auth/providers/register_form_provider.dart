import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../profile/models/campus_model.codegen.dart';
import '../../profile/models/program_model.codegen.dart';
import '../models/personal_details_data.dart';
import '../models/university_details_data.dart';

// States
import '../states/registration_state.codegen.dart';

// Enums
import '../../profile/enums/gender_enum.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormProvider, RegistrationState>(
  (ref) => RegisterFormProvider(),
);

class RegisterFormProvider extends StateNotifier<RegistrationState> {
  PersonalDetailsData? _personalDetailsData;
  UniversityDetailsData? _universityDetailsData;

  PersonalDetailsData? get savedPersonalDetails => _personalDetailsData;
  UniversityDetailsData? get savedUniversityDetails => _universityDetailsData;

  RegisterFormProvider() : super(const RegistrationState.personal());

  void moveToPreviousRegistration() {
    state = state.when(
      personal: () => state,
      university: () => const RegistrationState.personal(),
      password: () => const RegistrationState.university(),
    );
  }

  void savePersonalDetails({
    required String erp,
    required String firstName,
    required String lastName,
    required String contact,
    required String uniEmail,
    required DateTime birthday,
    required Gender gender,
  }) {
    // Save details
    _personalDetailsData = PersonalDetailsData(
      erp: erp,
      firstName: firstName,
      lastName: lastName,
      uniEmail: uniEmail,
      contact: contact,
      gender: gender,
      birthday: birthday,
    );

    // Move to university form
    state = const RegistrationState.university();
  }

  void saveUniversityDetails({
    required int gradYear,
    required ProgramModel programId,
    required CampusModel campusId,
  }) {
    // Save details
    _universityDetailsData = UniversityDetailsData(
      gradYear: gradYear,
      program: programId,
      campus: campusId,
    );

    // Move to password form
    state = const RegistrationState.password();
  }
}
