class UnitType {
  final String format;

  static const UnitType integer = UnitType._('#');
  static const UnitType double = UnitType._('#.#');

  const UnitType._(this.format);
}

// TODO: Unit test