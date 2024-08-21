import 'package:chat_u/screens/auth/components/round_button.dart';
import 'package:chat_u/screens/auth/last_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../components/rounded_textfield.dart';

class ProfileCreate extends StatefulWidget {
  const ProfileCreate({super.key});

  @override
  State<ProfileCreate> createState() => _ProfileCreateState();
}

class _ProfileCreateState extends State<ProfileCreate> {
  final _bioController = TextEditingController();
  final _controller = TextEditingController();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(500)),
                      child: Center(
                        child: Icon(Icons.person),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Username",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                TextField(
                  controller: _bioController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: 16.0,
                        left:
                            16.0), // Adjust padding to move hintText to the top
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Bio",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                TextField(
                  controller: _bioController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: 16.0,
                        left:
                            16.0), // Adjust padding to move hintText to the top
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Chose Contact Information",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                TabBar(
                  tabs: [
                    Tab(text: "Email"),
                    Tab(text: "Phone"),
                  ],
                ),
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    children: [
                      Center(
                        child: TextField(
                          controller: _bioController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Email",
                            contentPadding: EdgeInsets.only(
                                top: 16.0,
                                left:
                                    16.0), // Adjust padding to move hintText to the top
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            useBottomSheetSafeArea: true,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          initialValue: number,
                          textFieldController: controller,
                          formatInput: true,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          onSaved: (PhoneNumber number) {
                            print('On Saved: $number');
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(10.0),
          child: RoundButton(
            title: 'Sign up',
            txtColor: Colors.white,
            color: Colors.blue.shade300,
            size: const Size(double.infinity, 70),
          ),
        ),
      ),
    );
  }
}
