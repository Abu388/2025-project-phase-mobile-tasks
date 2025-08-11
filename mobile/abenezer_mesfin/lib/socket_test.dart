import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  const token = 'YOUR_VALID_JWT_TOKEN_HERE';

  final socket = IO.io(
    'https://g5-flutter-learning-path-be-tvum.onrender.com',
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .setExtraHeaders({'Authorization': 'Bearer $token'}) // 👈 include token here
        .build(),
  );

  socket.connect();

  socket.onConnect((_) {
    print('✅ Socket connected!');
  });

  socket.onConnectError((err) {
    print('❌ Connect error: $err');
  });

  socket.onDisconnect((_) {
    print('🔌 Socket disconnected.');
  });
}
