import 'package:emergency_post/board.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ModifyForm());
}

// insert_form.dart 구조와 같음 (설명 생략)

class ModifyForm extends StatefulWidget {

  ModifyForm({Key key}) : super(key: key);

  @override
  ModifyFormState createState() => ModifyFormState();
}

class ModifyFormState extends State<ModifyForm> {

  final _formKey = GlobalKey<FormState>();

  ModifyForm modifyform = new ModifyForm();
  Board board = new Board();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          '게시글 수정',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.black12,
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _titleController,
                        autofocus: true,
                        validator: (value) {
                          if(value.isEmpty) {return '제목 누락';}
                          return null;
                        },

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '제목',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          ),
                        ),

                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white10,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 2,
                      color: Colors.black12,
                    ),

                    // OutlinedButton(
                    //   onPressed: () {
                    //
                    //   },
                    //   child: Text('파일 첨부'),
                    //   style: OutlinedButton.styleFrom(
                    //     minimumSize: Size(125, 36),
                    //     //textStyle: ThemeData().textTheme.button,
                    //
                    //   ),
                    //
                    // ),
                    //
                    // OutlinedButton(
                    //   onPressed: () {
                    //
                    //   },
                    //   child: Text('사진 첨부'),
                    //   style: OutlinedButton.styleFrom(
                    //     minimumSize: Size(125, 36),
                    //   ),
                    //
                    // ),
                  ],
                ),
              ),
            ),


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
                    Expanded(
                      child: TextFormField(
                        controller: _contentController,
                        validator: (value) {
                          if(value.isEmpty) {return '내용 누락';}
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '내용',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        maxLines: 20,
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
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text(
                        '저장',
                        textScaleFactor: 1.5,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        minimumSize: Size(125, 45),
                        shadowColor: ThemeData(
                          shadowColor: Colors.white10,
                        ).shadowColor,
                      ),
                      onPressed: () {

                        if(_titleController.text=='') {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('입력 오류'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('제목을 입력해주세요.'),
                                    ],
                                  ),
                                ),
                                contentPadding:
                                EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('확인'),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        else if(_contentController.text=='') {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('입력 오류'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('내용을 입력해주세요.'),
                                    ],
                                  ),
                                ),
                                contentPadding:
                                EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('확인'),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        if(_formKey.currentState.validate()) {
                          //_addBoardVar(BoardVar(_titleController.text, _contentController.text));

                          Navigator.pop(context, _titleController.text);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('게시글이 수정되었습니다.')));
                        }



                      },
                    ),
                    ElevatedButton(
                      child: Text(
                        '취소',
                        textScaleFactor: 1.5,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        minimumSize: Size(125, 45),
                        shadowColor: ThemeData(
                          shadowColor: Colors.white10,
                        ).shadowColor,
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
                              contentPadding:
                              EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Board()),
                                      ModalRoute.withName(''),
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
        ),
      ),
    );
  }

  var _titleController = TextEditingController();
  var _contentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  // void _addBoardVar(BoardVar bv) {
  //   setState(() {
  //     board.list.add(bv);
  //   });
  // }

}
