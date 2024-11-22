import 'package:flutter/material.dart';
import 'package:r_state_manager/r_state_manager.dart';

void main() {
  runApp(const MyApp());
}

// Counter State
class CounterState {
  final int count;

  CounterState(this.count);

  CounterState copyWith({int? count}) {
    return CounterState(count ?? this.count);
  }
}

// Counter Events
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

// Counter Manager
class CounterManager extends RStateManager<CounterState, CounterEvent> {
  CounterManager()
      : super(CounterState(0), (state, event) {
    if (event is IncrementEvent) {
      return state.copyWith(count: state.count + 1);
    } else if (event is DecrementEvent) {
      return state.copyWith(count: state.count - 1);
    }
    return state;
  });
}

// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final counterManager = CounterManager();

    return RState<CounterState, CounterEvent>(
      manager: counterManager,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Counter Example'),
          ),
          body: const CounterScreen(),
        ),
      ),
    );
  }
}

// Counter Screen
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RConsumer<CounterState, CounterEvent>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Count: ${state.count}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      RState.of<CounterState, CounterEvent>(context)!
                          .manager
                          .dispatch(IncrementEvent());
                    },
                    child: const Text('Increment'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      RState.of<CounterState, CounterEvent>(context)!
                          .manager
                          .dispatch(DecrementEvent());
                    },
                    child: const Text('Decrement'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}