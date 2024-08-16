import 'package:flutter/cupertino.dart';

bool isLandscape(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.landscape;
bool isTab(BuildContext context) =>
    MediaQuery.of(context).size.aspectRatio > 0.74 &&
    MediaQuery.of(context).size.aspectRatio < 1.5;

bool isWeb(BuildContext context) => MediaQuery.of(context).size.width >= 800;
