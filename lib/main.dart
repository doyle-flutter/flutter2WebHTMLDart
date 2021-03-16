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
    /// ./lib/web/index.html 파일에 Class="custom" Tag가 없다면 div Node 생성
    /// index.html 34~36번째 줄 참고
    /// - Dom .class Selector
    /// - Dom CSS Style
    html.Element customDom = html.querySelector(".custom") ?? html.Element.div();
    customDom.style.position = "fixed";
    customDom.style.top = "100px";
    customDom.style.left = "100px";
    customDom.style.zIndex = "100";
    print(customDom);

    /// Dom #id Selector
    html.Element dom = html.querySelector("#id") ?? html.Element.div();
    print(dom);
    return;
  }
  
  Future<void> func2JS() async{
    html.MediaStream stream = await html.window.navigator.getUserMedia(audio: true, video: true);
    var videoTag = new html.VideoElement()
      ..autoplay = true
      ..srcObject = stream;
    html.document.body!.append(videoTag); // 설마 body 태그가 없는 경우도 발생할 수 있을까요? X
    videoTag.style
      ..position = "fixed"
      ..top = "300px"
      ..left = "50%"
      ..transform = "translate(-50%, -50%)"
      ..width = "45%"
      ..zIndex = "100";
  }

  @override
  void initState() {
    func();
    Future(func2JS);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Flutter 2 HTML & Dart"),),);
  }
}
