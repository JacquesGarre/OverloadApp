class Unit {

  final String value;

  static const Unit kgs = Unit._('Kgs');
  static const Unit reps = Unit._('Reps');
  static const Unit restTime = Unit._('Rest time');

  const Unit._(this.value);

}
