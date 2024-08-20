import 'package:chat_u/screens/auth/components/round_button.dart';
import 'package:chat_u/screens/auth/last_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/rounded_textfield.dart';

class ProfileCreate extends StatefulWidget {
  const ProfileCreate({super.key});

  @override
  State<ProfileCreate> createState() => _ProfileCreateState();
}

class _ProfileCreateState extends State<ProfileCreate> {
  final _controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(500)
                ),
              )
              ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
