// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../domain/entities/message.dart';

// import '../bloc/chat_bloc.dart';
// import '../bloc/chat_event.dart';
// import '../bloc/chat_state.dart';

// class ChatDetailPage extends StatefulWidget {
//   final String chatId;
//   final String currentUserId;

//   const ChatDetailPage({
//     required this.chatId,
//     required this.currentUserId,
//     super.key,
//   });

//   @override
//   State<ChatDetailPage> createState() => _ChatDetailPageState();
// }

// class _ChatDetailPageState extends State<ChatDetailPage> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Dispatch LoadMessages event here to fetch messages for this chat
//     context.read<ChatBloc>().add(LoadMessages(widget.chatId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chat Detail')),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<ChatBloc, ChatState>(
//               builder: (context, state) {
//                 if (state is ChatLoaded) {
//                   final messages = state.messages
//                       .where((msg) => msg.chatId == widget.chatId)
//                       .toList()
//                       .reversed
//                       .toList();
//                   return ListView.builder(
//                     reverse: true,
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final msg = messages[index];
//                       final isMe = msg.senderId == widget.currentUserId;
//                       return Align(
//                         alignment: isMe
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Container(
//                           padding: const EdgeInsets.all(12),
//                           margin: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: isMe ? Colors.blue[200] : Colors.grey[300],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(msg.content),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is ChatLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else {
//                   return const Center(child: Text("No messages yet."));
//                 }
//               },
//             ),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration: const InputDecoration(hintText: "Type a message..."),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send),
//             onPressed: () {
//               final text = _controller.text.trim();
//               if (text.isNotEmpty) {
//                 context.read<ChatBloc>().add(
//                   SendMessageEvent(
//                     Message(
//                       id: UniqueKey().toString(),
//                       chatId: widget.chatId,
//                       content: text,
//                       type: "text",
//                       senderId: widget.currentUserId,
//                     ),
//                   ),
//                 );
//                 _controller.clear();
//                 //
//                 // Reload messages explicitly
//                 context.read<ChatBloc>().add(LoadMessages(widget.chatId));
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/message.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

class ChatDetailPage extends StatefulWidget {
  final String chatId;
  final String currentUserId;

  const ChatDetailPage({
    required this.chatId,
    required this.currentUserId,
    super.key,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Dispatch LoadMessages event here to fetch messages for this chat
    context.read<ChatBloc>().add(LoadMessages(widget.chatId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ermi & tsion gashaw',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 10, color: Colors.green),
                const SizedBox(width: 4),
                const Text('online', style: TextStyle(color: Colors.black54, fontSize: 12)),
                IconButton(
                  icon: const Icon(Icons.call, color: Colors.black54),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoaded) {
                  final messages = state.messages
                      .where((msg) => msg.chatId == widget.chatId)
                      .toList()
                      .reversed
                      .toList();
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isMe = msg.senderId == widget.currentUserId;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            if (!isMe)
                              const CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFFF8D7DA), // Pastel pink
                                child: Icon(Icons.person, size: 16, color: Colors.pink),
                              ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment:
                                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: isMe ? const Color(0xFFADD8E6) : const Color(0xFFF0F0F0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(msg.content),
                                  ),
                                  Text(
                                    '09:24 AM', // Placeholder; replace with msg.timestamp if available
                                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            if (isMe)
                              const CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFFB3E5FC), // Pastel blue
                                child: Icon(Icons.person, size: 16, color: Colors.blue),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text("No messages yet."));
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.black54),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Write your message",
                      filled: true,
                      fillColor: const Color(0xFFF5F6FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      context.read<ChatBloc>().add(
                        SendMessageEvent(
                          Message(
                            id: UniqueKey().toString(),
                            chatId: widget.chatId,
                            content: text,
                            type: "text",
                            senderId: widget.currentUserId,
                          ),
                        ),
                      );
                      _controller.clear();
                      //
                      // Reload messages explicitly
                      context.read<ChatBloc>().add(LoadMessages(widget.chatId));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F6FA), // Light background from Figma
    );
  }

  Widget _buildMessageInput() {
    return Container();
  }
}