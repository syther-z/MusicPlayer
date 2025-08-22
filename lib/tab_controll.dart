import 'package:cook_the_best/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<Widget> tabs = [Tab(text: "Local"), Tab(text: "Online")];

Widget tabPage(Widget child) {
  return Container(
    color: backgroundColor,
    padding: const EdgeInsets.all(8),
    child: child,
  );
}
