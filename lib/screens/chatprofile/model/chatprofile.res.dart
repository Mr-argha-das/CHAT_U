// To parse this JSON data, do
//
//     final sendChatProfileResponse = sendChatProfileResponseFromJson(jsonString);

import 'dart:convert';

SendChatProfileResponse sendChatProfileResponseFromJson(String str) => SendChatProfileResponse.fromJson(json.decode(str));

String sendChatProfileResponseToJson(SendChatProfileResponse data) => json.encode(data.toJson());

class SendChatProfileResponse {
    String message;
    Data? data;
    bool status;

    SendChatProfileResponse({
        required this.message,
        required this.data,
        required this.status,
    });

    factory SendChatProfileResponse.fromJson(Map<String, dynamic> json) => SendChatProfileResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "status": status,
    };
}

class Data {
    Id id;
    String senderId;
    String reseverid;
    bool status;
    bool active;
    String reseverStatus;
    String senderStatus;
    bool senderTyping;
    bool reseverTyping;

    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
