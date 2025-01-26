class UnitType {
  final String _value;

  static const UnitType integer = UnitType._(value: 'integer');
  static const UnitType double = UnitType._(value: 'double');

  const UnitType._({required String value}) : _value = value;

  String value() {
    return _value;
  }
}

