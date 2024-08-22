// To parse this JSON data, do
//
//     final signupmodel = signupmodelFromJson(jsonString);

import 'dart:convert';

Signupmodel signupmodelFromJson(String str) => Signupmodel.fromJson(json.decode(str));

String signupmodelToJson(Signupmodel data) => json.encode(data.toJson());

class Signupmodel {
    String username;
    String name;
    String lastname;
    String profilepick;
    String password;
    int posts;
    List<String> followers;
    List<String> following;
    String bio;
    List<String> links;
    String anysong;
    String email;
    String phone;
    String countrycode;
    bool accounttype;

    Signupmodel({
        required this.username,
        required this.name,
        required this.lastname,
        required this.profilepick,
        required this.password,
        required this.posts,
        required this.followers,
        required this.following,
        required this.bio,
        required this.links,
        required this.anysong,
        required this.email,
        required this.phone,
        required this.countrycode,
        required this.accounttype,
    });

    factory Signupmodel.fromJson(Map<String, dynamic> json) => Signupmodel(
        username: json["username"],
        name: json["name"],
        lastname: json["lastname"],
        profilepick: json["profilepick"],
        password: json["password"],
        posts: json["posts"],
        followers: List<String>.from(json["followers"].map((x) => x)),
        following: List<String>.from(json["following"].map((x) => x)),
        bio: json["bio"],
        links: List<String>.from(json["Links"].map((x) => x)),
        anysong: json["anysong"],
        email: json["email"],
        phone: json["phone"],
        countrycode: json["countrycode"],
        accounttype: json["accounttype"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "lastname": lastname,
        "profilepick": profilepick,
        "password": password,
        "posts": posts,
        "followers": List<dynamic>.from(followers.map((x) => x)),
        "following": List<dynamic>.from(following.map((x) => x)),
        "bio": bio,
        "Links": List<dynamic>.from(links.map((x) => x)),
        "anysong": anysong,
        "email": email,
        "phone": phone,
        "countrycode": countrycode,
        "accounttype": accounttype,
    };
}
