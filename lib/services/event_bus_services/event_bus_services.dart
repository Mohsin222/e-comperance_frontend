import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class AppMainBottomNavigationBarSetEvent {
  final AppMainBottomNavigationBarType appMainBottomNavigationBarType;
  AppMainBottomNavigationBarSetEvent(
      {required this.appMainBottomNavigationBarType});
}

enum AppMainBottomNavigationBarType {
  setHome,
  setBookingsList,
  setChatList,
  setFavouritesList,
  setSetting
}
