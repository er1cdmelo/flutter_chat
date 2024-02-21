import 'dart:typed_data';

class ChatMessage {
  final String id;
  final String content;
  final DateTime? sentDate;
  final int? userId;
  final int chatId;
  final MessageStatus? status;
  final ChatMessage? answeredMessage;
  final bool isSticker;
  final Uint8List? image;

  ChatMessage({
    required this.id,
    required this.chatId,
    required this.content,
    required this.isSticker,
    this.sentDate,
    this.userId,
    this.status,
    this.answeredMessage,
    this.image,
  });
}

enum MessageStatus {
  sent,
  received,
  read,
  deleted,
}
