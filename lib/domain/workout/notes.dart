class Notes {

  final String _value;

  Notes._({required String value}) : _value = value.trim();

  String value() {
    return _value;
  }

  static Notes? fromString(String? value) {
    if (value == null || value.trim() == "") {
      return null;
    }
    return Notes._(value: value);
  }

}