enum EquipmentValue {
  dumbbells,
  resistanceBands,
  kettlebells,
  barbell,
  plates,
  pullupBar,
  none,
  machines
}

class Equipment {

  final List<EquipmentValue> _value;

  Equipment({required List<EquipmentValue> value}) : _value = value;

  List<EquipmentValue> value() {
    return _value;
  }

}