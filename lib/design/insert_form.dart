import 'package:emergency_post/design/board.dart';
import 'package:flutter/material.dart';

void main() => BoardInsertFormApp();



class BoardInsertFormApp extends StatelessWidget {
  const BoardInsertFormApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoardInsertFormPage(),
    );
  }
}

class BoardInsertForm extends StatelessWidget {
  const BoardInsertForm({Key key}) : super(key: key);

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
    return Text("Top");
  }

  Widget _buildMiddle() {
    return Text("Insert Form");
  }

  Widget _buildBottom() {
    return Text("Bottom");
  }
}



class BoardInsertFormPage extends StatefulWidget {
  const BoardInsertFormPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BoardInsertFormState createState() => _BoardInsertFormState();
}

class _BoardInsertFormState extends State<BoardInsertFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '게시글 등록',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BoardInsertFormPage(),
    );
  }
}