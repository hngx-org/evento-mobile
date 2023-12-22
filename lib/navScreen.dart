import 'package:evento/ui/screens/explore/explore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'core/assets/assets.dart';
import 'ui/common/colors.dart';
import 'ui/screens/auth/login_screen.dart';

class NavScreen extends StatefulWidget {
  static const String name = 'nav-screen';
  static const String path = '/nav-screen';

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  final List<Widget> widgetPages = <Widget>[
    Text('Home Screen'),
    Text('Create Event Screen'),
    ExplorePage(),
    Text('Settings Screen'),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: widgetPages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.homeIcon,
            color: _selectedIndex == 0 ? AppColor.primaryColor : Colors.grey,
            height: 24.0,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.addIcon,
            color: _selectedIndex == 1 ? AppColor.primaryColor : Colors.grey,
            height: 24.0,
          ),
          label: 'Create Event',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.discoverIcon,
            color: _selectedIndex == 2 ? AppColor.primaryColor : Colors.grey,
            height: 30.0,
          ),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.settings2Icon,
            color: _selectedIndex == 3 ? AppColor.primaryColor : Colors.grey,
            // height: 24.0,
          ),
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: _onItemTap,
      selectedFontSize: 13.0,
      unselectedFontSize: 13.0,
    );
  }
}
