import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:emergency_post/design/insert_form.dart';

void main() => runApp(BoardApp());

class BoardApp extends StatelessWidget {
  const BoardApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '[응급의료 게시판]',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class Board extends StatelessWidget {
  const Board({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return ListView(
      children: <Widget>[
        _buildTop(),
        _buildMiddle(),
        _buildBottom(),
      ],
    );
  }

  Widget _buildTop() {
    //
    //return Text('top');

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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        //labelText: '제목/글쓴이',
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
                        
                        // 로그인이 되어있으면 바로 insert_form, 되어있지 않으면 경고창 출력 후 로그인 페이지로 이동

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
          height: 5,
          child: Row(
            children: <Widget>[
              Container(),
            ],
          ),
        ),
      ],
    );


  }

  Widget _buildMiddle() {
    //ListView.separated
    //itemCount: entries.length,

    //return Text("Middle");

    //게시글 표시 (임시)
    final items = List.generate(30, (i) {
      return InkWell(
        onTap: () {
          print('클릭');
        },
        child: ListTile(
          title: Text('게시글이 표시됩니다'),
        ),
      );
    });

    return Container(
      child: Column(
        children: <Widget>[
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: items,
          ),
        ],
      ),
    );

    // return ListView.separated(
    //     itemBuilder: (BuildContext context, int index) {
    //       return ListTile(
    //         title: Text('item $index'),
    //       );
    //     },
    //     separatorBuilder: (BuildContext context, int index) => const Divider(),
    //     itemCount: 30,
    // );
    // final List<String> entries = <String>['A', 'B', 'C'];
    // final List<int> colorCodes = <int>[600, 500, 100];
    //
    // return ListView.builder(
    //     padding: const EdgeInsets.all(8),
    //     itemCount: entries.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Container(
    //         height: 50,
    //         color: Colors.amber[colorCodes[index]],
    //         child: Center(child: Text('Entry ${entries[index]}')),
    //       );
    //     }
    // );
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '응급의료 게시판',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.blueAccent,
            ),
            onPressed: () {},
          )
        ],
        centerTitle: true,
      ),
      body: Board(),
    );
  }
}