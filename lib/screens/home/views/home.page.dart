import 'package:chat_u/config/preety.dio.dart';
import 'package:chat_u/screens/chatprofile/views/chatprofile.page.dart';
import 'package:chat_u/screens/home/model/home.model.dart';
import 'package:chat_u/screens/home/service/home.service.dart';
import 'package:chat_u/screens/profilepage/views/profile.page.dart';
import 'package:chat_u/screens/searchpage/views/searchpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? id;
  late List<Widget> page = [
    Home(),
    SearchPage(),
    Container(),
    Container(),
    ProfilePage(userid: id!)
  ];
  int pagesindex = 0;
  getUerid()async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(()  {
      
    id = prefs.getString('_id');

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUerid();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[pagesindex],
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 238, 250),
            borderRadius: BorderRadius.circular(500),
            boxShadow: const [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 4,
                  color: Color.fromARGB(255, 87, 144, 233))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      pagesindex = 0;
                    });
                  },
                  child: const Icon(
                    Icons.add_home_outlined,
                    color: Colors.black,
                  ),
                ),
              )),
              Expanded(
                  child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      pagesindex = 1;
                    });
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              )),
              Expanded(
                  child: Center(
                child: Icon(
                  Icons.camera_enhance_outlined,
                  color: Colors.black,
                ),
              )),
              Expanded(
                  child: Center(
                child: Icon(
                  Icons.favorite_outline,
                  color: Colors.black,
                ),
              )),
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        pagesindex = 4;
                      });
                    },
                    child: Center(
                                    child: Icon(
                    Icons.person_2_outlined,
                    color: Colors.black,
                                    ),
                                  ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeModel? posts;
  String? id;

  fetchPosts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('_id');
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final service = HomeService(createDio());
    final data = service.getFollowingoPosts(id!);
    data.then((value) {
      setState(() {
        posts = value;
      });
    });
    return posts == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const ChatProfilePage()));
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 230, 238, 250),
                                  borderRadius: BorderRadius.circular(500)),
                              child: const Center(
                                child: Icon(
                                  Icons.messenger_outline_outlined,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9, top: 10),
                    child: SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(500),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/image.png"),
                                          fit: BoxFit.fill),
                                      border: Border.all(
                                          color: Colors.black, width: 3)),
                                ),
                                Text(
                                  "Fatima",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: posts!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 12,
                                    color: Color.fromARGB(60, 173, 201, 239))
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${posts!.data[index].user.profilepick}"),
                                                fit: BoxFit.fill),
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            border: Border.all(
                                                color: Colors.black, width: 1)),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${posts!.data[index].user.name} ${posts!.data[index].user.lastname}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${posts!.data[index].post.createdDate}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    const Expanded(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.more_vert_rounded,
                                          color: Colors.black,
                                          size: 35,
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                                Container(
                                  height: 400,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${posts!.data[index].post.postimages[0]}"),
                                        fit: BoxFit.contain),
                                  ),
                                ),
                                PostActionSection(
                                  commnetcallback: (value) {},
                                  postId: posts!.data[index].post.id.oid,
                                  myid: id!,
                                  likecount: posts!.data[index].post.like.length
                                      .toString(),
                                  name:
                                      '${posts!.data[index].user.username} ${posts!.data[index].user.lastname}',
                                  descriptions:
                                      '${posts!.data[index].post.descriptions}',
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}

class PostActionSection extends StatelessWidget {
  final String likecount;
  final String myid;
  final String postId;
  final String name;
  final String descriptions;
  final Function commnetcallback;

  const PostActionSection(
      {super.key,
      required this.name,
      required this.descriptions,
      required this.likecount,
      required this.myid,
      required this.postId,
      required this.commnetcallback});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Action Icons Row

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 40.0), // Adjust this value for top padding
                            child: DraggableScrollableSheet(
                              snap: true,
                              initialChildSize:
                                  1.0, // Start at full-screen height
                              minChildSize:
                                  0.5, // Minimum size when dragged down
                              maxChildSize: 1.0, // Maximum size (full-screen)
                              builder: (context, scrollController) {
                                return Scaffold(
                                  body: ListView.builder(
                                    controller: scrollController,
                                    itemCount: 20, // Example content
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text('Item $index'),
                                      );
                                    },
                                  ),
                                  bottomSheet: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        // focusNode: _focusNode,
                                        // controller: _textController,
                                        onTap: () {
                                          // _scrollToBottom();
                                        },
                                        onEditingComplete: () {
                                          // _sendMessage();
                                        },
                                        onSubmitted: (value) {
                                          // _sendMessage();
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          fillColor:
                                              Colors.black.withOpacity(0.1),
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          hintText: "Write a comment",
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Like",
                  style: GoogleFonts.montserrat(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${likecount}",
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ],
            ),
          ),
          // Description and Comments
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: '${name}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' $descriptions',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'View All 26 Comments',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
