import 'package:flutter/material.dart';
import 'Screens/home_screen.dart';
import 'package:logger/logger.dart';
void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
var logger = Logger();