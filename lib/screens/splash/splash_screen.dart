import 'package:chat_u/constants.dart';
import 'package:chat_u/screens/auth/login_screen.dart';
import 'package:chat_u/screens/auth/name_first.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 9,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/Rectangle.png"),
                      fit: BoxFit.cover),
                ),
                
              )),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=> const LoginScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 3)),
                          child: Center(
                            child: Text("LOG IN", style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold),),
                          ),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => const NameFirstScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black
                          ),
                          child: Center(
                            child: Text("REGISTER", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                    ),
                  ),
                )),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
