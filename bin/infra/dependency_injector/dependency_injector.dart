typedef T InstanceCreator<T>();

class DependencyInjector {
  DependencyInjector._();
  static final _singleton = DependencyInjector._();
  factory DependencyInjector() => _singleton;
  // Mapa de Instância =  criação de um objeto, o resultado de um new object
  final _instanceMap = Map<Type, _InstanceGenerator<Object>>();

  // Register 18:20
  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = false,
  }) =>
      _instanceMap[T] = _InstanceGenerator(instance, isSingleton);

  // Get
  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) return instance;
    throw Exception('[ERROR] -> Instance ${T.toString()} not found');
  }
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;

  final InstanceCreator<T> _instanceCreator;
  _InstanceGenerator(this._instanceCreator, bool isSingleton)
      : _isFirstGet = isSingleton;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    return _instance != null ? _instance : _instanceCreator();
  }
}