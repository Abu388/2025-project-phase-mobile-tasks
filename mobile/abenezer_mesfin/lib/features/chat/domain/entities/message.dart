// class Message {
//   final String id;
//   final String chatId;
//   final String content;
//   final String type;
//   final String senderId;

//   Message({
//     required this.id,
//     required this.chatId,
//     required this.content,
//     required this.type,
//     required this.senderId,
//   });

//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//       id: json['id'] as String,
//       chatId: json['chatId'] as String,
//       content: json['content'] as String,
//       type: json['type'] as String,
//       senderId: json['senderId'] as String,
//     );
//   }
// }

// lib/features/chat/domain/entities/message.dart

class Message {
  final String id;
  final String chatId;
  final String content;
  final String type;
  final String senderId;

  Message({
    required this.id,
    required this.chatId,
    required this.content,
    required this.type,
    required this.senderId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      chatId: json['chatId'] ?? '',
      content: json['content'] ?? '',
      type: json['type'] ?? 'text',
      senderId: json['senderId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'content': content,
      'type': type,
      'senderId': senderId,
    };
  }
}
