class UnitType {
  final String _format;// TODO: Unit test

  static const UnitType integer = UnitType._(format: '#');
  static const UnitType double = UnitType._(format: '#.#');

  const UnitType._({required format}) : _format = format;

  String format() {
    return _format;
  }
}

