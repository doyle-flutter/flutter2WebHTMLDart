import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:js' as js;

void main() => runApp(
  MaterialApp(
    home: WebPage(),
    onGenerateRoute: (RouteSettings path){
      Uri u = Uri.parse(path.name??'');
      String? id = u.queryParameters["id"];

      print('u.queryParameters["id"] : ${u.queryParameters["id"]}');
      print('uri : $u');
      print("path : $path");
      print("path.name : ${path.name}");
      print("path.arguments : ${path.arguments}");
      print("id : id");

      return MaterialPageRoute(
        maintainState: false,
        settings: RouteSettings(name: '/'+(id == null? '': "?id=$id")),
        builder: (BuildContext context) => WebPage()
      );
    },
  )
);
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
  
  Future<html.MediaStream> func2JS() async{
    html.MediaStream stream = await html.window.navigator.getUserMedia(audio: false, video: true);
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
    return stream;
  }

  @override
  void initState() {
    func();
    // Future(func2JS)
    //   .then((html.MediaStream st) async => await _connectionRtc(st));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter 2 HTML & Dart"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person),
        onPressed: _func2,
      ),
    );
  }

  void _func2(){
    js.context.callMethod('play');
    print("JS Channel");
    return;
  }

}
