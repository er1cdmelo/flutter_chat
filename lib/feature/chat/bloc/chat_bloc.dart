// ignore_for_file: avoid_print

import 'dart:async';
import 'package:app_testes/core/data/model/chat_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_testes/feature/chat/bloc/chat_event.dart';
import 'package:app_testes/feature/chat/bloc/chat_state.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final _chatStateController =
      BehaviorSubject<ChatState>.seeded(const ChatInitialState());
  final _messages = {
    "chat_id": 0,
    "list": [],
  };

  //ChatMessage? _answering;

  ChatBloc(super.initialState) {
    on<SendMessage>(_mapSendMessageEventToState);
    on<AnswerMessage>(_mapAnswerEventToState);
    on<ClearAnswer>(_mapClearAnswerEventToState);
  }

  Stream<ChatState> get output => _chatStateController.stream;
  Sink<ChatState> get input => _chatStateController.sink;

  ChatState get value => _chatStateController.value;

  final _chatEventController = StreamController<ChatEvent>();

  Sink<ChatEvent> get eventInput => _chatEventController.sink;

  void dispose() {
    _chatEventController.close();
    _chatStateController.close();
  }

  void _mapSendMessageEventToState(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    //emit(ChatNewMessage(message: event.message));
    try {
      (_messages["list"] as List).add(event.message);
      emit(ChatMessagesLoaded(
        (_messages["list"] as List)
            .map<ChatMessage>((item) => item as ChatMessage)
            .toList(),
      ));
    } catch (e) {
      print(e);
    }
  }

  void _mapAnswerEventToState(
    AnswerMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // _answering = event.answerTo;
      emit(ChatMessageAnswering(event.answerTo));
    } catch (e) {
      print(e);
    }
  }

  void _mapClearAnswerEventToState(
    ClearAnswer event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatMessageClearedAnswer());
    } catch (e) {
      print(e);
    }
  }
}
