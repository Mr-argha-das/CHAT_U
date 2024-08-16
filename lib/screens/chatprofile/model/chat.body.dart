
import 'dart:convert';

ChatSendBody chatSendBodyFromJson(String str) => ChatSendBody.fromJson(json.decode(str));

String chatSendBodyToJson(ChatSendBody data) => json.encode(data.toJson());

class ChatSendBody {
    String chatprofileId;
    String senderId;
    String reseverId;
    String message;

    ChatSendBody({
        required this.chatprofileId,
        required this.senderId,
        required this.reseverId,
        required this.message,
    });

    factory ChatSendBody.fromJson(Map<String, dynamic> json) => ChatSendBody(
        chatprofileId: json["chatprofileId"],
        senderId: json["senderId"],
        reseverId: json["reseverId"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "chatprofileId": chatprofileId,
        "senderId": senderId,
        "reseverId": reseverId,
        "message": message,
  };
}



ChatsEndResponse chatsEndResponseFromJson(String str) => ChatsEndResponse.fromJson(json.decode(str));

String chatsEndResponseToJson(ChatsEndResponse data) => json.encode(data.toJson());

class ChatsEndResponse {
    String message;
    bool status;

    ChatsEndResponse({
        required this.message,
        required this.status,
    });

    factory ChatsEndResponse.fromJson(Map<String, dynamic> json) => ChatsEndResponse(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
