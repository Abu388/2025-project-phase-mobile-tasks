// lib/core/socket/socket_service.dart
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../features/chat/domain/entities/message.dart';
import '../utils/token_storage.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket _socket;
  final _messageController = StreamController<Message>.broadcast();

  factory SocketService() => _instance;

  SocketService._internal();

  Future<void> connect() async {
    final token = await TokenStorage.getToken(); // ✅ async token retrieval
    if (token == null || token.isEmpty) {
      throw Exception('No token found, cannot connect to socket.');
    } // Already stored after login2
    _socket = IO.io(
      'https://g5-flutter-learning-path-be-tvum.onrender.com', // replace with your backend socket URL
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setQuery({'token': token}) // if backend uses auth token in query
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      print('✅ Connected to socket server');
    });

    _socket.onDisconnect((_) {
      print('❌ Disconnected from socket server');
    });

    _socket.on('message', (data) {
      print('📩 Incoming message: $data');
      try {
        final msg = Message.fromJson(Map<String, dynamic>.from(data));
        _messageController.add(msg);
      } catch (e) {
        print('Error parsing message: $e');
      }
    });
  }

  void sendMessage(Message message) {
    _socket.emit('message', message.toJson());
  }

  Stream<Message> get messageStream => _messageController.stream;

  void dispose() {
    _messageController.close();
    _socket.dispose();
  }
}























// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import '../../features/chat/domain/entities/message.dart';
// import '../utils/token_storage.dart';

// class SocketService {
//   IO.Socket? _socket;

//   /// Fetch chat messages from the backend for a given chat ID
//   Future<List<Message>> getChatMessages(String chatId) async {
//     final token = await TokenStorage.getToken();

//     final response = await http.get(
//       Uri.parse(
//         'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v3/messages/chat/$chatId',
//       ),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body) as List;
//       return data.map((e) => Message.fromJson(e)).toList();
//     } else {
//       throw Exception(
//         'Failed to load messages: ${response.statusCode} - ${response.body}',
//       );
//     }
//   }

//   /// Connect to the socket server
//   Future<void> connect() async {
//     final token = await TokenStorage.getToken();

//     _socket = IO.io(
//       'https://g5-flutter-learning-path-be-tvum.onrender.com', // backend socket URL
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .setQuery({'token': token})
//           .enableReconnection() // auto reconnect
//           .build(),
//     );

//     _socket!.onConnect((_) => print('✅ Socket connected'));
//     _socket!.onDisconnect((_) => print('❌ Socket disconnected'));
//   }

//   /// Listen to incoming messages
//   void listenToMessages(void Function(dynamic) onMessage) {
//     _socket?.on('message:received', onMessage);
//   }

//   /// Send a message
//   void sendMessage(String chatId, String text) {
//     _socket?.emit('message:send', {
//       'chatId': chatId,
//       'content': text,
//     });
//   }

//   /// Dispose the socket
//   void dispose() {
//     _socket?.dispose();
//   }
// }























// // // 👈 import this
// // import 'package:hello_app/core/utils/token_storage.dart';
// // import 'package:socket_io_client/socket_io_client.dart' as IO;
// // class SocketService {
// //   late IO.Socket socket;

// //   void connect() {
// //     final token = TokenStorage().token;
// //     //socker_manager = socketMalin()
// //     //socket_manager.connect()
// //     //shered preference 
// //     //v3/user

// //     if (token == null) {
// //       print('⚠️ No token found. Cannot connect to socket.');
// //       return;
// //     }

// //     socket = IO.io(
// //       'https://g5-flutter-learning-path-be-tvum.onrender.com',
      
// //       IO.OptionBuilder()
// //           .setTransports(['websocket'])
// //           .enableForceNew()
// //           // .enableAutoConnect()
// //           .setExtraHeaders({'Authorization': 'Bearer $token'})
// //           .build(),
// //     );

// //     socket.onConnect((_) {
// //       print('✅ Socket connected');
// //     });

// //     socket.onDisconnect((_) {
// //       print('❌ Socket disconnected');
// //     });

// //     socket.onConnectError((err) {
// //       print('⚠️ Connect Error: $err');
// //     });

// //     socket.onError((err) {
// //       print('🔥 Socket Error: $err');
// //     });

// //     socket.connect(); // 👈 don't forget this
// //   }

// //   void disconnect() {
// //     socket.disconnect();
// //   }
// // }

// // //mameo@gmail.com , mameo



