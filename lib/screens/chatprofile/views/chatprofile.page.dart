import 'package:chat_u/config/preety.dio.dart';
import 'package:chat_u/screens/chatprofile/model/chatprofile.model.dart';
import 'package:chat_u/screens/chatprofile/service/chatprofile.service.dart';
import 'package:chat_u/screens/chatprofile/views/chats.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChatProfilePage extends StatefulWidget {
  const ChatProfilePage({super.key});

  @override
  State<ChatProfilePage> createState() => _ChatProfilePageState();
}

class _ChatProfilePageState extends State<ChatProfilePage> {
  ChatProfileModel? chatsProfile;
  String? id;

  fetchchatsProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('_id');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchchatsProfile();
  }

  @override
  Widget build(BuildContext context) {
    final service = ChatPrfoleService(createDio());
    final data = service.getProfileGet(id!);
    data.then((value) {
      setState(() {
        chatsProfile = value;
      });
    });
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: chatsProfile == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 230, 238, 250),
                                borderRadius: BorderRadius.circular(500)),
                            child: const Center(
                              child: Icon(
                                Icons.camera_enhance,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Center(
                          child: Text(
                            "SocialMedia",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 22),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 230, 238, 250),
                                borderRadius: BorderRadius.circular(500)),
                            child: const Center(
                              child: Icon(
                                Icons.person_2,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 12,
                              color: Color.fromARGB(60, 173, 201, 239))
                        ],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                "All",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                "Request",
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 22),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 230, 238, 250),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.search,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 240,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 12,
                              color: Color.fromARGB(60, 173, 201, 239))
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView.builder(
                          itemCount: chatsProfile!.data.length,
                          itemBuilder: (context, index) {
                            return ChatProfileTabs(
                              reseverId: chatsProfile!
                                  .data[index].userprofile.id.oid,
                              id: chatsProfile!.data[index].chatprofile.id.oid,
                              usernmae: chatsProfile!
                                  .data[index].userprofile.username,
                              text: "+4 Mmessage",
                              profilepick: chatsProfile!
                                  .data[index].userprofile.profilepick, userid: id!, chatid: chatsProfile!.data[index].chatprofile.id.oid,
                            );
                          }),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class ChatProfileTabs extends StatefulWidget {
  final String chatid;
  final String reseverId;
  final String id;
  final String usernmae;
  final String userid;
  final String text;
  final String profilepick;
  const ChatProfileTabs(
      {super.key,
      required this.chatid,
      required this.reseverId,
      required this.id,
      required this.usernmae,
      required this.userid,
      required this.text,
      required this.profilepick});

  @override
  State<ChatProfileTabs> createState() => _ChatProfileTabsState();
}

class _ChatProfileTabsState extends State<ChatProfileTabs> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => ChatPage( profileImage: widget.profilepick, username: widget.usernmae, userId: widget.userid, reseverId: widget.reseverId, chatid: widget.chatid,)));
      },
      child: ListTile(
        minTileHeight: 70,
        leading: Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              image: DecorationImage(
                  image: NetworkImage(widget.profilepick), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(5000)),
        ),
        title: Text(
          widget.usernmae,
          style: GoogleFonts.amaranth(color: Colors.black, fontSize: 20),
        ),
        subtitle: Text(
          widget.text,
          style: GoogleFonts.amaranth(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        trailing: SvgPicture.asset(
          "assets/images/Camera.svg",
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          height: 25,
        ),
      ),
    );
  }
}
