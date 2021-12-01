const bool isProduction = bool.fromEnvironment('dart.vm.product');

final _devEnvironment = {
  // "BASE_URL": "https://localhost:3000/"
  // "BASE_URL": "http://172.20.10.9:3000/", //work on mobile network
  "BASE_URL": "http://192.168.0.101.:3000/",
};

final _prodEnvironment = {
  //"BASE_URL": "https://localhost:3000/"
  //"BASE_URL": "http://172.20.10.9:3000/",
  "BASE_URL": "http://192.168.0.101.:3000/",
};

final environment = isProduction ? _prodEnvironment : _devEnvironment;
