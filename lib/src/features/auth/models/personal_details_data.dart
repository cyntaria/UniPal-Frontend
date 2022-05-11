import '../enums/gender_enum.dart';

class PersonalDetailsData {
  final String erp;
  final String firstName;
  final String lastName;
  final String uniEmail;
  final String contact;
  final Gender gender;
  final DateTime birthday;

  const PersonalDetailsData({
    required this.erp,
    required this.firstName,
    required this.lastName,
    required this.uniEmail,
    required this.contact,
    required this.gender,
    required this.birthday,
  });
}
