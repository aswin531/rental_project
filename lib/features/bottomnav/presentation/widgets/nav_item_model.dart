import 'package:rentit/features/bottomnav/presentation/widgets/rive_model_widget.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
      title: "Home",
      rive: RiveModel(
        src: "assets/animation/animated_icon.riv",
        artboard: "HOME",
        stateMachineName: "HOME_Interactivity",
      )),
  NavItemModel(
      title: "Search",
      rive: RiveModel(
        src: "assets/animation/animated_icon.riv",
        artboard: "SEARCH",
        stateMachineName: "SEARCH_Interactivity",
      )),
  NavItemModel(
      title: "Timer",
      rive: RiveModel(
        src: "assets/animation/animated_icon.riv",
        artboard: "TIMER",
        stateMachineName: "TIMER_Interactivity",
      )),
  NavItemModel(
      title: "Notification",
      rive: RiveModel(
        src: "assets/animation/animated_icon.riv",
        artboard: "BELL",
        stateMachineName: "BELL_Interactivity",
      )),
  NavItemModel(
      title: "Profile",
      rive: RiveModel(
        src: "assets/animation/animated_icon.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity",
      )),
];
