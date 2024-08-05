abstract class TabEvent {}

class BookingTabChanged extends TabEvent {
  final int index;
  BookingTabChanged(this.index);
}