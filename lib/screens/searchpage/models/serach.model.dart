// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);

import 'dart:convert';

SearchResult searchResultFromJson(String str) => SearchResult.fromJson(json.decode(str));

String searchResultToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
    String message;
    List<Datum> data;
    bool status;

    SearchResult({
        required this.message,
        required this.data,
        required this.status,
    });

    factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
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

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
