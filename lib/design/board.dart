import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:emergency_post/design/insert_form.dart';

void main() => runApp(BoardApp());

class PostBoard {
  String title;
  //bool isUpdating = false;

  PostBoard(this.title);
}


class BoardApp extends StatelessWidget {
  const BoardApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '=== 삐뽀삐뽀 게시판 ===',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 화면 뼈대
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          '응급의료 게시판',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black54,
            ),
            onPressed: () {
              // 로그인이 되어있으면 바로 insert_form, 되어있지 않으면 경고창 출력 후 로그인 페이지로 이동

              // 로그인 X, 로그인 페이지
              if (!true) {}
              // 로그인 O
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BoardInsertFormApp(),
                  ),
                );
              }
            },
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          _buildTop(),
          _buildMiddle(),
          _buildBottom(),
        ],
      ), // 몸체
    );
  }

  final _items = <PostBoard>[];

  var _pbController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _pbController.dispose(); // Textbox 사용이 끝나면 해제.
    super.dispose();
  }

  Widget _buildItemWidget(PostBoard pb) {
    return ListTile(
      onTap: () {},
      title: Text(
        pb.title,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _delete_testBoard(pb),
      ),
    );
  }

  Widget _buildTop() {
    //
    //return Text('top');

    return Column(
      children: <Widget>[
        Container(
          color: Colors.lightBlue[100],
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: TextField(
                      controller: _pbController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  //flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: ElevatedButton(

                      child: Text('검색'),
                      onPressed: () {



                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.black12,
          height: 2,
          child: Row(
            children: <Widget>[
              Container(),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _insert_testBoard(PostBoard(_pbController.text)),
              child: Text('추가'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () {}, child: Text('수정'),),
          ],
        ),
      ],
    );
  }

  Widget _buildMiddle() {


    //return Text('middle');

    // //게시글 표시 (임시)
    // final items = List.generate(30, (i) {
    //   return InkWell(
    //     onTap: () {
    //       print('클릭');
    //     },
    //     child: ListTile(
    //       title: Text('게시글이 표시됩니다'),
    //     ),
    //   );
    // });
    //
    // return Container(
    //   child: Column(
    //     children: <Widget>[
    //       ListView(
    //         physics: NeverScrollableScrollPhysics(),
    //         shrinkWrap: true,
    //         children: items,
    //       ),
    //     ],
    //   ),
    // );


    return Column(
      children: <Widget>[
        ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: _items.map((pb) => _buildItemWidget(pb)).toList(),

        ),
      ],
    );


  }

  Widget _buildBottom() {
    // 게시글 페이지
    //return Text('Bottom');
    return Column(
      children: <Widget>[
        Container(
          color: Colors.black12,
          height: 5,
          child: Row(
            children: <Widget>[
              Container(),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          height: 5,
          child: Row(
            children: <Widget>[
              Container(),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Text("페이지"),
          ],
        ),
        Container(
          height: 40,
          color: Colors.black26,
          child: Row(
            children: <Widget>[
              Container(),
            ],
          ),
        ),
      ],
    );
  }

  //
  void _insert_testBoard(PostBoard pb) {
    setState(() {
      _items.add(pb);
      _pbController.text = '';
    });
  }

  void _update_testBoard(PostBoard pb) {
    setState(() {

    });
  }

  void _delete_testBoard(PostBoard pb) {
    setState(() {
      _items.remove(pb);
    });
  }


}