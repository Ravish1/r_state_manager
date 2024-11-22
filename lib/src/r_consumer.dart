
import 'package:flutter/widgets.dart';
import 'r_state_manager.dart';
import 'r_state.dart';

class RConsumer<S, E> extends StatefulWidget {
  final Widget Function(BuildContext context, S state) builder;

  const RConsumer({required this.builder});

  @override
  _RConsumerState<S, E> createState() => _RConsumerState<S, E>();
}

class _RConsumerState<S, E> extends State<RConsumer<S, E>> {
  late S state;
  late RStateManager<S, E> manager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = RState.of<S, E>(context);
    assert(provider != null, 'No RState found for type $S and $E');
    manager = provider!.manager;

    state = manager.state;
    manager.addListener(_onStateChange);
  }

  @override
  void dispose() {
    manager.removeListener(_onStateChange);
    super.dispose();
  }

  void _onStateChange(S newState) {
    setState(() {
      state = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state);
  }
}
