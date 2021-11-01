import 'package:emergency_post/board_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:emergency_post/insert_form.dart';

void main() {
  runApp(Board());
}

class BoardData {
  // 리스트를 정렬 시키기 위한 변수
  int listSortingNum;

  // 게시글에 번호를 부여하기 위한 변수
  int listNum;

  String title;
  String description;
  DateTime datetime;

  BoardData(this.listSortingNum, this.listNum, this.title, this.description,
      this.datetime);

  @override
  String toString() => listNum.toString();
}

class ManipulateData {
  int getlistNum;

  String getTitle;
  String getDescription;

  int getSetting;

  ManipulateData(
      this.getlistNum, this.getTitle, this.getDescription, this.getSetting);
}

class Board extends StatefulWidget {
  Board({Key key}) : super(key: key);

  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {
  List<BoardData> list = <BoardData>[];

  int i_listSorting = -1; // listSortingNum 값 조정 용도

  int i = 1; // listNum 값 조정 용도

  var list_size = 0.0;

  static const int MODIFY_DATA = 1;
  static const int DELETE_DATA = 2;

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
              _navigateAndInsertData(context);
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

          Container(
            height: list_size,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                children: list.map((data) => _buildItemWidget(data)).toList(),
              ),
            ),
          ),

          Text('게시글 수 : ' + list.length.toString()),

          // 블럭 설정하여 페이지를 설정할 부분
        ],
      ),
    );
  }

  // var _controller = TextEditingController(); // 검색란 컨트롤러 (보류)

  _navigateAndInsertData(BuildContext context) async {
    // i : 게시글 정렬을 위한 int 형 변수
    BoardData get_item = new BoardData(i_listSorting, i, null, null, null);

    print('초기 인덱스 출력 : ' + i_listSorting.toString() + '   ' + i.toString());

    get_item = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              InsertForm(index_listSorting: i_listSorting, index: i)),
    );

    // 게시글 등록하지 않고 빠져나올 때의 null 값 에러 처리
    if (get_item == null) {
      print('게시글 입력 화면에서 빠져나옴');
      get_item = BoardData(i_listSorting, i, null, null, null);
      return;
    }

    // 초기 데이터 처리
    else if (list.length <= 0) {
      setState(() {
        _addBoardData(BoardData(get_item.listSortingNum, get_item.listNum,
            get_item.title, get_item.description, get_item.datetime));
      });
      print('게시판 등록 완료 (앱 실행 최초)');
    } else {
      final item = list[list.length - 1];
      if (item is BoardData)
        _addBoardData(BoardData(get_item.listSortingNum, get_item.listNum,
            get_item.title, get_item.description, get_item.datetime));
      print('게시판 등록 완료');
    }

    i_listSorting--;
    i++;

    list_size += 60;

    // 게시글이 등록된 사실을 토스트 메시지로 출력
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('게시글이 등록되었습니다.')));

    try {
      print('게시글 정렬 값 : ' + get_item.listSortingNum.toString());
      print('');
      print('게시글 번호 : ' + get_item.listNum.toString());
      print('');
      print('등록된 제목 : ' + get_item.title.toString());
      print('등록된 내용 : ' + get_item.description.toString());
      print('');
      print('등록된 시간 : ' + get_item.datetime.toString());
      print('');
      print('list 길이 출력 : ' + list.length.toString());
    } catch (on, StackTrace) {
      StackFrame.asynchronousSuspension;
    }
  }

  Widget _buildItemWidget(BoardData data) {
    final selected_item = new BoardData(data.listSortingNum, data.listNum,
        data.title, data.description, data.datetime);

    // 객체형 리스트는 인덱스 추출 불가
    // int testIndex = list.indexOf(selected_item); // -1

    return Column(
      children: <Widget>[
        ListTile(
          onTap: () async {
            ManipulateData get_item = new ManipulateData(0, null, null, 0);

            // 수정 및 삭제 네비게이터
            get_item = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BoardContent(selected_item: selected_item),
              ),
            );

            if (get_item == null || get_item.getSetting == 0) {
              print('board_content 에서 빠져나옴');
              get_item = ManipulateData(0, null, null, 0);
              return;
            }
            else if (get_item.getSetting != 0) {
              switch (get_item.getSetting) {
                case MODIFY_DATA:
                  print('수정 로직이 동작됨 (board.dart 에서)');



                  // 인덱스 불러오기
                  print(list
                      .asMap()); // {0: Instance of 'BoardData', 1: Instance of 'BoardData', 2: Instance of 'BoardData'}



                  // print('해당 게시글 인덱스 호출 : ' +
                  //       list.elementAt(get_item.getlistNum).toString());
                  //
                  //
                  //
                  // print('게시글 번호 : ' + get_item.getlistNum.toString());



                  // print('수정 작업 중 선택한 게시글 데이터 출력 확인'); // OK
                  // print('listSortingNum: ' + data.listSortingNum.toString());
                  // print('listNum: ' + data.listNum.toString());
                  // print('title: ' + data.title.toString());
                  // print('description: ' + data.description.toString());
                  // print('datetime: ' + data.datetime.toString());


                  // 게시글 제목, 게시글 내용 변경
                  setState(() {
                    data.title = get_item.getTitle;
                    data.description = get_item.getDescription;

                    // 게시글 업데이트
                    list.sort((a, b) => a.listSortingNum.compareTo(b.listSortingNum));
                  });
                  print('해당 게시글 수정 완료');

                  // 게시글이 수정된 사실을 토스트 메시지로 출력
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('게시글이 수정되었습니다.')));

                  break;

                case DELETE_DATA:
                  print('삭제 로직이 동작됨 (board.dart 에서)');

                  // 인덱스 불러오기
                  print(list
                      .asMap()); // {0: Instance of 'BoardData', 1: Instance of 'BoardData', 2: Instance of 'BoardData'}


                  // print('해당 게시글 인덱스 호출 : ' +
                  //       list.elementAt(get_item.getlistNum).toString());
                  //
                  //
                  // print('게시글 번호 : ' + get_item.getlistNum.toString());


                  _deleteBoardData(data);

                  list_size -= 60;

                  // 게시글이 삭제된 사실을 토스트 메시지로 출력
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('게시글이 삭제되었습니다.')));
                  break;
              }
            }
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
      list.sort((a, b) => a.listSortingNum.compareTo(b.listSortingNum));
    });
    print('list에 추가완료');
  }

  void _deleteBoardData(BoardData data) {
    setState(() {
      list.remove(data);
      list.sort((a,b) => a.listSortingNum.compareTo(b.listSortingNum));
    });
    print('해당 게시글 삭제완료');
  }
}
