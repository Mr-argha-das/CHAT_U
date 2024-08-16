// To parse this JSON data, do
//
//     final followResponse = followResponseFromJson(jsonString);

import 'dart:convert';

FollowResponse followResponseFromJson(String str) => FollowResponse.fromJson(json.decode(str));

String followResponseToJson(FollowResponse data) => json.encode(data.toJson());

class FollowResponse {
    String message;
    dynamic data;

    FollowResponse({
        required this.message,
        required this.data,
    });

    factory FollowResponse.fromJson(Map<String, dynamic> json) => FollowResponse(
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
    };
}
