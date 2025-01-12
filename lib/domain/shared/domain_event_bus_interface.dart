import 'package:overload/domain/shared/domain_event_collection.dart';

abstract class DomainEventBusInterface {
  publish(DomainEventsCollection domainEvents); 
}