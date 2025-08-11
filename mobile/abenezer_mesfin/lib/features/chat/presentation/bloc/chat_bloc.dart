import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/get_all_chats.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/receive_message.dart';
import '../../domain/usecases/send_message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetAllChats getAllChats;
  final GetMessages getMessages;
  final SendMessage sendMessage;
  final ReceiveMessage receiveMessage;

  final Map<String, List<Message>> _messagesByChatId = {};
  StreamSubscription<Message>? _messageSubscription;
  ChatBloc({
    required this.getAllChats,
    required this.getMessages,
    required this.sendMessage,
    required this.receiveMessage,
  }) : super(ChatInitial()) {
    on<LoadChats>(_onLoadChats);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<MessageReceivedEvent>(_onMessageReceived);

    // Listen to live socket messages and add events on new messages
    _messageSubscription = receiveMessage().listen((message) {
      add(MessageReceivedEvent(message));
    });
  }

  Future<void> _onLoadChats(LoadChats event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final chats = await getAllChats();
      emit(ChatLoaded(chats: chats, messages: []));
    } catch (e) {
      emit(ChatError('Failed to load chats: $e'));
    }
  }

  Future<void> _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    try {
      // Preserve existing chats and messages (typed correctly)
      final existingChats = state is ChatLoaded
          ? (state as ChatLoaded).chats
          : <Chat>[];
      final existingMessages = _messagesByChatId[event.chatId] ?? <Message>[];

      // Show existing messages immediately to avoid flicker
      emit(ChatLoaded(chats: existingChats, messages: existingMessages));

      // Fetch fresh messages from repo
      final messages = await getMessages(event.chatId);

      // Cache the messages by chatId
      _messagesByChatId[event.chatId] = messages;

      // Emit fresh messages
      emit(ChatLoaded(chats: existingChats, messages: messages));
    } catch (e) {
      emit(ChatError('Failed to load messages: $e'));
    }
  }

// Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
//   try {
//     final chatId = event.message.chatId;

//     // Optimistically add message locally
//     _messagesByChatId.putIfAbsent(chatId, () => []);
//     _messagesByChatId[chatId]!.add(event.message);

//     final existingChats = state is ChatLoaded ? (state as ChatLoaded).chats : <Chat>[];

//     // Emit updated state immediately so UI shows the message
//     emit(ChatLoaded(chats: existingChats, messages: List.from(_messagesByChatId[chatId]!)));

//     // Send message to server
//     await sendMessage(event.message);

//     // Don't fetch messages immediately here,
//     // wait for socket to notify new message arrival via MessageReceivedEvent

//   } catch (e) {
//     emit(ChatError('Failed to send message: $e'));
//   }
// }

Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
  try {
    final chatId = event.message.chatId;

    _messagesByChatId.putIfAbsent(chatId, () => []);
    _messagesByChatId[chatId]!.add(event.message);

    final existingChats = state is ChatLoaded ? (state as ChatLoaded).chats : <Chat>[];

    // Optimistically show message immediately
    emit(ChatLoaded(chats: existingChats, messages: List.from(_messagesByChatId[chatId]!)));

    // Send to server without fetching again
    await sendMessage(event.message);

    // Wait for socket event to add the confirmed message
  } catch (e) {
    emit(ChatError('Failed to send message: $e'));
  }
}





  void _onMessageReceived(MessageReceivedEvent event, Emitter<ChatState> emit) {
  final chatId = event.message.chatId;
  _messagesByChatId.putIfAbsent(chatId, () => []);
  _messagesByChatId[chatId]!.add(event.message);

  if (state is ChatLoaded) {
    final existingChats = (state as ChatLoaded).chats;
    emit(ChatLoaded(chats: existingChats, messages: List.from(_messagesByChatId[chatId]!)));
  }
}


  

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}


















// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/entities/chat.dart';
// import '../../domain/entities/message.dart';
// import '../../domain/usecases/get_all_chats.dart';
// import '../../domain/usecases/get_messages.dart';
// import '../../domain/usecases/receive_message.dart';
// import '../../domain/usecases/send_message.dart';
// import 'chat_event.dart';
// import 'chat_state.dart';

// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   final GetAllChats getAllChats;
//   final GetMessages getMessages; // <-- new usecase for fetching messages
//   final SendMessage sendMessage;
//   final ReceiveMessage receiveMessage;

//   final List<Message> _messages = [];
//   StreamSubscription<Message>? _messageSubscription;

//   ChatBloc({
//     required this.getAllChats,
//     required this.getMessages,
//     required this.sendMessage,
//     required this.receiveMessage,
//   }) : super(ChatInitial()) {
//     on<LoadChats>(_onLoadChats);
//     on<LoadMessages>(_onLoadMessages);
//     on<SendMessageEvent>(_onSendMessage);
//     on<MessageReceivedEvent>(_onMessageReceived);

//     // Listen to incoming socket messages
//     _messageSubscription = receiveMessage().listen((message) {
//       add(MessageReceivedEvent(message));
//     });
//   }

//   Future<void> _onLoadChats(LoadChats event, Emitter<ChatState> emit) async {
//     emit(ChatLoading());
//     try {
//       final chats = await getAllChats();
//       emit(ChatLoaded(chats: chats, messages: _messages));
//     } catch (e) {
//       emit(ChatError('Failed to load chats: $e'));
//     }
//   }

//   Future<void> _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
//     emit(ChatLoading());
//     try {
//       final messages = await getMessages(event.chatId);
//       emit(ChatLoaded(
//         chats: state is ChatLoaded ? (state as ChatLoaded).chats : [],
//         messages: messages,
//       ));
//     } catch (e) {
//       emit(ChatError('Failed to load messages: $e'));
//     }
//   }

//   Future<void> _onSendMessage(
//       SendMessageEvent event, Emitter<ChatState> emit) async {
//     try {
//       await sendMessage(event.message);
//       _messages.add(event.message);

//       if (state is ChatLoaded) {
//         emit(ChatLoaded(
//           chats: (state as ChatLoaded).chats,
//           messages: List.from(_messages),
//         ));
//       }
//     } catch (e) {
//       emit(ChatError('Failed to send message: $e'));
//     }
//   }

//   void _onMessageReceived(
//       MessageReceivedEvent event, Emitter<ChatState> emit) {
//     _messages.add(event.message);

//     if (state is ChatLoaded) {
//       emit(ChatLoaded(
//         chats: (state as ChatLoaded).chats,
//         messages: List.from(_messages),
//       ));
//     }
//   }

//   @override
//   Future<void> close() {
//     _messageSubscription?.cancel();
//     return super.close();
//   }
// }

