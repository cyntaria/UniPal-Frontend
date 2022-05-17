// ignore_for_file: constant_identifier_names

/// A collection of types that a student can be.
enum StudentType {
  FRESHMAN,
  SOPHOMORE,
  JUNIOR,
  SENIOR,
  ALUMNI,
}

/// A utility with extensions for enum name and serialized value.
extension ExtStudentType on StudentType {
  String get toJson => name.toLowerCase();

  int get graduationYear {
    final now = DateTime.now();
    final diff = now.month < 7 ? index + 1 : index;
    final gradYear = 4 + now.year - diff;
    // TODO(arafaysaleem): Do something to cater alumnis
    // if (index == 4) return >= gradYear;
    return gradYear;
  }
}
