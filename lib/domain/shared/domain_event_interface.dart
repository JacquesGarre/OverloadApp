import 'package:uuid/uuid.dart';

abstract class DomainEventInterface {
  UuidValue eventId();
  UuidValue aggregateId();
  DateTime occuredAt();
  String eventName();
}