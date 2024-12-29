import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:shop_online/models/home_carousel_item_model.dart';
import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/views/widgets/prudact_item.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FlutterCarousel.builder(
            itemCount: dummyHomeCarouselItems.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Padding(
                padding: EdgeInsetsDirectional.only(end: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: dummyHomeCarouselItems[itemIndex].imgUrl,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator.adaptive()),
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
              height: 160.0,
              showIndicator: true,
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
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: dummyProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return PrudactItem(prudactItemModel: dummyProducts[index]);
            },
          )
        ],
      ),
    );
  }
}
