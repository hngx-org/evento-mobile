import 'package:evento/ui/screens/explore/explore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/assets.dart';
import '../../common/colors.dart';
import '../../common/text_fields.dart';

class RecommendedPage extends StatefulWidget {
  static const String name = 'recommended-screen';
  static const String path = '/recommended-screen';
  const RecommendedPage({super.key});

  @override
  State<RecommendedPage> createState() => _RecommendedPageState();
}

class _RecommendedPageState extends State<RecommendedPage> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textTheme = Theme.of(context).textTheme;

    // Mock data for events
    List<Event> events = [
      Event(
        title: 'HNG Finalist Meetup',
        date: DateTime.now(),
        price: 20.0,
        location: 'Event Location 1',
      ),
      Event(
        title: 'Tech Conference 2023',
        date: DateTime.now().add(const Duration(days: 2)),
        price: 15.0,
        location: 'Event Location 2',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommended',
          style: textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Categories',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildCategoryItem('All', 0),
                  buildCategoryItem('Music', 1),
                  buildCategoryItem('Sporting', 2),
                  buildCategoryItem('Tech', 3),
                  buildCategoryItem('Health', 4),
                  // Add more categories as needed
                ],
              ),
            ),
            // Recommended Events
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Recommended',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) {
                Event event = events[index];
                String formattedDate =
                    DateFormat('E, MMM d').format(event.date);
                String formattedTime = DateFormat('h:mm a').format(event.date);

                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      // Event Image
                      Container(
                        width: 126.w,
                        height: 180.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          image: const DecorationImage(
                            image: AssetImage(Assets.eventImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      // Event Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title,
                              style: textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              event.location,
                              style: textTheme.bodyLarge
                                  ?.copyWith(fontSize: 14.sp),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    color: Colors.blue),
                                SizedBox(width: 8.w),
                                Text(
                                  formattedTime,
                                  style: textTheme.bodyLarge
                                      ?.copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      //  bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildCategoryItem(String title, int index) {
    final textTheme = Theme.of(context).textTheme;
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
            style: textTheme.bodyLarge?.copyWith(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final DateTime date;
  final double price;
  final String location;

  Event({
    required this.title,
    required this.date,
    required this.price,
    required this.location,
  });
}
