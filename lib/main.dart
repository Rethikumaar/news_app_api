import 'package:flutter/material.dart';
import 'package:news_app_api/screens/country.dart';
import 'package:news_app_api/screens/home.dart';


void main (){
  runApp(myApp());
}

class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
          routes: {
        Countries.router: (context) => Countries(),
    },
    );
  }
}
