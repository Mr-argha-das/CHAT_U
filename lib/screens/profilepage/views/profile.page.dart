import 'dart:developer';

import 'package:chat_u/config/preety.dio.dart';
import 'package:chat_u/screens/chatprofile/model/chatprofile.body.dart';
import 'package:chat_u/screens/chatprofile/model/chatprofile.res.dart';
import 'package:chat_u/screens/chatprofile/service/chatprofile.service.dart';
import 'package:chat_u/screens/chatprofile/views/chats.page.dart';
import 'package:chat_u/screens/profilepage/models/follow.body.dart';
import 'package:chat_u/screens/profilepage/models/follow.res.dart';
import 'package:chat_u/screens/profilepage/models/profile.model.dart';
import 'package:chat_u/screens/profilepage/service/profile.service.dart';
import 'package:chat_u/screens/settting/views/setting.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String userid;
  const ProfilePage({super.key, required this.userid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // This widget is the root of your application.
  final profileService = ProfileService(createDio());
  final chatservice = ChatPrfoleService(createDio());
  String? myid;
  ProfileModel? profileData;
  searchUser({required String query}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('_id');
    final data = profileService.searchUser(query);
    data.then((value) {
      setState(() {
        myid = id;
        profileData = value;
        for (int i = 0; i < value!.userProfile.followers.length; i++) {
          if ("$id" == "${value!.userProfile.followers[i]}") {
            followed = true;
              log(" not match");
            break;
          } else {
             followed = false;
          }
        }
      });
    });
  }

  String? id;
  bool? followed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchUser(query: widget.userid);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: profileData == null
          ? const Center(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/HD-wallpaper-blue-aesthetic-flowers.jpg"),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: Offset(4, 4))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      profileData!.userProfile
                                                          .profilepick),
                                                  fit: BoxFit.fill),
                                              borderRadius:
                                                  BorderRadius.circular(500)),
                                        ),
                                        new SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          new SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Followers",
                                            style: GoogleFonts.amaranth(
                                                color: Colors.black,
                                                fontSize: 25),
                                          ),
                                          Text(
                                              "${profileData!.followers.length}",
                                              style: GoogleFonts.amaranth(
                                                  color: Colors.black54,
                                                  fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          new SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Following",
                                            style: GoogleFonts.amaranth(
                                                color: Colors.black,
                                                fontSize: 25),
                                          ),
                                          Text(
                                              "${profileData!.following.length}",
                                              style: GoogleFonts.amaranth(
                                                  color: Colors.black54,
                                                  fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        new SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            profileData!.userProfile.username,
                                            style: GoogleFonts.amaranth(
                                                color: Colors.black,
                                                fontSize: 21),
                                          ),
                                          Text(
                                              "${profileData!.userProfile.name} ${profileData!.userProfile.lastname}",
                                              style: GoogleFonts.amaranth(
                                                  color: Colors.black54,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                      Expanded(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconButton(onPressed: (){
                                              Navigator.push(context, CupertinoModalPopupRoute(builder: (context) => const SettingPage()));
                                            }, icon: const Icon(Icons.settings, color: Colors.black, size: 25,)),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 10, top: 10, bottom: 15),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        child: Text(
                                          "${profileData!.userProfile.bio}",
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
                                if(myid != widget.userid)...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        height: 40,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(500)),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () async {
                                              if(followed == false){
                                                FollowResponse response =
                                                  await profileService
                                                      .followuser(
                                                          FollowBodyModel(
                                                              userid:
                                                                  widget.userid,
                                                              follower: id!));
                                                              setState(() {
                                                                followed = true;
                                                                profileData!.userProfile.followers.add("$id");
                                                              });
                                              }else{

                                              }
                                            },
                                            child: Text(
                                              followed == true
                                                  ? "Following"
                                                  : "Follow",
                                              style: GoogleFonts.montserrat(
                                                  color: followed == true? Colors.blueGrey: Colors.grey.shade600,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 10),
                                        child: GestureDetector(
                                          onTap: () async {
                                            try {
                                              SendChatProfileResponse response =
                                                  await chatservice.sendChatProfile(
                                                      SendChatProfileBody(
                                                          senderId: id!,
                                                          reseverid:
                                                              profileData!
                                                                  .userProfile
                                                                  .id
                                                                  .oid,
                                                          status: true,
                                                          active: true,
                                                          reseverStatus:
                                                              "string",
                                                          senderStatus:
                                                              "string",
                                                          senderTyping: false,
                                                          reseverTyping:
                                                              false));
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder:
                                                          (context) => ChatPage(
                                                                reseverId:
                                                                    profileData!
                                                                        .userProfile
                                                                        .id
                                                                        .oid,
                                                                profileImage:
                                                                    profileData!
                                                                        .userProfile
                                                                        .profilepick,
                                                                username: profileData!
                                                                    .userProfile
                                                                    .username,
                                                                userId: id!, chatid: 'dasdad',
                                                              )));
                                            } catch (e) {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder:
                                                          (context) => ChatPage(
                                                                reseverId:
                                                                    profileData!
                                                                        .userProfile
                                                                        .id
                                                                        .oid,
                                                                profileImage:
                                                                    profileData!
                                                                        .userProfile
                                                                        .profilepick,
                                                                username: profileData!
                                                                    .userProfile
                                                                    .username,
                                                                userId: id!, chatid: 'dadsad',
                                                              )));
                                            }
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(500)),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.chat_bubble_outline,
                                                    color: Colors.grey.shade600,
                                                    size: 19,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text("Chat",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color:
                                                                  Colors.grey.shade600,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                ],
                                if(myid == widget.userid)...[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(child: Container(
                                          decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(500)),
                                                    child: Center(
                                                      child: Text("Edit profile",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color:
                                                                    Colors.grey.shade600,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    ),
                                        )),
                                        SizedBox(width: 10,),
                                        Expanded(child: Container(
                                          decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(500)),
                                                    child: Center(
                                                      child: Text("Share profile",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color:
                                                                    Colors.grey.shade600,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    ),
                                        )),
                                      ],
                                    ),
                                  ),
                                )
                                ],
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, // Number of columns
                                      crossAxisSpacing: 2.0,
                                      mainAxisSpacing: 2.0,
                                    ),
                                    itemCount: profileData!.posts.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            image: DecorationImage(
                                                image: NetworkImage(profileData!
                                                    .posts[index]
                                                    .postimages[0]),
                                                fit: BoxFit.fitWidth),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    ));
  }
}


