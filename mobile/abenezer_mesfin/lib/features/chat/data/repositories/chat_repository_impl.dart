import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/utils/token_storage.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource remoteDatasource;
  final http.Client httpClient;
  // fetchMessages
  
  ChatRepositoryImpl({
    required this.remoteDatasource,
    required this.httpClient,
  });

  Future<String> _getTokenOrThrow() async {
    final token = await TokenStorage.getToken();
    print('Debug token fetched from storage: $token');
    if (token == null || token.isEmpty) {
      throw Exception('No token found, user might not be logged in.');
    } // Error: Failed to load chats: Exception: No tocken found,  user might not be logged in
    return token;
  }

  Future<void> initializeSocket() async {
    final token = await _getTokenOrThrow();
    remoteDatasource.initSocket(token);
  }

  @override
  Stream<Message> getMessages() {
    return remoteDatasource.messageStream;
  }
  @override
Future<List<Message>> fetchMessages(String chatId) async {
  final token = await _getTokenOrThrow();
  final chatMessages = await remoteDatasource.fetchMessages(token, chatId);
  // Convert List<ChatMessageModel> to List<Message> if needed (they extend Message, so it's fine)
  return chatMessages;
}

  @override
  Future<void> sendMessage(Message message) async {
    // same check if needed
    final token = await _getTokenOrThrow();

    if (message is ChatMessageModel) {
      remoteDatasource.sendMessage(message);
    } else {
      final msgModel = ChatMessageModel(
        id: message.id,
        chatId: message.chatId,
        senderId: message.senderId,
        content: message.content,
        type: message.type,
      );
      remoteDatasource.sendMessage(msgModel);
    }
  }

  @override
  Future<List<Chat>> getChats() async {
    final token = await _getTokenOrThrow();
    final chatModels = await remoteDatasource.fetchChats(token);
    return chatModels;
  }
  Future<List<Message>> fetchChatMessages(String chatId) async {
  final token = await _getTokenOrThrow();
  final url = Uri.parse(
    'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v3/chats/$chatId/messages',
  );

  final response = await httpClient.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201 ) {
    final jsonBody = json.decode(response.body);
    final List data = jsonBody['data'];
    return data.map((m) {
      return Message(
        id: m['_id'] ?? '',
        chatId: m['chat']['_id'] ?? '',
        content: m['content'] ?? '',
        type: m['type'] ?? 'text',
        senderId: m['sender']['_id'] ?? '',
      );
    }).toList();
  } else {
    throw Exception('Failed to fetch chat messages: ${response.body}');
  }
}

}





















































// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import '../../../../core/utils/token_storage.dart';
// import '../../domain/entities/chat.dart';
// import '../../domain/entities/message.dart';
// import '../../domain/repositories/chat_repository.dart';
// import '../datasources/chat_remote_datasource.dart';
// import '../models/chat_model.dart';
// import '../models/message_model.dart';


// class ChatRepositoryImpl implements ChatRepository {
//   final ChatRemoteDatasource remoteDatasource;
//   final TokenStorage tokenStorage; // ✅ Inject token storage

//   ChatRepositoryImpl({
//     required this.remoteDatasource,
//     required this.tokenStorage,
//   });

//   @override
//   Stream<Message> getMessages() {
//     return remoteDatasource.messageStream;
//   }

//   @override
//   Future<void> sendMessage(Message message) async {
//     if (message is ChatMessageModel) {
//       remoteDatasource.sendMessage(message);
//     } else {
//       final msgModel = ChatMessageModel(
//         id: message.id,
//         chatId: message.chatId,
//         senderId: message.senderId,
//         content: message.content,
//         type: message.type,
//       );
//       remoteDatasource.sendMessage(msgModel);
//     }
//   }

//  @override
// Future<List<Chat>> getChats() async {
//   final token = await tokenStorage.getToken(); // ✅ call static method directly

//   final url = Uri.parse(
//       'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v3/chats');

//   final response = await http.get(url, headers: {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $token',
//   });

//   if (response.statusCode == 200 || response.statusCode == 201) {
//     final jsonData = jsonDecode(response.body);
//     final List<dynamic> chatList = jsonData['data'];

//     return chatList.map((chatJson) => ChatModel.fromJson(chatJson)).toList();
//   } else {
//     throw Exception(
//         'Failed to load chats. Status code: ${response.statusCode}');
//   }
// }

// }
































// // lib/features/chat/data/repositories/chat_repository_impl.dart
// import '../../../../core/utils/token_storage.dart';
// import '../../domain/entities/chat.dart';
// import '../../domain/entities/message.dart';
// import '../../domain/repositories/chat_repository.dart';
// import '../datasources/chat_remote_datasource.dart';
// import '../models/chat_model.dart';
// import '../models/message_model.dart';

// class ChatRepositoryImpl implements ChatRepository {
//   final ChatRemoteDatasource remoteDatasource;
  
//   ChatRepositoryImpl({
//     required this.remoteDatasource,
//     required this.tokenStorage,
//   });
//   final TokenStorage tokenStorage; // add this to access token
//   @override
//   Stream<Message> getMessages() {
//     // Stream<ChatMessageModel> -> Stream<Message>
//     return remoteDatasource.messageStream;
//   }

//   @override
//   Future<void> sendMessage(Message message) async {
//     // Convert Message to ChatMessageModel if needed
//     if (message is ChatMessageModel) {
//       remoteDatasource.sendMessage(message);
//     } else {
//       // create ChatMessageModel from Message
//       final msgModel = ChatMessageModel(
//         id: message.id,
//         chatId: message.chatId,
//         senderId: message.senderId,
//         content: message.content,
//         type: message.type,
//       );
//       remoteDatasource.sendMessage(msgModel);
//     }
//   }

//   @override
//   Future<List<Chat>> getChats() async {
//     // TODO: Implement actual chat fetching from API if exists
//     // For now, return empty list or implement API call
//      final token = tokenStorage.token;
//     if (token == null) throw Exception('No token found');

//     final chatModels = await remoteDatasource.fetchChats(token);
//     return chatModels;
//   }
// }
