import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:shop_online/models/home_carousel_item_model.dart';
import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/view_models/home_cobit/home_cubit.dart';
import 'package:shop_online/views/widgets/category_tab_view.dart';
import 'package:shop_online/views/widgets/home_tab_view.dart';
import 'package:shop_online/views/widgets/prudact_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeData();
        return cubit;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: AppColors.grey,
              controller: _tabController,
              tabs: [
                Tab(
                  text: 'Home',
                ),
                Tab(
                  text: 'Categoey',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  HomeTabView(),
                  CategoryTabView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
