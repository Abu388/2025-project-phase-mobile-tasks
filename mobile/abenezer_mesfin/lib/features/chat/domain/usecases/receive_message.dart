// import '../entities/message.dart';
// import '../repositories/chat_repository.dart';

// class ReceiveMessage {
//   final ChatRepository repository;

//   ReceiveMessage(this.repository);

//   Stream<Message> call() {
//     return repository.getMessages();
//   }
// }

import '../../../../core/socket/socket_service.dart';
// lib/features/chat/domain/usecases/receive_message.dart
import '../entities/message.dart';

class ReceiveMessage {
  Stream<Message> call() {
    return SocketService().messageStream;
  }
}
