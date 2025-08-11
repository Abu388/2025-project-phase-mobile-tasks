import '../../domain/entities/message.dart';

class ChatMessageModel extends Message {
  ChatMessageModel({
    required String id,
    required String chatId,
    required String senderId,
    required String content,
    required String type,
  }) : super(
          id: id,
          chatId: chatId,
          senderId: senderId,
          content: content,
          type: type,
        );

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['_id'],
      chatId: json['chat']['_id'],
      senderId: json['sender']['_id'],
      content: json['content'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'content': content,
      'type': type,
    };
  }
}















// import '../../domain/entities/message.dart';

// class MessageModel extends Message {
//   MessageModel({
//     required String id,
//     required String chatId,
//     required String senderId,
//     required String content,
//     required String type,
//   }) : super(
//           id: id,
//           chatId: chatId,
//           senderId: senderId,
//           content: content,
//           type: type,
//         );

//   factory MessageModel.fromJson(Map<String, dynamic> json) {
//     return MessageModel(
//       id: json['_id'],
//       chatId: json['chat']['_id'],
//       senderId: json['sender']['_id'],
//       content: json['content'],
//       type: json['type'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'chatId': chatId,
//       'content': content,
//       'type': type,
//     };
//   }
// }


