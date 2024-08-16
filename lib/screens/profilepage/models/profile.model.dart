// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    String message;
    UserProfile userProfile;
    List<UserProfile> followers;
    List<dynamic> following;
    List<Post> posts;

    ProfileModel({
        required this.message,
        required this.userProfile,
        required this.followers,
        required this.following,
        required this.posts,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        message: json["message"],
        userProfile: UserProfile.fromJson(json["userProfile"]),
        followers: List<UserProfile>.from(json["followers"].map((x) => UserProfile.fromJson(x))),
        following: List<dynamic>.from(json["following"].map((x) => x)),
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "userProfile": userProfile.toJson(),
        "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
        "following": List<dynamic>.from(following.map((x) => x)),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    };
}

class UserProfile {
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

    UserProfile({
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

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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

class Post {
    Id id;
    String userId;
    List<String> postimages;
    String songId;
    CreatedDate createdDate;
    String descriptions;
    bool postorreel;
    List<String> like;

    Post({
        required this.id,
        required this.userId,
        required this.postimages,
        required this.songId,
        required this.createdDate,
        required this.descriptions,
        required this.postorreel,
        required this.like,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: Id.fromJson(json["_id"]),
        userId: json["userId"],
        postimages: List<String>.from(json["postimages"].map((x) => x)),
        songId: json["songId"],
        createdDate: CreatedDate.fromJson(json["createdDate"]),
        descriptions: json["descriptions"],
        postorreel: json["postorreel"],
        like: List<String>.from(json["like"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "userId": userId,
        "postimages": List<dynamic>.from(postimages.map((x) => x)),
        "songId": songId,
        "createdDate": createdDate.toJson(),
        "descriptions": descriptions,
        "postorreel": postorreel,
        "like": List<dynamic>.from(like.map((x) => x)),
    };
}

class CreatedDate {
    int date;

    CreatedDate({
        required this.date,
    });

    factory CreatedDate.fromJson(Map<String, dynamic> json) => CreatedDate(
        date: json["\u0024date"],
    );

    Map<String, dynamic> toJson() => {
        "\u0024date": date,
    };
}
