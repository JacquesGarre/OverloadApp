class Timer {

  final int _value;

  Timer({required int value}) : _value = value;
  
  int value() {
    return _value;
  }

  String display() {
    return "${duration().inMinutes > 0 ? "${duration().inMinutes} min${duration().inMinutes > 1 ? "s" : ""}" : ""} ${duration().inSeconds % 60 > 0 ? "${duration().inSeconds % 60} secs" : ""}";
  }

  Duration duration() {
    return Duration(seconds: _value);
  }

}