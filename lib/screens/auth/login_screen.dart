import 'package:chat_u/config/preety.dio.dart';
import 'package:chat_u/screens/auth/components/round_button.dart';
import 'package:chat_u/screens/auth/models/login.model.dart';
import 'package:chat_u/screens/auth/service/login.service.dart';
import 'package:chat_u/screens/home/views/home.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/rounded_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final indentifyerController = TextEditingController();
  final passwordController = TextEditingController();
  String? message;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/backgraound.png'))),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(alignment: Alignment.center, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Hey",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: size.height * 0.050,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Login Now,",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: size.height * 0.050,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                RoundedTextField(
                  controller: indentifyerController,
                  prefixIcon: Image.asset(
                    'assets/icons/mail-02.png',
                    width: 24,
                    height: 24,
                  ),
                  hintText: 'Username',
                  labelText: 'Username',
                  textColor: Colors.grey,
                  borderColor: Colors.grey,
                  height: 60, // Custom height
                  autoFocus: true,
                ),
                const SizedBox(height: 20),
                RoundedTextField(
                  controller: passwordController,
                  prefixIcon: Image.asset(
                    'assets/icons/lock.png',
                    width: 24,
                    height: 24,
                  ),
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  textColor: Colors.grey,
                  borderColor: Colors.grey,
                  obscureText: true,
                  height: 60,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: GoogleFonts.poppins(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    loginFunction(identifyer: indentifyerController.text, password: passwordController.text);
                  },
                  child: Container(
                    height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                          border: Border.all(color: Colors.black, width: 3)),
                          child: Center(
                            child: Text("LOG IN", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                    ),
                ),
              ],
            ),
            if (message != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40),
                child: Container(
                  height: 150,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1,
                            blurRadius: 15,
                            offset: Offset(4, 4))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$message",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              message = null;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Try Again",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ]),
        ),
      ),
    );
  }

  loginFunction({required String identifyer, required String password}) async {
    final service = LoginService(createDio());
    try {
      LoginResponse response = await service
          .login(Loginbody(identifyer: identifyer, password: password));
      // Obtain shared preferences.
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const HomePage()));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('_id', response.data.id.oid.toString());
      await prefs.setString('username', response.data.username.toString());
    } catch (e) {
      setState(() {
        message = "User, Password is incorrect!";
      });
    }
  }
}
