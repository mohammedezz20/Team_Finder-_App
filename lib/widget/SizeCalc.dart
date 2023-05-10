import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.width * (percentage / MediaQuery.of(context).size.width);
}

double getHeight(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.height * (percentage /MediaQuery.of(context).size.height);
}