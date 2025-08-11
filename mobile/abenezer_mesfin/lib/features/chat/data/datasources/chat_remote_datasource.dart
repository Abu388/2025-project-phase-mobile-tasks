import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/chat_model.dart'  ;
import '../models/message_model.dart' ;

class ChatRemoteDatasource {
  late IO.Socket socket;
  final _messageStreamController = StreamController<ChatMessageModel>.broadcast();

  Stream<ChatMessageModel> get messageStream => _messageStreamController.stream;

  void initSocket(String token) {
    socket = IO.io(
      'https://g5-flutter-learning-path-be-tvum.onrender.com',
      
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    // Register listener
    socket.on('message:received', (data) {
      final message = ChatMessageModel.fromJson(data);
      _messageStreamController.add(message);
    });

    socket.connect();
  }

  void sendMessage(ChatMessageModel message) {
    socket.emit('message:send', message.toJson());
  }

  void dispose() {
    socket.disconnect();
    _messageStreamController.close();
  }




  final String baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com';

  final http.Client client;

  ChatRemoteDatasource({required this.client});

  Future<List<ChatModel>> fetchChats(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/api/v3/chats'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> chatsJson = jsonData['data'];
      return chatsJson.map((e) => ChatModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch chats');
    }
  }
  Future<List<ChatMessageModel>> fetchMessages(String token, String chatId) async {
  final response = await client.get(
    Uri.parse('$baseUrl/api/v3/chats/$chatId/messages'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  print('Fetch messages response status: ${response.statusCode}');
  print('Fetch messages response body: ${response.body}');  // <-- Add this

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> messagesJson = jsonData['data'];
    print('Fetched messages count: ${messagesJson.length}'); // <-- and this
    return messagesJson.map((e) => ChatMessageModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch messages');
  }
}
}



