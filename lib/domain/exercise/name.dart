class Name {
  final String value;

  Name._({required this.value});

  static Name fromString(String value) {
    return Name._(value: value);
  }
}
