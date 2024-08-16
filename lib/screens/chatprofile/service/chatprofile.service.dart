import 'package:chat_u/screens/chatprofile/model/chat.body.dart';
import 'package:chat_u/screens/chatprofile/model/chatprofile.body.dart';
import 'package:chat_u/screens/chatprofile/model/chatprofile.model.dart';
import 'package:chat_u/screens/chatprofile/model/chatprofile.res.dart';
import 'package:chat_u/screens/chatprofile/model/chats.model.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'dart:convert';


part 'chatprofile.service.g.dart';

@RestApi(baseUrl: 'http://165.232.185.159:8080/')
abstract class ChatPrfoleService {
  factory ChatPrfoleService(Dio dio) = _ChatPrfoleService;

  @GET('api/v1/chat-profile-get/{id}')
  Future<ChatProfileModel> getProfileGet(@Path('id') String id);
  @GET('api/v1/chat_history/{user1}/{user2}')
  Future<ChatsModel> chats(@Path('user1') String user1, @Path('user2') String user2);
  @POST('api/v1/send-chat')
  Future<ChatsEndResponse> sendMessage(@Body() ChatSendBody body);
  @POST('api/v1/chat-profile-create')
  Future<SendChatProfileResponse> sendChatProfile(@Body() SendChatProfileBody body);


}

