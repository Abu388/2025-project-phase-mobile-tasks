// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/utils/token_storage.dart';
// import '../bloc/chat_bloc.dart';
// import '../bloc/chat_event.dart';
// import '../bloc/chat_state.dart';
// import 'chat_detail_page.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});
//   static const routName = '/chatPage';

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   @override
//   void initState() {
//     super.initState();
//     _loadChats();
//   }

//   void _loadChats() {
//     context.read<ChatBloc>().add(const LoadChats());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chats')),
//       body: BlocBuilder<ChatBloc, ChatState>(
//         builder: (context, state) {
//           if (state is ChatLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ChatLoaded) {
//             final chats = state.chats;
//             if (chats.isEmpty) {
//               return const Center(child: Text("No chats available."));
//             }

//             final userId = TokenStorage().userId ?? '';

//             return ListView.builder(
//               itemCount: chats.length,
//               itemBuilder: (context, index) {
//                 final chat = chats[index];
//                 return ListTile(
//                   title: Text('${chat.user1Name} & ${chat.user2Name}'),
//                   onTap: () async {
//                     // Wait for user to return from detail page
//                     await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ChatDetailPage(
//                           chatId: chat.id,
//                           currentUserId: userId,
//                         ),
//                       ),
//                     );
//                     // Reload chats after coming back
//                     _loadChats();
//                   },
//                 );
//               },
//             );
//           } else if (state is ChatError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/token_storage.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import 'chat_detail_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static const routName = '/chatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  void _loadChats() {
    context.read<ChatBloc>().add(const LoadChats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          // Top row of avatars (Figma-inspired)
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStatusItem('My Status', Colors.green),
                  _buildStatusItem('Adi', Colors.pink),
                  _buildStatusItem('Marina', Colors.teal),
                  _buildStatusItem('Dean', Colors.orange),
                  _buildStatusItem('Max', Colors.purple),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  final chats = state.chats;
                  if (chats.isEmpty) {
                    return const Center(child: Text("No chats available."));
                  }

                  final userId = TokenStorage().userId ?? '';

                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        child: ListTile(
                          leading: const CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xFFE0F7FA), // Pastel background
                            child: Icon(Icons.person, size: 24, color: Colors.teal),
                          ),
                          title: Text(
                            '${chat.user1Name} & ${chat.user2Name}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(
                            'How are you today?', // Placeholder; replace with chat.lastMessage if available
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black87),
                          ),
                          trailing: const Text(
                            '2 min ago', // Placeholder; replace with chat.timestamp if available
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                          onTap: () async {
                            // Wait for user to return from detail page
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatDetailPage(
                                  chatId: chat.id,
                                  currentUserId: userId,
                                ),
                              ),
                            );
                            // Reload chats after coming back
                            _loadChats();
                          },
                        ),
                      );
                    },
                  );
                } else if (state is ChatError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F6FA), // Light background from Figma
    );
  }

  Widget _buildStatusItem(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(Icons.person, size: 20, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}












// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/utils/token_storage.dart';
// import '../bloc/chat_bloc.dart';
// import '../bloc/chat_event.dart';
// import '../bloc/chat_state.dart';
// import 'chat_detail_page.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});
//   static const routName = '/chatPage';

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Good: You load all chats when this page opens
//     context.read<ChatBloc>().add(const LoadChats());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chats')),
//       body: BlocBuilder<ChatBloc, ChatState>(
//         builder: (context, state) {
//           if (state is ChatLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ChatLoaded) {
//             final chats = state.chats;
//             if (chats.isEmpty) {
//               return const Center(child: Text("No chats available."));
//             }

//             final userId = TokenStorage().userId ?? '';

//             return ListView.builder(
//               itemCount: chats.length,
//               itemBuilder: (context, index) {
//                 final chat = chats[index];
//                 return ListTile(
//                   title: Text('${chat.user1Name} & ${chat.user2Name}'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ChatDetailPage(
//                           chatId: chat.id,
//                           currentUserId: userId,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           } else if (state is ChatError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
