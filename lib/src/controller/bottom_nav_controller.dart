import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/message_popup.dart';
import '../pages/upload.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();

  RxInt pageIndex = 0.obs;
  GlobalKey<NavigatorState> searchPageNavigationKey = GlobalKey<NavigatorState>();
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch(page){
      case PageName.UPLOAD:
        Get.to(() => const Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}){
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value){
      bottomHistory.add(value);
    }
  }

  Future<bool> willPopAction() async{
    if(bottomHistory.length == 1){
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
            title: "시스템",
            messaage: "종료하시겠습니까?",
            okCallback: (){
              exit(0);
            },
            cancelCallback: Get.back,
          ),
      );
      return true;
    }else{
      var page = PageName.values[bottomHistory.last];
      if(page == PageName.SEARCH){
        var value = await searchPageNavigationKey.currentState!.maybePop(); // pop 할것이 있는지 없는지.
        if (value) return false; // pop 할 내용이 있으면, 아무것도 안하고 함수를 끝낸다.
      }

      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      return false;
    }
  }
}
