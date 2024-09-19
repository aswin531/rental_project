import 'dart:async';
import 'dart:ui';

class Debouncer {
  final int milliSeconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliSeconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliSeconds), action);
  }
}
