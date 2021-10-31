import 'package:emergency_post/board_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:emergency_post/insert_form.dart';

void main() {
  runApp(Board());
}

class BoardData {
  int listSortingNum;
  String title;
  String description;

  BoardData(this.listSortingNum, this.title, this.description);
}

class Board extends StatefulWidget {

  Board({Key key}) : super(key: key);

  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {

  List<BoardData> list = <BoardData>[];

  int i=0;
  int j=0;
  var list_size = 0.0;

  static final int MODIFYING = 1;
  static final int DELETING = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('게시글 목록 위젯 생성 (initState)');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('게시글 목록 위젯 종료 (dispose)');
  }



  @override
  Widget build(BuildContext context) {
    print('게시글 목록 실행 (build)');
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
              // _navigateAndInsertDataTest(context);
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

          // // ListTile 정상 출력 여부 테스트 (ListTile 위)
          // Text('리스트 출력 전'),

          Container(
            height: list_size,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),

              child: ListView(
                children: list.map((data) => _buildItemWidget(data)).toList(),
              ),


              ),
          ),

          // // ListTile 정상 출력 여부 테스트 (ListTile 아래)
          // Text('리스트가 정상적으로 출력됨'),
          Text('게시글 수 : ' + list.length.toString()),



          // + 블럭을 설정하여 페이지를 만들어야 함.



        ],
      ),
    );
  }

  // var _controller = TextEditingController(); // 검색란 컨트롤러 (보류)

  _navigateAndInsertData(BuildContext context) async {


    // i : 게시글 정렬을 위한 int 형 변수
    BoardData get_item = new BoardData(i, null, null);

    print((i+j+1).toString()+'번째 게시판 등록 시도');
    get_item = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InsertForm(index: i)),
    );

    if(get_item==null) {
      print('게시글 입력 화면에서 빠져나옴');
      get_item = BoardData(i, null, null);
      return;
    }

    else if(list.length<=0) {
      print('리스트 길이가 0일 때의 리스트 추가 로직에 넘어옴');
      setState(() {
        _addBoardData(BoardData(i, get_item.title, get_item.description));
      });
      print((i+j+1).toString()+'번째 게시판 등록 완료 (앱 실행 최초)');
    }

    else {
      print('리스트 길이가 1이상일 때의 리스트 추가 로직에 넘어옴');
      final item = list[list.length - 1];

      if (item is BoardData)
        _addBoardData(BoardData(i, get_item.title, get_item.description));

      print((i+j+1).toString()+'번째 게시판 등록 완료');
    }

    i--;
    j+=2;
    list_size += 60;
    // 게시글이 등록된 사실을 토스트 메시지로 출력
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('게시글이 등록되었습니다.')));

    try {
      print('등록된 제목 : ' + get_item.title);
      print('등록된 내용 : ' + get_item.description);
      print('list 길이 출력 : ' + list.length.toString());
    }
    catch(on, StackTrace) {
      StackFrame.asynchronousSuspension;
    }
  }

  Widget _buildItemWidget (BoardData data) {

    final selected_item = new BoardData(data.listSortingNum, data.title, data.description);

    // List<int> tmp = [10,20,30];
    // int findindex = tmp.indexOf(10);
    // print(findindex);
    // list.first.listSortingNum;
    // list.single.listSortingNum;
    int thisIndex = list.indexOf(selected_item); // -1

      return Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BoardContent(selected_item: selected_item, list: list, index: thisIndex),
                ),
              );
            },
            title: Text(
              data.title,
            ),
          ),
          Container(
            color: Colors.black12,
            height: 1,
          ),
        ],
      );

  }




  void _addBoardData(BoardData data) {
    setState(() {
      list.add(data);
      list.sort((a,b) => a.listSortingNum.compareTo(b.listSortingNum));
    });
    print('list에 추가완료');
  }

  // void _deleteBoardData(BoardData data) {
  //   setState(() {
  //     list.remove(data);
  //     list.sort((a,b) => a.listSortingNum.compareTo(b.listSortingNum));
  //   });
  //   print('list에서 삭제완료');
  // }
  }
