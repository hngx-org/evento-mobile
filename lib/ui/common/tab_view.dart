import 'package:flutter/material.dart';

import 'colors.dart';

/// custom tabbar

class TabView extends StatelessWidget {
  const TabView({
    super.key,
    required TabController tabController,
    required this.firstView,
    required this.secondView,
    required this.firstTabText,
    required this.secondTabText,
  }) : _tabController = tabController;

  final TabController _tabController;
  final Widget secondView;
  final Widget firstView;
  final String firstTabText;
  final String secondTabText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            // color: AppColors.background,
            child: TabBar(
              indicatorColor: AppColor.primaryColor,
              labelColor: AppColor.primaryColor,
              indicatorWeight: 2.5,
              indicatorPadding: const EdgeInsets.only(left: 3, right: 3),
              unselectedLabelColor: AppColor.eerieBlack,
              controller: _tabController,
              tabs: [
                Tab(
                    child: Text(
                  firstTabText,
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )),
                Tab(
                  child: Text(
                    secondTabText,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  return Center(child: firstView);
                }),
                Center(child: secondView),
              ],
            ),
          )
        ],
      ),
    );
  }
}
