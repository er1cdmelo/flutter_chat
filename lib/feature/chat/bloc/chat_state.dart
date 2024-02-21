import 'package:app_testes/core/data/model/chat_message.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class ChatState extends Equatable {
  const ChatState([List props = const []]) : super();
}

class ChatInitialState extends ChatState {
  const ChatInitialState() : super();

  @override
  List<Object?> get props => [];
}

class ChatMessagesLoaded extends ChatState {
  final List<ChatMessage> messages;

  ChatMessagesLoaded(this.messages) : super([messages]);

  @override
  List<Object?> get props => [messages];
}

class ChatMessagesError extends ChatState {
  final String? error;

  ChatMessagesError(this.error) : super([error]);

  @override
  List<Object?> get props => [error];
}

class ChatMessagesLoading extends ChatState {
  const ChatMessagesLoading() : super();

  @override
  List<Object?> get props => [];
}

class ChatMessageAnswering extends ChatState {
  final ChatMessage answerTo;
  final String answerKey = const Uuid().v4();

  ChatMessageAnswering(this.answerTo) : super([answerTo]);

  @override
  List<Object?> get props => [answerTo, answerKey];
}

class ChatMessageClearedAnswer extends ChatState {
  ChatMessageClearedAnswer() : super([]);

  @override
  List<Object?> get props => [];
}

// class ChatNewMessage extends ChatState {
//   final ChatMessage message;

//   ChatNewMessage({required this.message}) : super([message]);

//   @override
//   List<Object?> get props => [message];
// }
