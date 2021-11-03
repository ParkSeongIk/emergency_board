import 'package:emergency_post/board_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:emergency_post/insert_form.dart';

void main() {
  runApp(Board());
}

// 게시글에 들어갈 속성들.
class BoardData {


  int listSortingNum; // 리스트를 정렬 시키기 위한 변수
  int listNum; // 게시글에 번호를 부여하기 위한 변수
  String writer; // 작성자
  String title; // 제목
  String description; // 내용
  String insertTime; // 최초로 게시글을 삽입한 시간
  String datetime; // 최초 삽입/변경 시간
  bool isNoModify = true; // 수정한 적이 없는 게시글인지 구분

  BoardData(this.listSortingNum, this.listNum, this.writer, this.title, this.description, this.insertTime,
      this.datetime, this.isNoModify);

  // 게시글 인덱스를 게시글 번호에 대응하여 확인하는데 쓰임 (.asMap 메서드 이용)
  @override
  String toString() => listNum.toString();
}

// 수정될 게시글에 대해 필요한 속성들.
class ManipulateData {
  int getlistNum; // 수정할 게시글 번호 얻어옴 (필요하면 DB에 쓸 것)
  String getTitle; // 수정할 게시글 제목 얻어옴
  String getDescription; // 수정할 게시글 내용 얻어옴
  String getInsertTime; // 최초로 게시글이 등록된 시간을 BoardData의 인스턴스를 통해 얻어옴.
  String getDatetime; // 삽입/변경 시간

  int getSetting; // 수정 혹은 삭제할 작업의 신호를 받음

  ManipulateData(
      this.getlistNum, this.getTitle, this.getDescription, this.getInsertTime, this.getDatetime, this.getSetting);
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

  // 임시 게시글 작성자
  String writer = '1-1조 응급의료어플';


  var list_size = 0.0; // 게시글 목록 사이즈 조정


  static const int NO_SIGNAL = 0; // 신호 없음
  static const int MODIFY_DATA = 1; // 수정 신호
  static const int DELETE_DATA = 2; // 삭제 신호

