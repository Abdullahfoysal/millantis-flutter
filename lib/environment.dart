const bool isProduction = bool.fromEnvironment('dart.vm.product');

final _devEnvironment = {
  "BASE_URL": "https://127.0.0.1:5000/",
};

final _prodEnvironment = {
  "BASE_URL": "https://127.0.0.1:5000/",
};

final environment = isProduction ? _prodEnvironment : _devEnvironment;
