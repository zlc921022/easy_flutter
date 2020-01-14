import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp(content: window.defaultRouteName));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String content;

  MyApp({this.content});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(content: content),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String content;

  MyHomePage({this.content});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var groupValue;
  String showMessage;
  static const BasicMessageChannel _messageChannel =
      BasicMessageChannel('BasicMessageChannelPlugin', StringCodec());

  static const EventChannel _eventChannel = EventChannel('EventChannelPlugin');

  static const MethodChannel _methodChannel =
      MethodChannel('MethodChannelPlugin');

  @override
  void initState() {
    super.initState();

    /// BasicMessageChannel
    _messageChannel.setMessageHandler((message) => Future<String>(() {
          setState(() {
            showMessage = message;
          });
          return '收到native的消息: $message';
        }));

    /// EventChannel
    _eventChannel
        .receiveBroadcastStream('你好啊')
        .listen(onSuccess, onError: onError);
  }

  void onSuccess(dynamic message) {
    setState(() {
      showMessage = message;
    });
  }

  void onError(dynamic error) {
    setState(() {
      showMessage = error;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
              child: Column(
            children: <Widget>[
              _buildRadios(),
              SizedBox(height: 10),
              Container(
                width: 100,
                height: 40,
                color: Color(0xffcccccc),
                child: FlatButton(
                    onPressed: () {
                      clickSend();
                    },
                    child: Text('发送',
                        style: TextStyle(color: Colors.black, fontSize: 14))),
              ),
              SizedBox(height: 20),
              Text('Flutter收到的原生传递过来的数据：$showMessage',
                  style: TextStyle(color: Colors.red, fontSize: 16)),
            ],
          ))),
    );
  }

  Widget _buildRadios() {
    return Column(
      children: <Widget>[
        RadioListTile(
          value: 'BaseMessageChannel',
          title: Text('BaseMessageChannel',
              style: TextStyle(color: Colors.black, fontSize: 14)),
          groupValue: groupValue,
          activeColor: Colors.red,
          selected: true,
          onChanged: (value) => onRadioChanged(value),
        ),
        RadioListTile(
          value: 'MethodChannel',
          title: Text('MethodChannel',
              style: TextStyle(color: Colors.black, fontSize: 14)),
          groupValue: groupValue,
          activeColor: Colors.red,
          onChanged: (value) => onRadioChanged(value),
        ),
      ],
    );
  }

  void onRadioChanged(dynamic value) {
    setState(() {
      groupValue = value;
    });
  }

  void clickSend() async {
    if (groupValue == 'BaseMessageChannel') {
      _messageChannel.send('你好native，我是flutter的BaseMessageChannel发来的消息');
    } else if (groupValue == 'MethodChannel') {
      var message = await _methodChannel.invokeMethod(
          'sum', 420);
      setState(() {
        showMessage = message;
      });
    }
  }
}
