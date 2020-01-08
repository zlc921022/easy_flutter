import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/common_app_bar.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

/// 通用webView控件
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
      appBar: CommonAppBar(
        context,
        this.widget.title,
        mActions: <Widget>[
          GestureDetector(
            onTap: () {
              Share.share('我是小肚子', subject: '1111');
            },
            child: Image.asset('images/icon_menu_share.png'),
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
