// // import 'package:socket_io_client/socket_io_client.dart' as IO;

// // class SocketManager {
// //   static final SocketManager _instance = SocketManager._internal();
// //   late IO.Socket socket;

// //   factory SocketManager() => _instance;

// //   SocketManager._internal();

// //   void connect(String token) {
// //     socket = IO.io('https://g5-flutter-learning-path-be-tvum.onrender.com', {
// //       'transports': ['websocket'],
// //       'autoConnect': false,
// //       'extraHeaders': {
// //         'Authorization': 'Bearer $token',
// //       }
// //     });

// //     socket.connect();
// //   }

// //   void disconnect() => socket.disconnect();
// // }


// // 👈 import this
// import 'package:hello_app/core/utils/token_storage.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// class SocketService {
//   late IO.Socket socket;

//   void connect() {
//     final token = TokenStorage().token;
//     //socker_manager = socketMalin()
//     //socket_manager.connect()
//     //shered preference 
//     //v3/user

//     if (token == null) {
//       print('⚠️ No token found. Cannot connect to socket.');
//       return;
//     }

//     socket = IO.io(
//       'https://g5-flutter-learning-path-be-tvum.onrender.com',
      
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableForceNew()
//           // .enableAutoConnect()
//           .setExtraHeaders({'Authorization': 'Bearer $token'})
//           .build(),
//     );

//     socket.onConnect((_) {
//       print('✅ Socket connected');
//     });

//     socket.onDisconnect((_) {
//       print('❌ Socket disconnected from socket manager');
//     });

//     socket.onConnectError((err) {
//       print('⚠️ Connect Error: $err');
//     });

//     socket.onError((err) {
//       print('🔥 Socket Error: $err');
//     });

//     socket.connect(); // 👈 don't forget this
//   }

//   void disconnect() {
//     socket.disconnect();
//   }
// }




