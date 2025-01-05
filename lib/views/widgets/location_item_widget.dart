import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_online/models/loaction_item_model.dart';
import 'package:shop_online/utils/app_colors.dart';

class LocationItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Color borderColor;
  final LoactionItemModel location;
  const LocationItemWidget({
    super.key,
    required this.onTap,
    required this.location,
    this.borderColor = AppColors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.city,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '${location.city} - ${location.country}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: borderColor,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                      location.imgUrl,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
