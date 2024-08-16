// To parse this JSON data, do
//
//     final unfollowResponse = unfollowResponseFromJson(jsonString);

import 'dart:convert';

UnfollowResponse unfollowResponseFromJson(String str) => UnfollowResponse.fromJson(json.decode(str));

String unfollowResponseToJson(UnfollowResponse data) => json.encode(data.toJson());

class UnfollowResponse {
    String message;
    dynamic data;

    UnfollowResponse({
        required this.message,
        required this.data,
    });

    factory UnfollowResponse.fromJson(Map<String, dynamic> json) => UnfollowResponse(
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
    };
}
