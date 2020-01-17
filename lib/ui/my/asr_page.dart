import 'package:flutter/material.dart';
import 'package:flutter_movie/plugin/asr_manager.dart';
import 'package:flutter_movie/ui/common/common_app_bar.dart';
import 'package:provider_mvvm/common/app_color.dart';

class AsrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AsrPageState();
  }
}

class AsrPageState extends State {
  AsrManager asrManager;
  var asrMessage;
  double alpha = 0.5;

  @override
  void initState() {
    asrMessage = "长按按钮开始识别";
    asrManager = AsrManager();
    asrManager.requestPermission();
    super.initState();
  }

  @override
  void dispose() {
    release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(context, '语音识别页面'),
        body: new Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                asrMessage,
                style: TextStyle(color: AppColor.black_33, fontSize: 14),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              alignment: Alignment.bottomCenter,
              child: Opacity(
                  opacity: alpha,
                  child: GestureDetector(
                    onTap: () {},
                    onLongPress: () {
                      setState(() {
                        alpha = 1;
                        asrMessage = '松开结束识别';
                      });
                      start();
                    },
                    onLongPressUp: () {
                      alpha = 0.5;
                      stop();
                    },
                    child: Image.asset('images/icon_asr.png'),
                  )),
            )
          ],
        ));
  }

  Future<void> start() async {
    var result = await asrManager.start();
    setState(() {
      asrMessage = '识别到的内容为：$result';
    });
  }

  Future<void> stop() async {
    asrManager.stop();
  }

  Future<void> release() async {
    await asrManager.stop();
    await asrManager.release();
    setState(() {
      asrMessage = '资源释放';
    });
  }
}
