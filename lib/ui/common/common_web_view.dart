import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class CommonWebView extends StatefulWidget {
  final String url;
  final String title;

  CommonWebView(this.url, this.title);

  @override
  State<StatefulWidget> createState() {
    return new CommonWebViewState();
  }
}

class CommonWebViewState extends State<CommonWebView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: Text(
          this.widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: AppColor.black_33, fontSize: 15),
        ),
        leading: GestureDetector(
          onTap: () {
            AppNavigator.back(context);
          },
          child: Image.asset('images/icon_arrow_back_black.png'),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Share.share('我是小肚子',subject: '1111');
            },
            child:  Image.asset('images/icon_menu_share.png'),
          )
        ],
      ),
      url: this.widget.url,
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Center(child: CupertinoActivityIndicator()),
    );
  }
}
