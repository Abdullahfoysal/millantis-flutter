const bool isProduction = bool.fromEnvironment('dart.vm.product');

final _devEnvironment = {
  // "BASE_URL": "http://localhost:3000/",
  "BASE_URL": "http://192.168.0.107:3000/",
};

final _prodEnvironment = {
  // "BASE_URL": "http://localhost:3000/",
  "BASE_URL": "http://192.168.0.107:3000/",
};

final environment = isProduction ? _prodEnvironment : _devEnvironment;
