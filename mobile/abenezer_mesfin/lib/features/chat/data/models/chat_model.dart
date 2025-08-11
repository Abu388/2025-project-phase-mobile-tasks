// import '../../domain/entities/message.dart';

// class MessageModel extends Message {
//   MessageModel({
//     required super.id,
//     required super.chatId,
//     required super.content,
//     required super.type,
//     required super.senderId,
//   });

//   factory MessageModel.fromJson(Map<String, dynamic> json) {
//     return MessageModel(
//       id: json['_id'],
//       chatId: json['chat']['_id'],
//       content: json['content'],
//       type: json['type'],
//       senderId: json['sender']['_id'],
//     );
//   }
// }
import '../../domain/entities/chat.dart';

class ChatModel extends Chat {
  ChatModel({
    required String id,
    required String user1Id,
    required String user2Id,
    required String user1Name,
    required String user2Name,
  }) : super(
          id: id,
          user1Id: user1Id,
          user2Id: user2Id,
          user1Name: user1Name,
          user2Name: user2Name,
        );

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['_id'] ?? '',
      user1Id: json['user1']['_id'] ?? '',
      user2Id: json['user2']['_id'] ?? '',
      user1Name: json['user1']['name'] ?? '',
      user2Name: json['user2']['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user1': {
        '_id': user1Id,
        'name': user1Name,
      },
      'user2': {
        '_id': user2Id,
        'name': user2Name,
      },
    };
  }
}

