part of utils;

typedef void EmptyCallback();

class Notificator {
  List<EmptyCallback> _stack = [];

  void register(void callback()) {
    _stack.add(callback);
  }

  void add(void callback()) {
    _stack.add(callback);
  }

  void unregister(void callback()) {
    _stack.remove(callback);
  }

  void remove(void callback()) {
    _stack.remove(callback);
  }

  void notify() {
    for (EmptyCallback callback in new List<EmptyCallback>.unmodifiable(_stack)) {
      callback();
    }
  }

  void clear() {
    _stack.clear();
  }
}

class LazyNotificator extends Notificator {
  EmptyCallback onFirstAdd;
  bool _first = true;
  LazyNotificator(this.onFirstAdd);

  @override
  void register(void callback()) {
    _stack.add(callback);
    if (_first) {
      onFirstAdd();
      _first = false;
    }
  }

  @override
  void add(void callback()) {
    _stack.add(callback);
    if (_first) {
      onFirstAdd();
      _first = false;
    }
  }
}

typedef void _ValueCallback<S>(S s);

class ValueNotificator<T> {
  List<_ValueCallback> _stack = [];
  void register(void callback(T value)) {
    _stack.add(callback);
  }

  void add(void callback(T value)) {
    _stack.add(callback);
  }

  void unregister(void callback(T value)) {
    _stack.remove(callback);
  }

  void remove(void callback(T value)) {
    _stack.remove(callback);
  }

  void notify(T value) {
    for (_ValueCallback callback in new List<_ValueCallback>.unmodifiable(_stack)) {
      callback(value);
    }
  }

  void clear() {
    _stack.clear();
  }
}
