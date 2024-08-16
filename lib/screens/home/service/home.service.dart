
import 'package:chat_u/screens/home/model/home.model.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'dart:convert';


part 'home.service.g.dart';

@RestApi(baseUrl: 'http://165.232.185.159:8080/')
abstract class HomeService {
  factory HomeService(Dio dio) = _HomeService;

  @GET('api/v1/get-post-random-for-home/{id}')
  Future<HomeModel> getFollowingoPosts(@Path('id') String id);
  // @GET('api/v1/get-post-random-for-home/{id}')
  // Future<HomeModel> getFollowingoPosts(@Path('id') String id);
}
