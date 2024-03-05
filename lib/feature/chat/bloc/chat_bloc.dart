import 'package:app_testes/core/data/model/chat_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_testes/feature/chat/bloc/chat_event.dart';
import 'package:app_testes/feature/chat/bloc/chat_state.dart';
import 'package:logger/logger.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final logger = Logger();
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
      logger.e(e);
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
      logger.e(e);
    }
  }

  void _mapClearAnswerEventToState(
    ClearAnswer event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatMessageClearedAnswer());
    } catch (e) {
      logger.e(e);
    }
  }
}
