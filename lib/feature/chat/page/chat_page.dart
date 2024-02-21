import 'package:app_testes/feature/chat/bloc/chat_bloc.dart';
import 'package:app_testes/feature/chat/bloc/chat_state.dart';
import 'package:app_testes/feature/chat/widget/message_list.dart';
import 'package:app_testes/feature/chat/widget/message_send.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(context) {
    return BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(const ChatInitialState()),
      child: const ChatPageView(),
    );
  }
}

class ChatPageView extends StatefulWidget {
  const ChatPageView({super.key});

  @override
  State createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPageView> {
  final FocusNode ctrlFocusNode = FocusNode();

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: GoogleFonts.poppins(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 101, 101, 101),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: MessageList(ctrlFocus: ctrlFocusNode),
                  ),
                ),
              ),
              MessageSend(ctrlFocus: ctrlFocusNode),
            ],
          );
        },
      )),
    );
  }
}
