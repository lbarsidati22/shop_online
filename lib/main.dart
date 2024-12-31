import 'package:flutter/material.dart';
import 'package:shop_online/utils/app_router.dart';
import 'package:shop_online/views/pages/custtom_bottom_navBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop-Online',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const CusttomBottomNavbarPage(),
      onGenerateRoute: AppRouter.onGenariteRoute,
    );
  }
}
