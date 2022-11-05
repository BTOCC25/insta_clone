import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<List<int>> groupBox = [[], [], []];
  List<int> groupIdx = [0, 0, 0];
  var boxNum = 100;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < boxNum; i++) {
      var gi = groupIdx.indexOf(min<int>(groupIdx)!);
      var size = 1;
      if (gi != 1 && Random().nextInt(3) == 0){
        size = 2;
      }
      groupBox[gi].add(size);
      groupIdx[gi] += size;
    }
  }

  Widget _appbar(){
     return Row(
       children: [
         Expanded(
           child: Container(
             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
             margin: const EdgeInsets.only(left: 10),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(6),
               color: const Color(0xffefefef),
             ),
             child: Row(
               children: const [
                 Icon(Icons.search),
                 Text(
                   "검색",
                   style: TextStyle(
                     fontSize: 15,
                     color: Color(0xff838383)
                   ),
                 )
               ],
             ),
           ),
         ),
         const Padding(
           padding: EdgeInsets.all(15.0),
           child: Icon(Icons.location_pin),
         ),
       ],
     );
  }

  Widget _body(){
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            groupBox.length,
            (colIdx) => Expanded(
            child: Column(
              children: List.generate(
                  groupBox[colIdx].length,
                  (rowIdx) => Container(
                    height: Get.width * 0.333 * groupBox[colIdx][rowIdx],
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: 'https://imgnews.pstatic.net/image/108/2022/11/05/0003101895_001_20221105154701274.jpg?type=w647',
                      fit: BoxFit.cover,
                    )
                  ),
              )
            )
          )
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appbar(),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }
}
