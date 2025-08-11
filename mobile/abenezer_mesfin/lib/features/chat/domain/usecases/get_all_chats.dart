import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class GetAllChats {
  final ChatRepository repository;

  GetAllChats(this.repository);

  Future<List<Chat>> call() {
    return repository.getChats();
  }
  
}


