// ignore_for_file: must_be_immutable

import 'package:app_testes/core/data/model/chat_message.dart';
import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent([List props = const []]) : super();
}

class GetMessages extends ChatEvent {
  List<ChatMessage> messages;

  GetMessages(this.messages) : super([messages]);

  @override
  List<Object?> get props => [messages];
}

class SendMessage extends ChatEvent {
  ChatMessage message;

  SendMessage(this.message) : super([message]);

  @override
  List<Object?> get props => [message];
}

class AnswerMessage extends ChatEvent {
  ChatMessage answerTo;

  AnswerMessage(this.answerTo) : super([answerTo]);

  @override
  List<Object?> get props => [answerTo];
}

class ClearAnswer extends ChatEvent {
  const ClearAnswer() : super();

  @override
  List<Object?> get props => [];
}
