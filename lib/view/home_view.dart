import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:netflix_clone/constant/app_color.dart';
import 'package:netflix_clone/constant/app_text.dart';
import 'package:netflix_clone/view/a.dart';
import 'package:netflix_clone/view/search.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  final List<String> labels = ["Home", "Search"];
  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: labels.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _motionTabBarController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
        tabBarColor: AppColor.homeAppBar,
        tabIconColor: Colors.grey,
        tabIconSelectedSize: 35,
        tabIconSelectedColor: Colors.white,
        tabSelectedColor: Colors.red,
        textStyle:
            AppText.popinsFont(color: Colors.white, fontWt: FontWeight.bold),
        tabIconSize: 35,
        initialSelectedTab: labels[0],
        labels: labels,
        icons:   const [
          Icons.home_rounded,

          Icons.search_rounded,

        ],
      ),
      body: TabBarView(
        physics:
            const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported

        controller: _motionTabBarController,
        children: const [
          A(),

          SearchScreen(),

        ],
      ),
    );
  }
}
