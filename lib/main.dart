import 'dart:developer';

import 'package:chat_u/screens/home/views/home.page.dart';
import 'package:chat_u/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
   bool lodar = false;
  fetchPosts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('_id');
    if(id != null){
      log("==========================");
      log(id);
      setState(() {
        lodar = true;
      });
    }else{
     setState(() {
        lodar = false;
     });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
    
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: lodar == true? HomePage(): SplashScreen(),
    );
  }
}
