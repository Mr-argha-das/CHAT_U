// To parse this JSON data, do
//
//     final chatProfileModel = chatProfileModelFromJson(jsonString);

import 'dart:convert';

ChatProfileModel chatProfileModelFromJson(String str) => ChatProfileModel.fromJson(json.decode(str));

String chatProfileModelToJson(ChatProfileModel data) => json.encode(data.toJson());

class ChatProfileModel {
    String message;
    List<Datum> data;
    bool status;

    ChatProfileModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory ChatProfileModel.fromJson(Map<String, dynamic> json) => ChatProfileModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    Chatprofile chatprofile;
    Userprofile userprofile;
    List<dynamic> blocked;
    String blockedby;

    Datum({
        required this.chatprofile,
        required this.userprofile,
        required this.blocked,
        required this.blockedby,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chatprofile: Chatprofile.fromJson(json["chatprofile"]),
        userprofile: Userprofile.fromJson(json["userprofile"]),
        blocked: List<dynamic>.from(json["blocked"].map((x) => x)),
        blockedby: json["blockedby"],
    );

    Map<String, dynamic> toJson() => {
        "chatprofile": chatprofile.toJson(),
        "userprofile": userprofile.toJson(),
        "blocked": List<dynamic>.from(blocked.map((x) => x)),
        "blockedby": blockedby,
    };
}

class Chatprofile {
    Id id;
    String senderId;
    String reseverid;
    bool status;
    bool active;
    String reseverStatus;
    String senderStatus;
    bool senderTyping;
    bool reseverTyping;

    Chatprofile({
        required this.id,
        required this.senderId,
        required this.reseverid,
        required this.status,
        required this.active,
        required this.reseverStatus,
        required this.senderStatus,
        required this.senderTyping,
        required this.reseverTyping,
    });

    factory Chatprofile.fromJson(Map<String, dynamic> json) => Chatprofile(
        id: Id.fromJson(json["_id"]),
        senderId: json["senderId"],
        reseverid: json["reseverid"],
        status: json["status"],
        active: json["active"],
        reseverStatus: json["reseverStatus"],
        senderStatus: json["senderStatus"],
        senderTyping: json["senderTyping"],
        reseverTyping: json["reseverTyping"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "senderId": senderId,
        "reseverid": reseverid,
        "status": status,
        "active": active,
        "reseverStatus": reseverStatus,
        "senderStatus": senderStatus,
        "senderTyping": senderTyping,
        "reseverTyping": reseverTyping,
    };
}

class Id {
    String oid;

    Id({
        required this.oid,
    });

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
    );

    Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
    };
}

class Userprofile {
    Id id;
    String username;
    String password;
    String email;
    String phone;
    String countrycode;
    String name;
    String lastname;
    String profilepick;
    int posts;
    List<String> followers;
    List<String> following;
    String bio;
    List<String> links;
    String anysong;
    bool status;
    bool accounttype;

    Userprofile({
        required this.id,
        required this.username,
        required this.password,
        required this.email,
        required this.phone,
        required this.countrycode,
        required this.name,
        required this.lastname,
        required this.profilepick,
        required this.posts,
        required this.followers,
        required this.following,
        required this.bio,
        required this.links,
        required this.anysong,
        required this.status,
        required this.accounttype,
    });

    factory Userprofile.fromJson(Map<String, dynamic> json) => Userprofile(
        id: Id.fromJson(json["_id"]),
        username: json["username"],
        password: json["password"],
        email: json["email"],
        phone: json["phone"],
        countrycode: json["countrycode"],
        name: json["name"],
        lastname: json["lastname"],
        profilepick: json["profilepick"],
        posts: json["posts"],
        followers: List<String>.from(json["followers"].map((x) => x)),
        following: List<String>.from(json["following"].map((x) => x)),
        bio: json["bio"],
        links: List<String>.from(json["Links"].map((x) => x)),
        anysong: json["anysong"],
        status: json["status"],
        accounttype: json["accounttype"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "username": username,
        "password": password,
        "email": email,
        "phone": phone,
        "countrycode": countrycode,
        "name": name,
        "lastname": lastname,
        "profilepick": profilepick,
        "posts": posts,
        "followers": List<dynamic>.from(followers.map((x) => x)),
        "following": List<dynamic>.from(following.map((x) => x)),
        "bio": bio,
        "Links": List<dynamic>.from(links.map((x) => x)),
        "anysong": anysong,
        "status": status,
        "accounttype": accounttype,
    };
}
