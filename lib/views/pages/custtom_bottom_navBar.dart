// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shop_online/views/pages/favorite_page.dart';
import 'package:shop_online/views/pages/home_page.dart';
import 'package:shop_online/views/pages/cart_page.dart';
import 'package:shop_online/views/pages/profile_page.dart';

class CusttomBottomNavbarPage extends StatefulWidget {
  const CusttomBottomNavbarPage({super.key});

  @override
  State<CusttomBottomNavbarPage> createState() =>
      _CusttomBottomNavbarPageState();
}

class _CusttomBottomNavbarPageState extends State<CusttomBottomNavbarPage> {
  late final PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.blueGrey,
        activeColorPrimary: Theme.of(context).primaryColor,
        icon: Icon(
          CupertinoIcons.home,
        ),
        title: 'Home',
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.blueGrey,
        activeColorPrimary: Theme.of(context).primaryColor,
        icon: Icon(
          CupertinoIcons.shopping_cart,
        ),
        title: 'Order',
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.blueGrey,
        activeColorPrimary: Theme.of(context).primaryColor,
        icon: Icon(
          CupertinoIcons.heart,
        ),
        title: 'Favorite',
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.blueGrey,
        activeColorPrimary: Theme.of(context).primaryColor,
        icon: Icon(
          CupertinoIcons.person,
        ),
        title: 'Person',
      )
    ];
  }

  int currentIndex = 0;
  List<Widget> screens = [
    HomePage(),
    CartPage(),
    FavoritePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/lbar.jpg'),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lbar Sidati',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(),
            ),
            Text(
              'Let\'s go shooping',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
        actions: [
          if (currentIndex == 0) ...[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
          ] else if (currentIndex == 1)
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_bag),
            )
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: screens,
        items: navBarItems(),
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: false,
        hideNavigationBarWhenKeyboardAppears: true,
        padding: const EdgeInsets.only(top: 7, bottom: 5),
        isVisible: true,
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            animateTabTransition: true,
            duration: Duration(milliseconds: 200),
            screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
          ),
        ),
        confineToSafeArea: true,
        navBarHeight: kBottomNavigationBarHeight,
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
