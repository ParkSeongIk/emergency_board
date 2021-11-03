
import 'package:flutter/material.dart';

import 'package:emergency_post/board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '첫 페이지 설정',
      home: Board(),
    );
  }



}