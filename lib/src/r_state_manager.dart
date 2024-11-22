
typedef EventHandler<E, S> = S Function(S currentState, E event);

abstract class RStateManager<S, E> {
  S _state;
  final List<Function(S)> _listeners = [];
  final EventHandler<E, S> _handleEvent;

  RStateManager(this._state, this._handleEvent);

  S get state => _state;

  void dispatch(E event) {
    final newState = _handleEvent(_state, event);
    if (newState != _state) {
      _state = newState;
      _notifyListeners();
    }
  }

  void addListener(Function(S) listener) {
    _listeners.add(listener);
  }

  void removeListener(Function(S) listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener(_state);
    }
  }
}
