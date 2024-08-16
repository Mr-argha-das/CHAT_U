// To parse this JSON data, do
//
//     final chatsModel = chatsModelFromJson(jsonString);

import 'dart:convert';

ChatsModel chatsModelFromJson(String str) => ChatsModel.fromJson(json.decode(str));

String chatsModelToJson(ChatsModel data) => json.encode(data.toJson());

class ChatsModel {
    String message;
    List<Datum> data;

    ChatsModel({
        required this.message,
        required this.data,
    });

    factory ChatsModel.fromJson(Map<String, dynamic> json) => ChatsModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String senderId;
    String receiverId;
    String message;
    String timestamp;

    Datum({
        required this.senderId,
        required this.receiverId,
        required this.message,
        required this.timestamp,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "timestamp": timestamp,
    };
}
