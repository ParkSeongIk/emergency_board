import 'package:emergency_post/board.dart';
import 'package:emergency_post/modify_form.dart';
import 'package:flutter/material.dart';

void main() => runApp(BoardContent());

class BoardContent extends StatefulWidget {


  List<BoardVar> eInfo = <BoardVar>[];


  BoardContent({Key key, @required this.eInfo}) : super(key: key);



  @override
  _BoardContentState createState() => _BoardContentState();
}

class _BoardContentState extends State<BoardContent> {

  Board board = new Board();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          '응급의료 게시판',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 25, top: 25, right: 25, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    '제목이 표시될 부분 제목이 표시될 부분 제목이 표시될 부분 제목이 표시될 부분 ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black54,
                    ),
                    onPressed: () {

                      // 게시글 수정 네비게이터
                      _navigateAndModifyData(context);
                    },
                  ),
                ),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(
          //       left: 25, top: 25, right: 25, bottom: 15),
          //   child: ListTile(
          //     trailing: IconButton(
          //       icon: Icon(Icons.arrow_drop_down),
          //     ),
          //   ),
          // ),
          Center(
            child: Container(
              color: Colors.black12,
              width: 350,
              height: 1,
            ),
          ),
          Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 15, right: 25, bottom: 15),
              child: ListView(
                children: <Widget>[
                  Text(
                    '내용',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Center(
            child: Container(
              color: Colors.black12,
              width: 350,
              height: 1,
            ),
          ),

          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 15, right: 25, bottom: 15),
              child: Text(
                '댓글',
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),


          Container(

            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: <Widget>[

                  Expanded(


                    flex: 3,



                    child: Padding(
                      padding: const EdgeInsets.only(left: 27, right: 15),
                      child: TextField(
                        controller: _cmtController,
                        decoration: InputDecoration(

                          border: OutlineInputBorder(),
                          hintText: '댓글쓰기',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          ),

                        ),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: ElevatedButton(
                        child: Text('등록', style: TextStyle(color: Colors.white, fontSize: 18,), ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          minimumSize: Size(30, 60),
                          shadowColor: ThemeData(shadowColor: Colors.white,).shadowColor,
                        ),
                        onPressed: () {
                          // text가 listtile로 출력됨. - listtile내에서 삭제기능만 넣을 예정. (시간 부족에 따라 기능 최소화)
                        },
                    ),


                  ),
                  ),







                ],
              ),
            ),
          ),



          Container(
            height: 750,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 15, right: 25, bottom: 15),
              child: ListView(
                children: items,
              ),
            ),
          ),


          Container(
            color: Colors.black12,
            width: 350,
            height: 1,
          ),

        ],
      ),
    );
  }

  // 게시글 수정 네비게이터
  _navigateAndModifyData(BuildContext context) async {
    board.result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ModifyForm()),
    );


    // 타 dart 파일에 대해 갱신 불가
    if (board.result!=null) {
      setState(() {
        board.result;
      });
    }
    else {
      setState(() {
        board.result = '';
      });
    }



  }

  final items = List.generate(10, (i) {
    return ListTile(
      title: Text('댓글 표시 테스트 $i'),
    );
  });
  var _cmtController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _cmtController.dispose();
    super.dispose();
  }
}
