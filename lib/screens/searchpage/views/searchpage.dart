import 'package:chat_u/config/preety.dio.dart';
import 'package:chat_u/screens/profilepage/views/profile.page.dart';
import 'package:chat_u/screens/searchpage/models/serach.model.dart';
import 'package:chat_u/screens/searchpage/service/search.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searachService = SearchService(createDio());

  SearchResult? searchResult;
  searchUser({required String query}) {
    final data = searachService.searchUser(query);
    data.then((value) {
      setState(() {
        searchResult = value;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchUser(query: "o");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        leading: const SizedBox(),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            // controller: _textController,
            onChanged: (value) {
              searchUser(query: value);
            },

            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
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
              hintText: "Search user",
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.circle_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: searchResult == null?
       const Center(
        child: CircularProgressIndicator(),
       )
       : SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: 
              ListView.builder(
                  itemCount: searchResult!.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) =>ProfilePage(userid: searchResult!.data[index].id.oid,) ));
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        image: DecorationImage(image: NetworkImage(searchResult!.data[index].profilepick), fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(500)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${searchResult!.data[index].username}",
                                          style: GoogleFonts.amaranth(
                                              color: Colors.black, fontSize: 21),
                                        ),
                                        Text("${searchResult!.data[index].name} ${searchResult!.data[index].lastname}",
                                            style: GoogleFonts.amaranth(
                                                color: Colors.black38,
                                                fontSize: 17)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    );
                  })
              
        ),
      ),
    );
  }
}
