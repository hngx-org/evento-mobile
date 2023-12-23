import 'package:evento/ui/screens/explore/recommended.dart';
import 'package:evento/ui/screens/explore/searchfilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/assets.dart';
import '../../common/colors.dart';
import '../../common/text_fields.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

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
  final ScrollController _scrollController = ScrollController();
  bool _showOverlay = false; // Initially hide the overlay
  final double _threshold = 100.0; // Adjust the threshold as needed

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return const FilterBottomSheet();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > _threshold && !_showOverlay) {
        // If scroll offset exceeds the threshold and overlay is not shown, show it
        setState(() {
          _showOverlay = true;
        });
      } else if (_scrollController.offset <= _threshold && _showOverlay) {
        // If scroll offset is less than or equal to the threshold and overlay is shown, hide it
        setState(() {
          _showOverlay = false;
        });
      }
    });
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
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: mediaQuery.height * 0.25,
              backgroundColor: AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
              ),
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showOverlay ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.white,
                        backgroundImage: const AssetImage(Assets.perofileImage),
                      ),
                      SizedBox(width: 16.w),
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
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                background: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  width: mediaQuery.width,
                  decoration: ShapeDecoration(
                    color: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.r),
                        bottomRight: Radius.circular(32.r),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _showOverlay ? 0 : 1,
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
                                Text('Hello, 👋 ',
                                    style: textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: 17,
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
                      SizedBox(height: 30.h),
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
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          onTap: () => context.push(RecommendedPage.path),
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
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                'Location',
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.access_time, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                formattedTime,
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontSize: 14),
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
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                'Location',
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.access_time, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                formattedTime,
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontSize: 14),
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
        ));
  }

  Widget _buildCategoryItem(String title, int index) {
    bool isSelected = index == _selectedCategoryIndex;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Container(
          alignment: Alignment.center,
          width: 75.w,
          height: 40.h,
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
            style: textTheme.bodySmall?.copyWith(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
