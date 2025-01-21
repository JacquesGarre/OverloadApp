class Notes {

  final String _value;

  Notes({required String value}) : _value = value;

  String value() {
    return _value;
  }

  @override 
  String toString() { // TODO: Remove, just for logs
    return _value;
  }
}