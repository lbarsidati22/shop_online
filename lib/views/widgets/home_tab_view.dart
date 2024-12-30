import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:shop_online/models/home_carousel_item_model.dart';
import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/utils/app_routes.dart';
import 'package:shop_online/view_models/home_cobit/home_cubit.dart';
import 'package:shop_online/views/pages/home_page.dart';
import 'package:shop_online/views/widgets/prudact_item.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLeading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is Homeloaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                FlutterCarousel.builder(
                  itemCount: state.carouselItem.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: state.carouselItem[itemIndex].imgUrl,
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator.adaptive()),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                  options: FlutterCarouselOptions(
                    autoPlay: false,
                    height: size.height * 0.19,
                    //  showIndicator: false,
                    slideIndicator: CircularWaveSlideIndicator(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'New Arrviles',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      'See all',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.prudacts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: size.height * 0.01,
                    crossAxisSpacing: size.height * 0.014,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          AppRoutes.prudactaDetailsRoute,
                          arguments: state.prudacts[index].id,
                        );
                      },
                      child: PrudactItem(
                        prudactItemModel: state.prudacts[index],
                      ),
                    );
                  },
                )
              ],
            ),
          );
        } else if (state is HomeError) {
          return Center(
            child: Text(
              state.error,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
