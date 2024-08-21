import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? txtColor;
  final VoidCallback? onPressed;
  final Size size;

  const RoundButton({
    Key? key,
    required this.title,
    this.color,
    this.onPressed,
    this.txtColor,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black
                          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: txtColor ?? Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
