import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'core/socket/socket_service.dart';
import 'core/utils/token_storage.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/chat/data/datasources/chat_remote_datasource.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/domain/usecases/get_all_chats.dart';
import 'features/chat/domain/usecases/get_messages.dart';
import 'features/chat/domain/usecases/receive_message.dart';
import 'features/chat/domain/usecases/send_message.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/chat/presentation/pages/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure token is loaded before app starts (if already logged in)
  final token = await TokenStorage.getToken();
  if (token != null && token.isNotEmpty) {
    await SocketService().connect(); // connect socket early if already logged in
  }

  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    

    // Chat dependencies
    final chatRemoteDatasource = ChatRemoteDatasource(client: httpClient);
    final chatRepository = ChatRepositoryImpl(
      remoteDatasource: chatRemoteDatasource,
      httpClient: httpClient,
    );
    final getMessages = GetMessages(chatRepository);
    final getAllChats = GetAllChats(chatRepository);
    final sendMessage = SendMessage(chatRepository);
    final receiveMessage = ReceiveMessage();
    final chatBloc = ChatBloc(
      getAllChats: getAllChats,
      sendMessage: sendMessage,
      receiveMessage: receiveMessage,
      getMessages: getMessages,
    );

    // Auth dependencies
    final remoteDataSource = AuthRemoteDataSourceImpl(client: httpClient);
    final repository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);
    final registerUsecase = Register(repository);
    final loginUsecase = Login(repository);
    final authBloc = AuthBloc(
      registerUsecase: registerUsecase,
      loginUsecase: loginUsecase,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => authBloc),
        BlocProvider<ChatBloc>(create: (_) => chatBloc),
      ],
      child: MaterialApp(
        title: 'Auth + Chat Demo',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const LoginPage(),
          RegisterPage.routName: (context) => const RegisterPage(),
          ChatPage.routName: (context) => const ChatPage(),
        },
      ),
    );
  }
}
