
import 'package:flutter/widgets.dart';
import 'r_state_manager.dart';

class RState<S, E> extends InheritedWidget {
  final RStateManager<S, E> manager;

  const RState({
    required this.manager,
    required Widget child,
  }) : super(child: child);

  static RState<S, E>? of<S, E>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RState<S, E>>();
  }

  @override
  bool updateShouldNotify(RState<S, E> oldWidget) {
    return oldWidget.manager != manager;
  }
}
