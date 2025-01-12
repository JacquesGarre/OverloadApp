import 'package:overload/domain/shared/domain_event_interface.dart';

class DomainEventsCollection {
  List<DomainEventInterface> domainEvents = [];

  publish(DomainEventInterface domainEvent) {
    domainEvents.add(domainEvent);
  }

  flush() {
    domainEvents = [];
  }
}
