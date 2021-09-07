import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '응급의료 게시판',
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
    // 검색
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget> [
        TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '변수값',
            )
        ),
        ElevatedButton(
          child: Text('검색'),
          onPressed: () {
            // 로직 작성 필요 ->
          },
        ),
      ],
    );
  }

  Widget _buildMiddle() {
    // 게시글 표시
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: items,
      ),
    );
  }

  Widget _buildBottom() {
    // 게시글 페이지
    return Text('Bottom');
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
