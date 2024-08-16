import 'package:flutter/material.dart';

import '../responsive.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Widget? icon;
  final Color? txtColor;
  final VoidCallback? onPressed;
  final Size size;

  const RoundedButton({
    Key? key,
    required this.title,
    this.color,
    this.icon,
    this.onPressed,
    this.txtColor,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: size.width *
              (isWeb(context) ? 0.4 : (isTab(context) ? 0.6 : 0.9)),
          height: size.height * 0.08,
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(left: 16.0),
                  child: SizedBox(
                    width: 28.0,
                    height: 28.0,
                    child: icon,
                  ),
                ),
                const SizedBox(width: 10.0),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: txtColor ?? Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
