import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class SwitchTabPageEvent {
  int pageIndex = -1;

  SwitchTabPageEvent(this.pageIndex);
}
