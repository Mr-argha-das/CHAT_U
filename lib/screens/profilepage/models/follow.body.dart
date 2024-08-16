// To parse this JSON data, do
//
//     final followBodyModel = followBodyModelFromJson(jsonString);

import 'dart:convert';

FollowBodyModel followBodyModelFromJson(String str) => FollowBodyModel.fromJson(json.decode(str));

String followBodyModelToJson(FollowBodyModel data) => json.encode(data.toJson());

class FollowBodyModel {
    String userid;
    String follower;

    FollowBodyModel({
        required this.userid,
        required this.follower,
    });

    factory FollowBodyModel.fromJson(Map<String, dynamic> json) => FollowBodyModel(
        userid: json["userid"],
        follower: json["follower"],
    );

    Map<String, dynamic> toJson() => {
        "userid": userid,
        "follower": follower,
    };
}
