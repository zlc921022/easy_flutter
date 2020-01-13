import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp(param: window.defaultRouteName));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String param;

  MyApp({this.param});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(param: param),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String param;

  MyHomePage({this.param});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
        child: Center(
          child: Text('Flutter收到的原生传递过来的数据：$param',
              style: TextStyle(color: Colors.red, fontSize: 16)),
        ),
      ),
    );
  }
}
