class Notes {

  final String _value;

  Notes({required String value}) : _value = value;

  String value() {
    return _value;
  }

  @override 
  String toString() {
    return _value;
  }
}