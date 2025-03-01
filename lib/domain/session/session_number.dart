class SessionNumber {

  final int _value;

  SessionNumber({required int value}) : _value = value;
  
  static SessionNumber fromPreviousSessionNumber(SessionNumber? sessionNumber) {
    if (sessionNumber == null) {
      return SessionNumber(value: 1);
    }
    return SessionNumber(value: sessionNumber.value() + 1);
  }

  int value() {
    return _value;
  }

}