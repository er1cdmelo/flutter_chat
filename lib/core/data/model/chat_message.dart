class ChatMessage {
  final String id;
  final String content;
  final DateTime? sentDate;
  final int? userId;
  final int chatId;
  final MessageStatus? status;
  final ChatMessage? answeredMessage;

  ChatMessage({
    required this.id,
    required this.chatId,
    required this.content,
    this.sentDate,
    this.userId,
    this.status,
    this.answeredMessage,
  });
}

enum MessageStatus {
  sent,
  received,
  read,
  deleted,
}