  DateTime dt = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print('게시글 목록 위젯 생성 (initState)');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //print('게시글 목록 위젯 종료 (dispose)');
  }

  @override
  Widget build(BuildContext context) {

    //print('게시글 목록 실행 (build)');

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
              // insert_form.dart (게시글 작성) 네비게이터
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
          //   height: 2,
          // ),

          // 게시글 존재여부 체크
          _noDataCheck(),

          Container(
            height: list_size,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),

              child: ListView(

                // 게시글 목록 출력 부분
                children: list.map((data) => _buildItemWidget(data)).toList(),



              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25),
          //   child: Text('게시글 수 : ' + list.length.toString()),
          // ),

        ],
      ),
    );
  }

  // var _controller = TextEditingController(); // 검색란 컨트롤러 (보류)


  // insert_form.dart (게시글 작성) 네비게이터
  _navigateAndInsertData(BuildContext context) async {

    BoardData get_item;

    get_item = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              InsertForm(index_listSorting: i_listSorting, index: i, writer: writer)),
    );

    // 등록 작업 없이 insert_form.dart를 빠져나올 경우 (null값 에러 처리)
    if (get_item == null)
      return;

    // 초기 데이터 처리
    else if (list.length <= 0) {
      setState(() {
        _addBoardData(BoardData(get_item.listSortingNum, get_item.listNum,
            get_item.writer, get_item.title, get_item.description, get_item.insertTime, get_item.datetime, get_item.isNoModify));
      });
      // print('게시판 등록 완료 (앱 실행 최초)');
    }


    else {
      final item = list[list.length - 1];
      if (item is BoardData)
        _addBoardData(BoardData(get_item.listSortingNum, get_item.listNum,
            get_item.writer, get_item.title, get_item.description, get_item.insertTime, get_item.datetime, get_item.isNoModify));
      print('게시판 등록 완료');
    }

    i_listSorting--;
    i++;

    list_size += 60;


    // 게시글이 등록된 사실을 토스트 메시지로 출력
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('게시글이 등록되었습니다.')));

    try {
      // print('게시글 정렬 값 : ' + get_item.listSortingNum.toString());
      // print('');
      // print('게시글 번호 : ' + get_item.listNum.toString());
      // print('');
      // print('작성자 : ' + get_item.writer.toString());
      // print('등록된 제목 : ' + get_item.title.toString());
      // print('등록된 내용 : ' + get_item.description.toString());
      // print('');
      // print('등록된 시간 : ' + get_item.datetime.toString());
      // print('');
      // print('list 길이 출력 : ' + list.length.toString());
    } catch (on, StackTrace) {
      StackFrame.asynchronousSuspension;
    }
  }

  // 게시글 존재여부 체크
  Widget _noDataCheck() {
    if(list.length==0) {
      return Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Text(
            '게시글이 \n존재하지 않습니다',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // list 에 데이터가 있을 경우 리스트 속성 명을 화면에 출력
   else {
      return Column(
        children: <Widget>[
          Container(
            color: Colors.blueGrey[50],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    '제목',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '작성자',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '작성 날짜',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            height: 2,
          ),
        ],
      );
    }
  }


  // 게시글 목록 출력 부분
  Widget _buildItemWidget(BoardData data) {

    // 현재 선택된 게시글에 대함
    final selected_item = new BoardData(data.listSortingNum, data.listNum,
        data.writer, data.title, data.description, data.insertTime, data.datetime, data.isNoModify);

    ManipulateData get_item = new ManipulateData(0, null, null, null, null, NO_SIGNAL);

    String insert_time;

    if(data.isNoModify==true) {
      insert_time = data.datetime;
    }
    else {
      insert_time = data.insertTime;
    }

    int title_OverLength_Check = 20;
    String printTitle = null;

    if(title_OverLength_Check<=data.title.length) {
      printTitle = data.title.substring(0, title_OverLength_Check-1)+'...';
    }
    else {
      printTitle = data.title;
    }

    int writer_OverLength_Check = 9;
    String printWriter = null;

    if(writer_OverLength_Check<=data.writer.length) {
      printWriter = data.writer.substring(0, writer_OverLength_Check-1)+'...';
    }
    else {
      printWriter = data.writer;
    }

    // 게시글 스타일 구성
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () async {



            // 게시글을 눌렀을 때 게시글 상세 내용으로 넘어감 (수정 및 삭제 신호 받음)
            get_item = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BoardContent(selected_item: selected_item, isNoModify: data.isNoModify),
              ),
            );

            // 수정 / 삭제 작업 없이 board_content.dart를 빠져나올 경우 (null값 에러 처리)
            if (get_item == null || get_item.getSetting == NO_SIGNAL) {
              // print('board_content 에서 빠져나옴');
              return;
            }

            // 수정 / 삭제 작업 신호를 받았을 경우
            else if (get_item.getSetting != NO_SIGNAL) {
              switch (get_item.getSetting) {
                case MODIFY_DATA:
                  // print('수정 로직이 동작됨 (board.dart 에서)');



                  // 인덱스 불러오기
                  // print(" (좌)해당 게시글 인덱스 : (우)게시글 번호 ");
                  // print(list.asMap()); // {0: Instance of 'BoardData', 1: Instance of 'BoardData', 2: Instance of 'BoardData'}



                  // 처리할 리스트 인덱스가 0일 때 오류 발생

                  // print('해당 게시글 인덱스 호출 : ' +
                  //       list.elementAt(get_item.getlistNum).toString());

                  // print('게시글 번호 : ' + get_item.getlistNum.toString());



                  // print('수정 작업 중 선택한 게시글 데이터 출력 확인'); // OK
                  // print('listSortingNum: ' + data.listSortingNum.toString());
                  // print('listNum: ' + data.listNum.toString());
                  // print('title: ' + data.title.toString());
                  // print('description: ' + data.description.toString());
                  // print('datetime: ' + data.datetime.toString());


                  // 게시글 데이터 변경
                  setState(() {
                    data.title = get_item.getTitle;
                    data.description = get_item.getDescription;
                    data.datetime = get_item.getDatetime;

                    // 게시글 업데이트
                    list.sort((a, b) => a.listSortingNum.compareTo(b.listSortingNum));
                  });

                  data.isNoModify = false;
                  // print('Board.dart 에서 넘어온 수정 내역 값');
                  // print(data.isNoModify);

                  // print('해당 게시글 수정 완료');
                  // print('작성자 : ' + data.writer.toString());

                  // 게시글이 수정된 사실을 토스트 메시지로 출력
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('게시글이 수정되었습니다.')));

                  break;

                case DELETE_DATA:
                  // print('삭제 로직이 동작됨 (board.dart 에서)');

                  // 인덱스 불러오기
                  // print(list.asMap()); // {0: Instance of 'BoardData', 1: Instance of 'BoardData', 2: Instance of 'BoardData'}


                  _deleteBoardData(data);

                  list_size -= 60;

                  print('작성자 : ' + data.writer.toString());

                  // 게시글이 삭제된 사실을 토스트 메시지로 출력
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('게시글이 삭제되었습니다.')));
                  break;
              }
            }
          },
          title: Row(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Text(
                    printTitle,
                  ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  printWriter,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  // get_item.insertTime.toString(),
                  insert_time,

                  // _DatePrint(data.isNoModify, insert_time, selected_item.datetime),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.black12,
          height: 1,
        ),
      ],
    );
  }


  // 게시글 목록에 게시글이 추가 됨

  void _addBoardData(BoardData data) {
    setState(() {
      list.add(data);
      list.sort((a, b) => a.listSortingNum.compareTo(b.listSortingNum));
    });
    // print('list에 추가완료');
  }

  // 게시글 목록에서 게시글을 삭제 함

  void _deleteBoardData(BoardData data) {
    setState(() {
      list.remove(data);
      list.sort((a,b) => a.listSortingNum.compareTo(b.listSortingNum));
    });
    // print('해당 게시글 삭제완료');
  }
}
