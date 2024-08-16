// To parse this JSON data, do
//
//     final unfollowBody = unfollowBodyFromJson(jsonString);

import 'dart:convert';

UnfollowBody unfollowBodyFromJson(String str) => UnfollowBody.fromJson(json.decode(str));

String unfollowBodyToJson(UnfollowBody data) => json.encode(data.toJson());

class UnfollowBody {
    Body body;

    UnfollowBody({
        required this.body,
    });

    factory UnfollowBody.fromJson(Map<String, dynamic> json) => UnfollowBody(
        body: Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "body": body.toJson(),
    };
}

class Body {
    String userid;
    String follower;

    Body({
        required this.userid,
        required this.follower,
    });

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        userid: json["userid"],
        follower: json["follower"],
    );

    Map<String, dynamic> toJson() => {
        "userid": userid,
        "follower": follower,
    };
}


