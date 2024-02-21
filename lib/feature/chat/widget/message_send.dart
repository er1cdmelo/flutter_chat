import 'dart:math';
import 'dart:typed_data';
import 'package:app_testes/core/data/model/chat_message.dart';
import 'package:app_testes/feature/chat/bloc/chat_bloc.dart';
import 'package:app_testes/feature/chat/bloc/chat_event.dart';
import 'package:app_testes/feature/chat/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class MessageSend extends StatefulWidget {
  final FocusNode ctrlFocus;
  const MessageSend({required this.ctrlFocus, super.key});

  @override
  State createState() => _MessageSendState();
}

class _MessageSendState extends State<MessageSend> {
  final TextEditingController _msg = TextEditingController();
  ChatMessage? answerTo;
  final logger = Logger();
  Uint8List? _img;

  void sendMessage(bool isSticker) {
    if (_msg.text.isEmpty && !isSticker) return;

    ChatMessage newMessage = ChatMessage(
      id: const Uuid().v4().toString(),
      chatId: 1,
      content: _msg.text,
      userId: answerTo != null ? 1 : Random().nextInt(2),
      sentDate: DateTime.now(),
      answeredMessage: answerTo,
      isSticker: isSticker,
      image: _img,
    );

    try {
      context.read<ChatBloc>().add(SendMessage(newMessage));
      _msg.clear();
      widget.ctrlFocus.unfocus();
      answerTo = null;
    } catch (e) {
      logger.e(e);
    }
  }

  void dismissReply() {
    try {
      context.read<ChatBloc>().add(const ClearAnswer());
      answerTo = null;
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Widget build(context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatMessageAnswering) {
          answerTo = state.answerTo;
        }
        return Column(
          children: [
            answerTo != null ? _buildAnswer(answerTo!) : Container(),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _msg,
                        focusNode: widget.ctrlFocus,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                          ),
                        ),
                        contentInsertionConfiguration:
                            ContentInsertionConfiguration(
                          onContentInserted: (img) {
                            if (img.hasData) {
                              _img = img.data;
                              sendMessage(true);
                            }
                          },
                          allowedMimeTypes: [
                            "image/png", /*...*/
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 62,
                      height: 62,
                      child: IconButton(
                        onPressed: () {
                          sendMessage(false);
                        },
                        icon: const Icon(Icons.send),
                        color: Colors.white,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            // If the button is pressed, return green, otherwise blue
                            if (states.contains(MaterialState.pressed)) {
                              return const Color.fromARGB(255, 33, 148, 230);
                            }
                            return const Color.fromARGB(255, 33, 148, 242);
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnswer(ChatMessage answerTo) {
    return Dismissible(
      onDismissed: (_) => {dismissReply()},
      key: UniqueKey(),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete),
          ],
        ),
      ),
      child: ListTile(
        leading: const Icon(Icons.reply),
        trailing: IconButton(
            onPressed: dismissReply,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            )),
        title: Row(
          children: [
            answerTo.image != null
                ? Container(
                    width: 150,
                    height: 150,
                    // constraints: const BoxConstraints(
                    //   maxHeight: 150,
                    //   maxWidth: 100,
                    // ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(answerTo.image!),
                      ),
                      borderRadius: BorderRadius.circular(4),
                      color: const Color.fromARGB(255, 195, 242, 197),
                    ),
                  )
                : Text(
                    answerTo.content,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
