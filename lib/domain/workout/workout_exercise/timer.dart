class Timer {

  final int _value;

  Timer({required int value}) : _value = value;
  
  int value() {
    return _value;
  }

  String display() {
    Duration duration = Duration(seconds: _value);
    return "${duration.inMinutes > 0 ? "${duration.inMinutes} min${duration.inMinutes > 1 ? "s" : ""}" : ""} ${duration.inSeconds % 60 > 0 ? "${duration.inSeconds % 60} secs" : ""}";
  }

}