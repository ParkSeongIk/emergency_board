import 'package:emergency_post/design/board.dart';
import 'package:flutter/material.dart';

void main() => runApp(BoardModifyFormApp());

MyHomePage board = MyHomePage();

class BoardModifyFormApp extends StatelessWidget {
  const BoardModifyFormApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '[게시글 수정]',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoardModifyFormPage(),
    );
  }
}

class BoardModifyFormPage extends StatefulWidget {
  const BoardModifyFormPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BoardModifyFormState createState() => _BoardModifyFormState();

}

class _BoardModifyFormState extends State<BoardModifyFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '게시글 수정',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          _ModifyFormTop(),
          _ModifyFormMiddle(),
          _ModifyFormBottom(),
        ],
      ),
    );
  }

  var _titleController = TextEditingController();
  var _contentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _contentController.dispose();
    _titleController.dispose(); // Textbox 사용이 끝나면 해제.

    super.dispose();
  }

  Widget _ModifyFormTop() {
    //return Text("제목, 파일/사진 첨부");
    return Column(
      children: <Widget>[



        Container(
          color: Colors.black12,
          height: 1,
        ),




        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: <Widget>[

                Expanded( // TextField 사용 시 크기 지정을 필수로 해야함

                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '제목',
                      hintStyle: TextStyle(color: Colors.black26,),
                    ),
                    style: TextStyle(fontSize: 18,),

                  ),

                ),

              ],
            ),
          ),
        ),


        Container(
          color: Colors.black12,
          height: 1,
        ),



        Container(
          color: Colors.white10,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[


                OutlinedButton(
                  onPressed: () {

                  },
                  child: Text('파일 첨부'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(125, 36),
                    //textStyle: ThemeData().textTheme.button,

                  ),

                ),

                OutlinedButton(
                  onPressed: () {

                  },
                  child: Text('사진 첨부'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(125, 36),
                  ),

                ),


              ],
            ),
          ),
        ),


        Container(
          color: Colors.black12,
          height: 1,
        ),


      ],
    );
  }

  Widget _ModifyFormMiddle() {
    //return Text("내용");
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: <Widget>[

                Expanded( // TextField 사용 시 크기 지정을 필수로 해야함

                  child: TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '내용',
                      hintStyle: TextStyle(color: Colors.black26,),
                    ),
                    style: TextStyle(fontSize: 18,),
                    maxLines: 20,
                    maxLength: 1000,

                  ),

                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _ModifyFormBottom() {
    //return Text("버튼");
    return Column(
      children: <Widget>[

        Container(
          color: Colors.black12,
          height: 1,
        ),


        Container(
          color: Colors.white10,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('수정', textScaleFactor: 1.5, ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black38,
                    minimumSize: Size(125, 45),
                    shadowColor: ThemeData(shadowColor: Colors.white10,).shadowColor,
                  ),
                  onPressed: () {


                    // 등록
                    //board._Modify_testBoard(PostBoard(_titleController.text));


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BoardApp(),
                      ),
                    );
                    // 이후 게시글이 올라간다는 알림 필요 - 토스트 메시지 나 진행상태 출력
                  },
                ),
                ElevatedButton(
                  child: Text('취소', textScaleFactor: 1.5, ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black38,
                    minimumSize: Size(125, 45),
                    shadowColor: ThemeData(shadowColor: Colors.white10,).shadowColor,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,

                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('취소 하시겠습니까?'),
                                Text('작업 내역이 저장되지않습니다.'),
                              ],
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BoardApp(),
                                  ),
                                );
                              },
                              child: Text('확인'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('취소'),
                            ),
                          ],

                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),











      ],

    );



  }
}