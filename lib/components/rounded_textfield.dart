import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final String hintText;
  final String? labelText; // Add labelText for the label
  final Color textColor;
  final Color borderColor;
  final bool obscureText;
  final double? height; // Customize height
  final bool autoFocus;

  const RoundedTextField({
    Key? key,
    this.prefixIcon,
    required this.hintText,
    required this.controller,
    this.labelText, // Add labelText parameter
    required this.textColor,
    required this.borderColor,
    this.obscureText = false,
    this.height,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        autofocus: autoFocus,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText, // Add labelText to InputDecoration
          hintText: hintText,
          hintStyle: TextStyle(color: textColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: borderColor),
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: (height ?? 50.0) / 2 -
                  12), // Adjust vertical padding based on height
        ),
        validator: (value){
          if(value == null || value.isEmpty){
            return "This Field required";
          }

        },
      ),
    );
  }
}
