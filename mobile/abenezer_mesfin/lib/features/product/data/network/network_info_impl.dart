import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker = InternetConnectionChecker.instance;

  NetworkInfoImpl();

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
