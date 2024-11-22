typedef EventHandler<E, S> = S Function(S currentState, E event);

/// The base class for managing state and handling events.
abstract class RStateManager<S, E> {
  S _state;
  final List<Function(S)> _listeners = [];
  final EventHandler<E, S> _handleEvent;

  /// Constructor takes an initial state and event handler
  RStateManager(this._state, this._handleEvent);

  /// Public getter for the current state
  S get state => _state;

  /// Public setter for the state
  set state(S newState) {
    if (_state != newState) {
      _state = newState;
      _notifyListeners();
    }
  }

  /// Dispatch an event and update the state based on the event handler.
  void dispatch(E event) {
    final newState = _handleEvent(_state, event);
    if (newState != _state) {
      _state = newState;
      _notifyListeners();
    }
  }

  /// Add a listener that will be notified whenever the state changes.
  void addListener(Function(S) listener) {
    _listeners.add(listener);
  }

  /// Remove a listener.
  void removeListener(Function(S) listener) {
    _listeners.remove(listener);
  }

  /// Notify all listeners about the state change.
  void _notifyListeners() {
    for (var listener in _listeners) {
      listener(_state);
    }
  }
}
