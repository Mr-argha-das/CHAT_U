
import 'package:chat_u/screens/profilepage/models/follow.body.dart';
import 'package:chat_u/screens/profilepage/models/follow.res.dart';
import 'package:chat_u/screens/profilepage/models/profile.model.dart';
import 'package:chat_u/screens/profilepage/models/unfollow.res.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'dart:convert';

part 'profile.service.g.dart';

@RestApi(baseUrl: 'http://165.232.185.159:8080/')
abstract class ProfileService {
  factory ProfileService(Dio dio) = _ProfileService;

  @GET('api/v1/user-profile-data/{id}')
  Future<ProfileModel> searchUser(@Path('id') String id);
  @POST('api/v1/follow-user')
  Future<FollowResponse> followuser(@Body() FollowBodyModel body);


}


