enum Gender { male, female }

extension GenderExtension on Gender {
  String get convertToString {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
    }
  }
}