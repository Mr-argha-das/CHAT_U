import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chat_u/config/preety.dio.dart';
import 'package:chat_u/screens/callpage/views/call.page.dart';
import 'package:chat_u/screens/chatprofile/model/chats.model.dart';
import 'package:chat_u/screens/chatprofile/service/chatprofile.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatPage extends StatefulWidget {
  final String userId;
  final String chatid;
  final String username;
  final String profileImage;
  final String reseverId;

  const ChatPage({
    super.key,
    required this.reseverId,
    required this.profileImage,
    required this.chatid,
    required this.username,
    required this.userId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatsModel? chats = null;
  TextEditingController _textController = TextEditingController();
  String? username;
  final ScrollController _scrollController = ScrollController();
  late WebSocketChannel _channel;
  late List<Datum> _messages = [];

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    chatsoket();
  }

  chatsoket() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://165.232.185.159:8080/api/v1/ws/$username'),
    );

    final service = ChatPrfoleService(createDio());
    final data = service.chats(username!, widget.username);
    data.then((value) {
      setState(() {
        chats = value;
        _messages.addAll(chats!.data);
        _messages = _messages.reversed.toList();
      });
    });
  }

  FocusNode _focusNode = FocusNode();
 

  void _openKeyboard() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  void dispose() {
    _channel.sink.close(status.goingAway);
    _textController.dispose();
      _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      final newMessage = Datum(
        senderId: username!,
        receiverId: widget.username,
        message: _textController.text.toString(),
        timestamp: "${DateTime.now().isUtc}",
      );

      _channel.sink.add('${widget.username}:${_textController.text}');
      Future.delayed(Duration(seconds: 2), () {
        _channel.sink.add('${widget.username}:null');
      });
      setState(() {
        _messages.add(newMessage);
      });
      _textController.clear();
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        elevation: 0.5,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.profileImage),
                  fit: BoxFit.fill,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(500),
              ),
            ),
            const SizedBox(width: 10),
            AutoSizeText(
              widget.username,
              style: GoogleFonts.amaranth(
                color: Colors.black,
              ),
              maxLines: 1, // Limits the text to a single line
              minFontSize: 15, // Sets the minimum font size
              maxFontSize: 25, // Sets the maximum font size
              overflow:
                  TextOverflow.fade, // Adds an ellipsis if the text is too long
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context) => CallPage(callID: widget.chatid, userid: widget.userId, username: username!)));
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 238, 250),
                borderRadius: BorderRadius.circular(500),
              ),
              child: const Center(
                child: Icon(
                  Icons.call,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 7),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 238, 250),
              borderRadius: BorderRadius.circular(500),
            ),
            child: const Center(
              child: Icon(
                Icons.video_call,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: chats == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  Map<String, dynamic> data = jsonDecode(snapshot.data);
                  log("${data} ::: ${_messages[_messages.length - 1].timestamp}");
                  if ("null" != "${data["data"]}") {
                    final newMessage = Datum(
                      senderId: widget.username,
                      receiverId: username!,
                      message: data["data"],
                      timestamp: data["time"].toString(),
                    );
                    _messages.add(newMessage);
                    _scrollToBottom();
                  }
                }
                return ListView.builder(
                  reverse: false,
                  controller: _scrollController,
                  itemCount: _messages.length + 1,
                  itemBuilder: (context, index) {
                    if (_messages.length - 1 < index) {
                      return const SizedBox(height: 250);
                    } else {
                      final message = _messages[index];
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                message.senderId == username
                                    ? "Me"
                                    : widget.username,
                                style: GoogleFonts.montserrat(
                                  color: message.senderId == username
                                      ? Colors.red
                                      : Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: Container(
                                            width: 2,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              color:
                                                  message.senderId == username
                                                      ? Colors.red
                                                      : Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
                                      child: Container(
                                        width: 40,
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: message.senderId == username
                                              ? Colors.red
                                              : Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18, right: 10, top: 10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                30,
                                            child: Text(
                                              message.message,
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            ),
      bottomSheet: SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 230, 238, 250),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/Camera.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  height: 25,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: _textController,
                onTap: () {
                  _scrollToBottom();
                },
                onEditingComplete: () {
                  _sendMessage();
                },
                onSubmitted: (value) {
                  _sendMessage();
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: "messages",
                ),
              ),
            ),
            // const SizedBox(width: 10),
            // GestureDetector(
            //   onTap: () => _openKeyboard(),
            //   child: Container(
            //     height: 55,
            //     width: 55,
            //     decoration: BoxDecoration(
            //       color: const Color.fromARGB(255, 230, 238, 250),
            //       borderRadius: BorderRadius.circular(50),
            //     ),
            //     child: const Center(child: Icon(Icons.emoji_emotions)),
            //   ),
            // ),
            const SizedBox(width: 10),
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 238, 250),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(child: Icon(Icons.photo_album)),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
