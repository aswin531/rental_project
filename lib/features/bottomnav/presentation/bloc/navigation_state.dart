abstract class NavigationState {}

class TabChanged extends NavigationState {
  final int currentIndex;
  TabChanged(this.currentIndex);
}
