import 'package:chat_u/screens/auth/models/signup.model.dart';
import 'package:chat_u/screens/auth/models/signup.res.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:convert';
import 'dart:convert';

part 'signup.service.g.dart';

@RestApi(baseUrl: 'https://p5h8zcdp-8080.inc1.devtunnels.ms/')
abstract class SignupServicve {
  factory SignupServicve(Dio dio) = _SignupServicve;

  @POST('api/v1/upload-profilepic')
  @MultiPart()
  Future<ProfilePickResponse> upload({
    @Part() required Map<String, dynamic> data,
  });
  @POST('api/v1/create-user')
  Future<Signupresponsesmodel> signup(@Body() Signupmodel body);
  @GET('api/v1/search-username/{query}')
  Future<SearchusernameRespomsed> searchusername(@Path('query') String query);
  

}

// To parse this JSON data, do
//
//     final profilePickResponse = profilePickResponseFromJson(jsonString);

ProfilePickResponse profilePickResponseFromJson(String str) =>
    ProfilePickResponse.fromJson(json.decode(str));

String profilePickResponseToJson(ProfilePickResponse data) =>
    json.encode(data.toJson());

class ProfilePickResponse {
  String data;

  ProfilePickResponse({
    required this.data,
  });

  factory ProfilePickResponse.fromJson(Map<String, dynamic> json) =>
      ProfilePickResponse(
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}


SearchusernameRespomsed searchusernameRespomsedFromJson(String str) => SearchusernameRespomsed.fromJson(json.decode(str));

String searchusernameRespomsedToJson(SearchusernameRespomsed data) => json.encode(data.toJson());

class SearchusernameRespomsed {
    String message;
    bool status;

    SearchusernameRespomsed({
        required this.message,
        required this.status,
    });

    factory SearchusernameRespomsed.fromJson(Map<String, dynamic> json) => SearchusernameRespomsed(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
