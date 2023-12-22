import 'package:evento/ui/screens/explore/recommended.dart';
import 'package:evento/ui/screens/explore/searchfilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/assets.dart';
import '../../common/colors.dart';
import '../../common/text_fields.dart';

class ExplorePage extends StatefulWidget {
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

String formatTime(DateTime dateTime) {
  return DateFormat('h:mm a').format(dateTime);
}

String formatDate(DateTime dateTime) {
  return DateFormat('E, MMM d').format(dateTime);
}

class _ExplorePageState extends State<ExplorePage> {
  int _selectedCategoryIndex = 0;
  TextEditingController searchController = TextEditingController();

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FilterBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;
    DateTime now = DateTime.now();
    String formattedDate = formatDate(now);
    String formattedTime = formatTime(now);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQuery.height,
          width: mediaQuery.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: mediaQuery.width,
                  height: mediaQuery.height / 3.5,
                  decoration: ShapeDecoration(
                    color: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.r),
                        bottomRight: Radius.circular(32.r),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              const AssetImage(Assets.perofileImage),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Hello, 👋 ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(
                              'John Doe',
                              style: textTheme.displaySmall
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: SvgPicture.asset(
                            Assets.notificationIcon,
                            height: 24,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Search Field
              Positioned(
                top: mediaQuery.height / 5.0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EventoTextField(
                        textEditingController: searchController,
                        hint: 'What events are you looking for?',
                        prefixIcon: SvgPicture.asset(
                          Assets.searchIcon,
                        ),
                        suffixIcon: SvgPicture.asset(
                          Assets.settings1Icon,
                          height: 24,
                        ),
                        onClickSuffixIcon: _showFilterBottomSheet,
                      ),
                      SizedBox(height: 56.h),
                      Text(
                        'Categories',
                        style: textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildCategoryItem('All', 0),
                            _buildCategoryItem('Music', 1),
                            _buildCategoryItem('Sporting', 2),
                            _buildCategoryItem('Tech', 3),
                            _buildCategoryItem('Health', 4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Text(
                            "Recommended",
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecommendedPage(),
                                ),
                              );
                            },
                            child: Text(
                              'See All',
                              style: textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        width: mediaQuery.width,
                        height: 160,
                        clipBehavior: Clip.antiAlias,
                        decoration: const ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(Assets.eventImage),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: mediaQuery.width,
                        height: 180,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formattedDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  '\$ Price',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'HNG Finalist Meetup',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  'Location',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    color: Colors.blue),
                                const SizedBox(width: 8),
                                Text(
                                  formattedTime,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Text(
                            "Trending",
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'See All',
                            style: textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        width: mediaQuery.width,
                        height: 160,
                        clipBehavior: Clip.antiAlias,
                        decoration: const ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(Assets.eventImage),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: mediaQuery.width,
                        height: 180,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formattedDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  '\$ Price',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'HNG Finalist Meetup',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  'Location',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    color: Colors.blue),
                                const SizedBox(width: 8),
                                Text(
                                  formattedTime,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, int index) {
    bool isSelected = index == _selectedCategoryIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Container(
          width: 75,
          height: 40,
          padding: EdgeInsets.all(8.w),
          decoration: ShapeDecoration(
            color: isSelected ? AppColor.primaryColor : Colors.transparent,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFF2BB9B)),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
