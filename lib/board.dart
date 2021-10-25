import 'package:emergency_post/board_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:emergency_post/insert_form.dart';

void main() {
  runApp(Board());
}

class BoardVar {
  final String title;
  final String description;

  BoardVar(this.title, this.description);
}

class Board extends StatefulWidget {

  // 출력 안됨 (list)
  // final List<BoardVar> list = <BoardVar>[]; // <datatype> ,  [length]

  var result = '';

  Board({Key key}) : super(key: key);

  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {

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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {

              // 게시글 작성 네비게이터
              _navigateAndInsertData(context);

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => InsertForm(),
              //   ),
              // );

            },
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[

          // 게시글 검색 기능 (보류)

          // Container(
          //   color: Colors.black12,
          //   height: 1,
          // ),
          //
          // Row(
          //   children: <Widget>[
          //     Expanded(
          //       flex: 3,
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 10, right: 5),
          //         child: TextField(
          //           controller: _controller,
          //           decoration: InputDecoration(
          //             border: InputBorder.none,
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       //flex: 1,
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 5, right: 10),
          //         child: ElevatedButton(
          //           child: Text('검색', style: TextStyle(color: Colors.white),),
          //           style: ElevatedButton.styleFrom(
          //             primary: Colors.blueAccent,
          //             minimumSize: Size(100, 35),
          //             // shadowColor: ThemeData(shadowColor: Colors.blueAccent,).shadowColor,
          //           ),
          //           onPressed: () {
          //
          //
          //
          //           },
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // Container(
          //   color: Colors.black12,
          //   height: 1,
          // ),

          // 게시글 목록 표시 (테스트)

          // ListView.builder(
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(board.list[index].title),
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => BoardContent(/*eInfo: list[index]*/),),
          //         );
          //       },
          //     );
          //   },
          // ),

          // ListTile 정상 출력 여부 테스트 (ListTile 위)
          Text('가'),

          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),

              // 출력 안됨 (list)
              // child: ListView(
              //     children: board.list.map((bv) => _buildItemWidget(bv)).toList(),
              // ),


              child: ListView(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BoardContent(),
                        ),
                      );
                    },
                    title: Text(
                      board.result,
                    ),
                  ),

                  Container(
                    color: Colors.black12,
                    height: 1,
                  ),

                ],
              ),
            ),
          ),

          // ListTile 정상 출력 여부 테스트 (ListTile 아래)
          Text('나'),

        ],
      ),
    );
  }

  var _controller = TextEditingController();


  // 게시글 작성 네비게이터
  _navigateAndInsertData(BuildContext context) async {
    board.result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InsertForm()),
    );

    // 널 값 에러 조건 처리 부분

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

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  // 출력 안됨 (list)
  // Widget _buildItemWidget(BoardVar bv) {
  //   ListTile(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => BoardContent(),
  //         ),
  //       );
  //     },
  //     title: Text(
  //       bv.title,
  //     ),
  //   );
  // }
}

