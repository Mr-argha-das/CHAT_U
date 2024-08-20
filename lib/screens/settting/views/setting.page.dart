import 'package:chat_u/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Setting",
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 25),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(color: Colors.white),
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: GestureDetector(
                onTap: (){
                  setState(() async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const MyApp()));
                  });
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      border: Border.all(color: Colors.black, width: 3)),
                  child: Center(
                    child: Text(
                      "Log out",
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
          )
      ),
    );
  }
}
