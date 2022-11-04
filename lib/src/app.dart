import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/src/components/image_data.dart';
import 'package:instagram_clone_coding/src/controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: controller.willPopAction,
        child: Obx(() => Scaffold(
              appBar: AppBar(),
              body: IndexedStack(
                index: controller.pageIndex.value,
                children: [
                  Container(
                    child: Center(child: Text("HOME")),
                  ),
                  Container(
                    child: Center(child: Text("SEARCH")),
                  ),
                  Container(
                    child: Center(child: Text("UPLOAD")),
                  ),
                  Container(
                    child: Center(child: Text("ACTIVITY")),
                  ),
                  Container(
                    child: Center(child: Text("MYPAGE")),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: controller.pageIndex.value, // 현재 선택값
                elevation: 0, // 경계선을 없앰
                onTap: controller.changeBottomNav,
                items: [
                  BottomNavigationBarItem(
                    icon: ImageData(ImagePath.homeOff),
                    activeIcon: ImageData(ImagePath.homeOn),
                    label: "home",
                  ),
                  BottomNavigationBarItem(
                    icon: ImageData(ImagePath.searchOff),
                    activeIcon: ImageData(ImagePath.searchOn),
                    label: "search",
                  ),
                  BottomNavigationBarItem(
                    icon: ImageData(ImagePath.uploadIcon),
                    label: "upload",
                  ),
                  BottomNavigationBarItem(
                    icon: ImageData(ImagePath.activeOff),
                    activeIcon: ImageData(ImagePath.activeOn),
                    label: "active",
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    label: "home",
                  ),
                ],
              ),
            )),
    );
  }
}