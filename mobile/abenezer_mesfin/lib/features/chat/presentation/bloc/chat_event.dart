import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}
// Load all chats (no chatId needed)
class LoadChats extends ChatEvent {
  const LoadChats();
}

/// this is the block 

class LoadMessages extends ChatEvent {
  final String chatId;
  const LoadMessages(this.chatId);

  @override
  List<Object?> get props => [chatId];
}


class SendMessageEvent extends ChatEvent {
  final Message message;

  const SendMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class MessageReceivedEvent extends ChatEvent {
  final Message message;

  const MessageReceivedEvent(this.message);

  @override
  List<Object?> get props => [message];
}
