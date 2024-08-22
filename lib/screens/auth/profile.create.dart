import 'dart:developer';
import 'dart:io';

import 'package:chat_u/config/preety.dio.dart';
import 'package:chat_u/screens/auth/components/round_button.dart';
import 'package:chat_u/screens/auth/last_name.dart';
import 'package:chat_u/screens/auth/models/signup.model.dart';
import 'package:chat_u/screens/auth/models/signup.res.model.dart';
import 'package:chat_u/screens/auth/service/signup.service.dart';
import 'package:chat_u/screens/auth/service/step.formdata.dart';
import 'package:chat_u/screens/home/views/home.page.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/rounded_textfield.dart';

class ProfileCreate extends StatefulWidget {
  const ProfileCreate({super.key});

  @override
  State<ProfileCreate> createState() => _ProfileCreateState();
}

class _ProfileCreateState extends State<ProfileCreate> {
  final _bioController = TextEditingController();
  final _controller = TextEditingController();
  final _usernamecontroller = TextEditingController();
  File? file;
  String isocode = "-";
  final TextEditingController controller = TextEditingController();
  final _emailController = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String? imageurl;
  SearchusernameRespomsed? usernameresponse;
  final service = SignupServicve(createDio());
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
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          setState(() {
                            file = File(result.files.single.path!);
                          });
                          final service = SignupServicve(createDio());
                          final multipartFile2 = MultipartFile.fromBytes(
                              file!.readAsBytesSync(),
                              filename: "${file!.path}");
                          ProfilePickResponse data = await service
                              .upload(data: {"file": multipartFile2});
                          setState(() {
                            imageurl = data.data.toString();
                          });
                          log(data.toString());
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: file == null && imageurl == null
                          ? Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(500)),
                              child: Center(
                                child: Icon(Icons.person),
                              ),
                            )
                          : file != null && imageurl == null
                              ? Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(500)),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : new Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(imageurl!)),
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(500)),
                                ),
                    )
                  ],
                ),
                new SizedBox(
                  height: 20,
                ),
                new Text(
                  "Username",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                TextField(
                  controller: _usernamecontroller,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.only(
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
                  onChanged: (value) async {
                    if (value != "")
                      usernameresponse = await service.searchusername(value);
                    setState(() {});
                  },
                ),
                if (_usernamecontroller.text != "") ...[
                  new Text(
                    usernameresponse == null ? "" : usernameresponse!.message,
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ],
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
                          controller: _emailController,
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
                            setState(() {
                              isocode = number.phoneNumber.toString();
                            });
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
          child: GestureDetector(
            onTap: () async {
              Signupresponsesmodel response = await service.signup(Signupmodel(
                  username: _usernamecontroller.text,
                  name: HoldStepFormData.name.toString(),
                  lastname: HoldStepFormData.lastname.toString(),
                  profilepick: imageurl!,
                  password: HoldStepFormData.passowrd.toString(),
                  posts: 0,
                  followers: ["string"],
                  following: ["string"],
                  bio: _bioController.text,
                  links: ["string"],
                  anysong: "string",
                  email:
                      _emailController.text == "" ? "-" : _emailController.text,
                  phone: controller.text == "" ? "-" : controller.text,
                  countrycode: "$isocode",
                  accounttype: true));
                 Navigator.pushAndRemoveUntil(context, CupertinoDialogRoute(builder: (context) => HomePage(), context: context), (riute) => true);
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setString('_id', response.data.id.oid.toString());
              await prefs.setString(
                  'username', response.data.username.toString());
            },
            child: RoundButton(
              title: 'Sign up',
              txtColor: Colors.white,
              color: Colors.blue.shade300,
              size: const Size(double.infinity, 70),
            ),
          ),
        ),
      ),
    );
  }
}
