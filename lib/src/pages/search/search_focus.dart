import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/src/components/image_data.dart';
import 'package:instagram_clone_coding/src/controller/bottom_nav_controller.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({Key? key}) : super(key: key);

  @override
  State<SearchFocus> createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus> with TickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  Widget _tabMenuItem(String menu){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(menu,
        style: const TextStyle(
            fontSize: 15,
            color: Colors.black),
      ),
    );
  }

  PreferredSizeWidget _tabMenu(){
    return PreferredSize( // 다른 위젯을 넣을 수 없음.
        preferredSize: Size.fromHeight(AppBar().preferredSize.height), // 50만큼떨어진 다음 밑에 붙는거
        child: Container(
          height: AppBar().preferredSize.height, // 앱바 사이즈 만큼
          width: Size.infinite.width,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))
          ),
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.black,
            tabs: [
              _tabMenuItem("인기"),
              _tabMenuItem("계정"),
              _tabMenuItem("오디오"),
              _tabMenuItem("태그"),
              _tabMenuItem("장소"),
            ],
          ),
        )
    );
  }

  Widget _body(){
    return TabBarView(
      controller: tabController,
      children: const [
        Center(child: Text("인기페이지"),),
        Center(child: Text("계정페이지"),),
        Center(child: Text("오디오페이지"),),
        Center(child: Text("태그페이지"),),
        Center(child: Text("장소페이지"),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: BottomNavController.to.willPopAction,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(ImagePath.backBtnIcon),
          ),
        ),
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffefefef),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "검색",
              contentPadding: EdgeInsets.only(left:7, top: 7, bottom: 7),
              isDense: true, // 박스 간격이 줄어듬
            ),
          ),
        ),
        bottom: _tabMenu()
      ),
      body: _body(),
    );
  }
}
