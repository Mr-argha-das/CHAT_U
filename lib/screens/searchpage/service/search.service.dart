
import 'package:chat_u/screens/home/model/home.model.dart';
import 'package:chat_u/screens/searchpage/models/serach.model.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'dart:convert';


part 'search.service.g.dart';

@RestApi(baseUrl: 'http://165.232.185.159:8080/')
abstract class SearchService {
  factory SearchService(Dio dio) = _SearchService;

  @GET('api/v1/search-profile/{query}')
  Future<SearchResult> searchUser(@Path('query') String query);
}
