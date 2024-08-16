// To parse this JSON data, do
//
//     final sendChatProfileBody = sendChatProfileBodyFromJson(jsonString);

import 'dart:convert';

SendChatProfileBody sendChatProfileBodyFromJson(String str) => SendChatProfileBody.fromJson(json.decode(str));

String sendChatProfileBodyToJson(SendChatProfileBody data) => json.encode(data.toJson());

class SendChatProfileBody {
    String senderId;
    String reseverid;
    bool status;
    bool active;
    String reseverStatus;
    String senderStatus;
    bool senderTyping;
    bool reseverTyping;

    SendChatProfileBody({
        required this.senderId,
        required this.reseverid,
        required this.status,
        required this.active,
        required this.reseverStatus,
        required this.senderStatus,
        required this.senderTyping,
        required this.reseverTyping,
    });

    factory SendChatProfileBody.fromJson(Map<String, dynamic> json) => SendChatProfileBody(
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
