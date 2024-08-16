

import 'package:chat_u/screens/auth/models/login.model.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'dart:convert';


part 'login.service.g.dart';

@RestApi(baseUrl: 'http://165.232.185.159:8080/')
abstract class LoginService {
  factory LoginService(Dio dio) = _LoginService;

  @POST('api/v1/user-login-username')
  Future<LoginResponse> login(@Body() Loginbody body);
}



Loginbody loginbodyFromJson(String str) => Loginbody.fromJson(json.decode(str));

String loginbodyToJson(Loginbody data) => json.encode(data.toJson());

class Loginbody {
    String identifyer;
    String password;

    Loginbody({
        required this.identifyer,
        required this.password,
    });

    factory Loginbody.fromJson(Map<String, dynamic> json) => Loginbody(
        identifyer: json["identifyer"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "identifyer": identifyer,
        "password": password,
    };
}
