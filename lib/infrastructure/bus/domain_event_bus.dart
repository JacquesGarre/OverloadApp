import 'package:event_bus/event_bus.dart' as event_bus;
import 'package:logger/logger.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/shared/domain_event_collection.dart';
import 'package:overload/domain/shared/domain_event_interface.dart';

class DomainEventBus implements DomainEventBusInterface {
  final event_bus.EventBus eventBus;

  DomainEventBus({required this.eventBus});

  @override
  publish(DomainEventsCollection domainEvents) {
    for (DomainEventInterface domainEvent in domainEvents.domainEvents) {
      Logger().i("[DomainEventBus] ${domainEvent.eventName()} was published");
      eventBus.fire(domainEvent);
    }
    domainEvents.flush();
  }
}
