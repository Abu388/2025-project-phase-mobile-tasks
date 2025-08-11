// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;

// import 'core/socket/socket_service.dart';
// import 'core/utils/token_storage.dart';
// import 'features/chat/data/datasources/chat_remote_datasource.dart';
// import 'features/chat/data/repositories/chat_repository_impl.dart';
// import 'features/chat/domain/usecases/get_all_chats.dart';
// import 'features/chat/domain/usecases/receive_message.dart';
// import 'features/chat/domain/usecases/send_message.dart';
// import 'features/chat/presentation/bloc/chat_bloc.dart';
// import 'features/chat/presentation/pages/chat_page.dart';

// void main() {
//   runApp(const ChatApp());
// }

// class ChatApp extends StatelessWidget {
//   const ChatApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final httpClient = http.Client();
//     final tokenStorage = TokenStorage();

//     // Make sure class name matches your actual datasource class:
//     final chatRemoteDatasource = ChatRemoteDatasource();

//     final chatRepository = ChatRepositoryImpl(remoteDatasource: chatRemoteDatasource);

//     final socketService = SocketService(); // Singleton, no params

//     final getAllChats = GetAllChats(chatRepository);
//     final sendMessage = SendMessage(chatRepository);
//     final receiveMessage = ReceiveMessage();

//     final chatBloc = ChatBloc(
//       getAllChats: getAllChats,
//       sendMessage: sendMessage,
//       receiveMessage: receiveMessage,
//     );

//     return BlocProvider(
//       create: (_) => chatBloc,
//       child: MaterialApp(
//         title: 'Chat Feature Demo',
//         debugShowCheckedModeBanner: false,
//         home: const ChatPage(),
//       ),
//     );
//   }
// }














// // import 'package:flutter/material.dart';
// // import 'features/chat/data/datasources/chat_remote_datasource.dart'; // adjust the path as needed

// // void main() {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   final chatService = ChatRemoteDatasource();
// //   // Replace this with your actual JWT token from the login response
// //   chatService.initSocket('your_real_jwt_token_here');

// //   runApp(const MaterialApp(
// //     home: Scaffold(
// //       body: Center(
// //         child: Text("🧪 Testing socket connection..."),
// //       ),
// //     ),
// //   ));
// // }




// // import 'package:flutter/material.dart';

// // import 'features/chat/data/datasources/chat_remote_datasource.dart';
// // import 'features/chat/data/models/message_model.dart';


// // void main() {
// //   runApp(ChatApp());
// // }

// // class ChatApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Socket Chat',
// //       home: MainChatPage(),
// //     );
// //   }
// // }

// // class MainChatPage extends StatefulWidget {
// //   @override
// //   _MainChatPageState createState() => _MainChatPageState();
// // }

// // class _MainChatPageState extends State<MainChatPage> {
// //   final ChatRemoteDatasource chatRemoteDatasource = ChatRemoteDatasource();
// //   final TextEditingController _controller = TextEditingController();
// //   final List<MessageModel> messages = [];

// //   @override
// //   void initState() {
// //     super.initState();

// //     // 🔐 Replace with your actual token (from login API)
// //     const token = 'your_real_jwt_token_here';
// //     chatRemoteDatasource.initSocket(token);

// //     // 👂 Listen to incoming messages
// //     chatRemoteDatasource.messageStream.listen((message) {
// //       setState(() {
// //         messages.add(message);
// //       });
// //     });
// //   }

// //   void _sendMessage() {
// //     if (_controller.text.trim().isEmpty) return;

// //     // You should replace these dummy values with real ones from your app
// //     final message = MessageModel(
// //       id: '',
// //       chatId: 'chat123',
// //       senderId: 'user123',
// //       content: _controller.text.trim(),
// //       type: 'text',
// //     );

// //     chatRemoteDatasource.sendMessage(message);
// //     _controller.clear();
// //   }

// //   @override
// //   void dispose() {
// //     chatRemoteDatasource.dispose();
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Real-Time Chat")),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: messages.length,
// //               itemBuilder: (_, index) {
// //                 final msg = messages[index];
// //                 return ListTile(
// //                   title: Text(msg.content),
// //                   subtitle: Text('Sender: ${msg.senderId}'),
// //                 );
// //               },
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(12.0),
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     controller: _controller,
// //                     decoration:
// //                         InputDecoration(hintText: 'Type a message...'),
// //                   ),
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.send),
// //                   onPressed: _sendMessage,
// //                 )
// //               ],
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
