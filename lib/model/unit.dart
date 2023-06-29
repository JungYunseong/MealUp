enum Unit { ft, cm, lbs, kg }

extension UnitExtension on Unit {
  String get convertToString {
    switch (this) {
      case Unit.ft:
        return 'ft/in';
      case Unit.cm:
        return 'cm';
        case Unit.lbs:
        return 'lbs';
        case Unit.kg:
        return 'kg';
    }
  }
}