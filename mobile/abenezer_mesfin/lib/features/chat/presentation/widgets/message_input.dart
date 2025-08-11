import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/message.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import 'package:uuid/uuid.dart';

class MessageInput extends StatefulWidget {
  final String currentUserId;
  final String chatId;

  const MessageInput({
    super.key,
    required this.currentUserId,
    required this.chatId,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _controller = TextEditingController();
  final _uuid = const Uuid();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final message = Message(
      id: _uuid.v4(),
      chatId: widget.chatId,
      senderId: widget.currentUserId,
      content: text,
      type: 'text', // You can expand this later for images, audio, etc.
    );

    context.read<ChatBloc>().add(SendMessageEvent(message));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Type your message...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: _sendMessage,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
