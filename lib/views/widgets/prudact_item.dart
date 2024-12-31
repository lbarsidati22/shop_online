import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/utils/app_colors.dart';

class PrudactItem extends StatelessWidget {
  final PrudactItemModel prudactItemModel;
  const PrudactItem({super.key, required this.prudactItemModel});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: size.height * 0.15,
              width: size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.grey3,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: prudactItemModel.imgUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          prudactItemModel.name,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          prudactItemModel.category,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.grey,
                //  fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          '\$${prudactItemModel.price}',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                //  color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
        )
      ],
    );
  }
}
