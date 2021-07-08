import 'package:flutter/material.dart';
import 'package:dti/pages/intro.dart';
import 'package:dti/pages/add_contact.dart';
import 'package:dti/pages/home.dart';
import 'package:dti/pages/trigger.dart';
import 'package:dti/pages/final.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Montserrat',
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Intro(),
      '/home': (context) => Home(),
      '/add_contact': (context) => AddContact(),
      '/trigger': (context) => Trigger(),
      '/final': (context) => Final(),
    },
  ));
}

