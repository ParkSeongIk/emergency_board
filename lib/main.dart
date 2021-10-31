
import 'package:flutter/material.dart';

import 'package:emergency_post/board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '첫 페이지',
      home: Board(),
    );
  }
}

// 2021.11.01 AM 01:45
//
// 게시판 UI 작업 마무리 단계
// 1) 수정, 삭제 로직 미완성 - UI는 다 작성했음
// 2) 게시글 목록 블럭 페이지 코드 작성해야함
// 3) 이후 할 수 있는데까지 할 예정