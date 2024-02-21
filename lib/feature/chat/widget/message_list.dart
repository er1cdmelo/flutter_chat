import 'package:app_testes/core/data/model/chat_message.dart';
import 'package:app_testes/feature/chat/bloc/chat_bloc.dart';
import 'package:app_testes/feature/chat/bloc/chat_event.dart';
import 'package:app_testes/feature/chat/bloc/chat_state.dart';
import 'package:app_testes/feature/chat/widget/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:swipe_to/swipe_to.dart';

class MessageList extends StatefulWidget {
  final FocusNode ctrlFocus;
  const MessageList({required this.ctrlFocus, super.key});

  @override
  State createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController _scroll = ScrollController();
  List<ChatMessage>? messages;
  var logger = Logger();

  void addToAnswer(ChatMessage message) {
    try {
      context.read<ChatBloc>().add(AnswerMessage(message));
      widget.ctrlFocus.requestFocus();
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Widget build(context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatMessagesLoaded) {
          messages = state.messages;
          Future.delayed(Duration.zero, () {
            _scroll.animateTo(
              _scroll.position.maxScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          });
        }

        return messages != null
            ? _buildMessages(_scroll)
            : const Center(
                child: Text("..."),
              );
      },
    );
  }

  Widget _buildMessages(ScrollController scroll) {
    return ListView.separated(
      controller: scroll,
      itemCount: messages!.length,
      itemBuilder: (_, index) {
        return SwipeTo(
          onLeftSwipe: (details) {
            addToAnswer(messages![index]);
          },
          animationDuration: const Duration(milliseconds: 100),
          child: MessageTile(messages![index]),
        );
      },
      separatorBuilder: (_, __) {
        return const SizedBox(
          height: 4,
        );
      },
    );
  }
}
