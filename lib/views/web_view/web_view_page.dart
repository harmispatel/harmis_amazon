import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  WebViewPage({this.title, this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        initialChild: Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(CommonColors.primaryColor),
          ),
        ),
        appBar: AppBar(
          backgroundColor: CommonColors.primaryColor,
          elevation: 0.0,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.only(left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    height: 15,
                    child: Image.asset(
                      LocalImages.ic_arrow_back,
                      color: CommonColors.white,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14, right: 10),
                    child: Text(
                      widget.title,
                      style: CommonStyle.getAppFont(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: CommonColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        url: widget.url ?? "www.google.com");
  }
}
