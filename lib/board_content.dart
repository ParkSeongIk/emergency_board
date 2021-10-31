import 'package:emergency_post/board.dart';
import 'package:emergency_post/modify_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(BoardContent());

class CmtData {
  int listSortingNum;
  String id;
  String comment;

  CmtData(this.listSortingNum, this.id, this.comment);
}

class BoardContent extends StatefulWidget {


  final BoardData selected_item;
  final List<BoardData> list;
final index;

  BoardContent({Key key, @required this.selected_item, @required this.list, @required this.index}) : super(key: key);



  @override
  _BoardContentState createState() => _BoardContentState();
}
// This is the type used by the popup menu below.
// enum WhyFarther { harder, smarter, selfStarter, tradingCharter }
enum Settings { modify, delete }
class _BoardContentState extends State<BoardContent> {

  int cmtIndex = 0;
  final _cmtItems = <CmtData>[];
  double list_size = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.index.toString()+' 번째 게시글 위젯 생성 (initState)');
  }


  var _cmtController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _cmtController.dispose();
    super.dispose();
    print(widget.index.toString()+' 번째 게시글 위젯 종료 (dispose)');
  }

  @override
  Widget build(BuildContext context) {
    print(widget.index.toString()+' 번째 게시글 실행 (build)');
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
                    widget.selected_item.title,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(

                  child: PopupMenuButton<Settings>(
                    onSelected: (Settings result) {
                      print(result);
                      switch(result) {
                        case Settings.modify:
                          // 게시글 수정 네비게이터
                          _navigateAndModifyData(context);
                          break;
                        case Settings.delete:
                          // 게시글 삭제 네비게이터
                          _MakeSureWhetherDeleteThisItem(context);
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Settings>>[
                      const PopupMenuItem<Settings>(
                        value: Settings.modify,
                        child: Text('게시글 수정'),
                      ),
                      const PopupMenuItem<Settings>(
                        value: Settings.delete,
                        child: Text('게시글 삭제'),
                      ),
                    ],
                  ),
                ),
              ],
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
            height: 300,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 15, right: 25, bottom: 15),
              child: ListView(
                children: <Widget>[
                  Text(
                    widget.selected_item.description,
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
                          _addCmtData(CmtData(--cmtIndex, '응급의료앱 개발자', _cmtController.text));
                          list_size += 120;
                        },
                    ),


                  ),
                  ),







                ],
              ),
            ),
          ),



          Container(
            height: list_size,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 15, right: 25, bottom: 15),
              child: ListView(
                children: _cmtItems.map((data) => _buildItemWidget(data)).toList(),
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

    int item_listNo = widget.selected_item.listSortingNum;
    String item_title = widget.selected_item.title;
    String item_content = widget.selected_item.description;

    BoardData set_data = new BoardData(
        item_listNo, item_title, item_content);
    BoardData get_data = new BoardData(item_listNo, null, null);


    print('수정하기 전 제목 : '+item_title);
    print('수정하기 전 내용 : '+item_content);


    get_data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ModifyForm(get_data_for_modifying: set_data),
      ),
    );




    if(get_data==null) {
      print('게시글 수정 화면에서 빠져나옴');
      get_data=BoardData(item_listNo, null, null);
      return;
    }

    else {
      try {

        print('수정하기 전 제목 : '+item_title);
        print('수정하기 전 내용 : '+item_content);

        print('수정할 제목 : '+get_data.title);
        print('수정할 내용 : '+get_data.description);
        print('게시글 수 : ' + widget.list.length.toString()); // ok

        print("이후, 게시글 내용이 수정되는 로직 (UI 에서는 작성하지 않음)");


        // 값 출력 테스트

        // print('첫 번째 인덱스 따오기 : '+widget.list.first.title.toString()); // 성공
      }
      catch(on, StackTrace) {
        StackFrame.asynchronousSuspension;
      }

    }

    // 게시글이 수정된 사실을 토스트 메시지로 출력
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('게시글이 수정되었습니다.')));


  } // 게시글 수정 네비게이터 부분 끝.

  // 게시글 삭제 네비게이터
  _MakeSureWhetherDeleteThisItem(BuildContext context) async {
    var delete_flag = false; // (bool) : 삭제할 것인지 신호를 받는 역할

    delete_flag = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('이 게시글을 삭제하시겠습니까?'),
              ],
            ),
          ),
          contentPadding:
          EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
          actions: <Widget>[
            TextButton(
              onPressed: () {

                // stack에서 alert 창 pop
                Navigator.pop(context, true);

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


    if(delete_flag==true) {

      print('게시글 삭제 작업 (UI 에서는 작성하지 않음)');

      // 게시글이 삭제된 사실을 토스트 메시지로 출력
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('게시글이 삭제되었습니다.')));

      // Navigator.pop(context);

    }


  }

  Widget _buildItemWidget(CmtData data) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            data.comment,
          ),
          subtitle: Text(
            data.id,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete_sharp),
            onPressed: () => _deleteCmtData(data),
          ),
        ),
        Container(
          color: Colors.black12,
          height: 1,
        ),
      ],
    );
  }

  Widget _addCmtData(CmtData data) {
    setState(() {
      _cmtItems.add(data);
      _cmtItems.sort((a,b) => a.listSortingNum.compareTo(b.listSortingNum));
      _cmtController.text='';
    });
  }

  Widget _deleteCmtData(CmtData data) {
    setState(() {
      _cmtItems.remove(data);
      _cmtItems.sort((a,b) => a.listSortingNum.compareTo(b.listSortingNum));
    });
  }

  // final items = List.generate(10, (i) {
  //   return ListTile(
  //     title: Text('댓글 표시 테스트 $i'),
  //   );
  // });

}
