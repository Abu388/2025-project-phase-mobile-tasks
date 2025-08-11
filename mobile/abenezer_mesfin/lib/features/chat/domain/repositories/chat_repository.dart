import '../entities/chat.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Stream<Message> getMessages();
  Future<void> sendMessage(Message message);
  Future<List<Message>> fetchMessages(String chatId);  // <-- add this
  Future<List<Chat>> getChats();
}

