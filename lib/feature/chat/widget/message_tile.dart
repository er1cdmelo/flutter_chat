import 'package:app_testes/core/data/model/chat_message.dart';
import 'package:app_testes/global/utils.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final ChatMessage message;

  const MessageTile(this.message, {super.key});

  @override
  Widget build(context) {
    return Row(
      mainAxisAlignment:
          message.userId == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          constraints: const BoxConstraints(minWidth: 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(10),
              topLeft: const Radius.circular(10),
              bottomLeft:
                  message.userId == 1 ? const Radius.circular(10) : Radius.zero,
              bottomRight:
                  message.userId == 1 ? Radius.zero : const Radius.circular(10),
            ),
            border: Border.all(
              width: 1,
              color: message.userId == 1
                  ? const Color.fromARGB(255, 136, 233, 152)
                  : const Color.fromARGB(255, 175, 175, 175),
            ),
            color: message.userId == 1
                ? const Color.fromARGB(255, 191, 247, 179)
                : const Color.fromARGB(255, 234, 250, 230),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              message.answeredMessage != null
                  ? _buildAnswered(message.answeredMessage!)
                  : Container(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                //textDirection: TextDirection.rtl,
                children: [
                  message.isSticker && message.image != null
                      ? Container(
                          constraints: const BoxConstraints(
                            maxHeight: 250,
                            maxWidth: 200,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(message.image!),
                            ),
                          ),
                        )
                      : Text(
                          message.content,
                          style: const TextStyle(fontSize: 16),
                        ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    Utils.getTimeFromDate(message.sentDate ?? DateTime.now()),
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnswered(ChatMessage msg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color.fromARGB(123, 166, 166, 166),
      ),
      child: Row(
        children: [
          const Icon(Icons.reply),
          const SizedBox(
            width: 6,
          ),
          msg.image != null
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(msg.image!),
                    ),
                  ),
                )
              : Text(msg.content),
        ],
      ),
    );
  }
}
