import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
void main() => runApp(MaterialApp(home: WebPage(),));

class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  void func(){

    html.Element custom = html.querySelector(".custom") ?? html.Element.div();
    custom.style.position = "fixed";
    custom.style.top = "100px";
    custom.style.left = "100px";
    custom.style.zIndex = "100";
    html.Element dom = html.querySelector("#id") ?? html.Element.div();
    /// ./lib/web/index.html 파일에 #id Tag가 없다면 div Node 생성
    print(dom);
    return;
  }

  @override
  void initState() {
    func();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter 2 HTML & Dart"),),
    );
  }
}
