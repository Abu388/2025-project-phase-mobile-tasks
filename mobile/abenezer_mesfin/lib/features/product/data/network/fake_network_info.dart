import 'network_info.dart';

class FakeNetworkInfo implements NetworkInfo {
  final bool connected;

  FakeNetworkInfo({this.connected = true});

  @override
  Future<bool> get isConnected async => connected;
}
