import 'package:chat_u/screens/auth/components/round_button.dart';
import 'package:chat_u/screens/auth/last_name.dart';
import 'package:chat_u/screens/auth/service/step.formdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/rounded_textfield.dart';

class NameFirstScreen extends StatefulWidget {
  const NameFirstScreen({super.key});

  @override
  State<NameFirstScreen> createState() => _NameFirstScreenState();
}

class _NameFirstScreenState extends State<NameFirstScreen> {
  final _controller = TextEditingController();
  final _fomkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _fomkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Choose",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: size.height * 0.050,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "First Name",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: size.height * 0.050,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
            
                const SizedBox(height: 5),
                Text(
                  "You Can Always Change it Later",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: size.height * 0.020,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                RoundedTextField(
                  controller: _controller,
                  prefixIcon: Image.asset(
                    'assets/icons/mail-02.png',
                    width: 24,
                    height: 24,
                  ),
                  hintText: 'Enter First Name',
                  labelText: 'First Name',
                  textColor: Colors.grey,
                  borderColor: Colors.grey,
                  height: 60, // Custom height
                  autoFocus: true,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                        onTap: () {
                         if(_fomkey.currentState!.validate()){
                          setState(() {
                            HoldStepFormData.name = _controller.text;
                          });
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LastNameScreen()));
                         }
                        },
                  child: RoundButton(
                    title: 'Next',
                    txtColor: Colors.white,
                    color: Colors.blue.shade300,
                    size: const Size(double.infinity, 70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
