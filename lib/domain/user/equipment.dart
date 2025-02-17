import 'package:overload/domain/user/exception/invalid_equipment_exception.dart';

enum EquipmentValue {
  dumbbells,
  resistanceBands,
  kettlebells,
  barbell,
  plates,
  pullupBar,
  machines,
  bodyweight,
}

class Equipment {
  final List<EquipmentValue> _value;

  Equipment({required List<EquipmentValue> value}) : _value = value;

  List<EquipmentValue> value() {
    return _value;
  }

  List<String> toStringList() {
    return _value.map((e) {
      switch (e) {
        case EquipmentValue.dumbbells:
          return "Dumbbells";
        case EquipmentValue.resistanceBands:
          return "Resistance bands";
        case EquipmentValue.kettlebells:
          return "Kettlebells";
        case EquipmentValue.barbell:
          return "Barbells";
        case EquipmentValue.plates:
          return "Plates";
        case EquipmentValue.pullupBar:
          return "Pull-up bar";
        case EquipmentValue.machines:
          return "Machines";
        case EquipmentValue.bodyweight:
          return "Bodyweight only";
        default:
          throw InvalidEquipmentException();
      }
    }).toList();
  }

  static Equipment fromStringList(List<String> trainingTypes) {
    List<EquipmentValue> value = [];
    for (String trainingType in trainingTypes) {
      switch (trainingType) {
        case "Dumbbells":
          value.add(EquipmentValue.dumbbells);
        case "Resistance bands":
          value.add(EquipmentValue.resistanceBands);
        case "Kettlebells":
          value.add(EquipmentValue.kettlebells);
        case "Barbells":
          value.add(EquipmentValue.barbell);
        case "Plates":
          value.add(EquipmentValue.plates);
        case "Pull-up bar":
          value.add(EquipmentValue.pullupBar);
        case "Machines":
          value.add(EquipmentValue.machines);
        case "Bodyweight only":
          value.add(EquipmentValue.bodyweight);
        default:
          throw InvalidEquipmentException();
      }
    }
    return Equipment(value: value);
  }

  static Equipment all() {
    List<EquipmentValue> all = [
      EquipmentValue.dumbbells,
      EquipmentValue.resistanceBands,
      EquipmentValue.kettlebells,
      EquipmentValue.barbell,
      EquipmentValue.plates,
      EquipmentValue.pullupBar,
      EquipmentValue.bodyweight,
      EquipmentValue.machines
    ];
    return Equipment(value: all);
  }
}
