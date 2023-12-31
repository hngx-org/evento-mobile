// ignore_for_file: prefer_const_constructors

import 'package:evento/core/assets/assets.dart';
import 'package:evento/ui/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/tab_view.dart';

class ProfileScreen extends StatefulWidget {
  static const String name = 'profile-screen';
  static const String path = '/profile-screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

late TabController tabController;

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Edit Your Profile',
          style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColor.eerieBlack),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 128,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.linen,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, top: 16),
                child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.primaryColor),
                    child: SvgPicture.asset(
                      Assets.editIcon,
                    )),
              ),
            ),
          ),
          const SizedBox.shrink(),
          Container(
            transform: Matrix4.translationValues(0.0, -40.0, 0.0),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://th.bing.com/th/id/R.5984159799b0816018fee4e99b7411d5?rik=juCYPL27dy2pDw&riu=http%3a%2f%2ftonyferraricertified.com%2fwp-content%2fuploads%2f2018%2f08%2fsportscar-17583_1920.jpg&ehk=w%2fCNEgr5e37cX%2bi7bfuD64D1puZfzMxXPSjpJlzSYLw%3d&risl=&pid=ImgRaw&r=0'), // Replace with your profile picture URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          // const SizedBox(
          //   height: 14,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Brooklyn Simmons',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              Container(
                height: 36,
                width: 115,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColor.primaryColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      Assets.editIcon,
                      color: AppColor.primaryColor,
                    ),
                    Text(
                      'Edit Profile',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColor.primaryColor,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text('Bio'),
          ),

          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                SvgPicture.asset(Assets.instagramIcon),
                SizedBox(
                  width: 19,
                ),
                SvgPicture.asset(Assets.facebookIcon),
                SizedBox(
                  width: 19,
                ),
                SvgPicture.asset(Assets.twitterIcon)
              ],
            ),
          ),
          SizedBox(
            height: 48,
          ),
          TabView(
            tabController: tabController,
            firstTabText: 'Upcoming Events',
            secondTabText: 'Past Events',
            firstView: UpcomingEventTab(),
            secondView: PastEventTab(),
          )
        ],
      ),
    );
  }
}

class PastEventTab extends StatelessWidget {
  const PastEventTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 160,
        width: 160,
        decoration:
            BoxDecoration(color: AppColor.linen, shape: BoxShape.circle),
        child: Center(
            child: SvgPicture.asset(
          Assets.noEventIcon,
        )),
      ),
    );
  }
}

class UpcomingEventTab extends StatelessWidget {
  const UpcomingEventTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 160,
        width: 160,
        decoration:
            BoxDecoration(color: AppColor.linen, shape: BoxShape.circle),
        child:  SvgPicture.asset(
          Assets.noEventIcon,
        ),
      ),
    );
  }
}
