import 'package:hooks_riverpod/hooks_riverpod.dart';

// States
import '../states/registration_state.codegen.dart';

// Models
import '../enums/gender_enum.dart';

// Enums
import '../../profile/models/student_model.codegen.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormProvider, RegistrationState>(
  (ref) => RegisterFormProvider(),
);

class RegisterFormProvider extends StateNotifier<RegistrationState> {
  late StudentModel? _savedFormStudent;

  StudentModel? get savedFormStudent => _savedFormStudent;

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
    _savedFormStudent = StudentModel(
      erp: erp,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      contact: contact.startsWith('0') ? '+92${contact.substring(1)}' : contact,
      birthday: birthday,
      profilePictureUrl: '',
      graduationYear: 0,
      uniEmail: uniEmail,
      programId: 0,
      campusId: 0,
      isActive: true,
    );

    // Move to university form
    state = const RegistrationState.university();
  }

  void saveUniversityDetails({
    required int gradYear,
    required int programId,
    required int campusId,
  }) {
    // Save details
    _savedFormStudent = _savedFormStudent!.copyWith(
      graduationYear: gradYear,
      programId: programId,
      campusId: campusId,
    );

    // Move to password form
    state = const RegistrationState.password();
  }
}
