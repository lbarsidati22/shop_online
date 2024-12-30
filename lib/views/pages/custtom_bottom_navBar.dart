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
        activeColorPrimary: Colors.deepPurple,
        icon: Icon(
          CupertinoIcons.home,
        ),
        title: 'Home',
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.blueGrey,
        activeColorPrimary: Colors.deepPurple,
        icon: Icon(
          CupertinoIcons.shopping_cart,
        ),
        title: 'Order',
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.blueGrey,
        activeColorPrimary: Colors.deepPurple,
        icon: Icon(
          CupertinoIcons.heart,
        ),
        title: 'Favorite',
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.blueGrey,
        activeColorPrimary: Colors.deepPurple,
        icon: Icon(
          CupertinoIcons.person,
        ),
        title: 'Person',
      )
    ];
  }

  List<Widget> screens = [
    HomePage(),
    CartPage(),
    FavoritePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: screens,
      items: navBarItems(),
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      // popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
      padding: const EdgeInsets.only(top: 7, bottom: 5),
      //backgroundColor: Colors.grey.shade900,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property
    );
  }
}
