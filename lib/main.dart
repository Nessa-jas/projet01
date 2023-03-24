
import 'package:js/js.dart';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:projet01/login.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {'login': (context) => MyLogin()},
  ));
}


