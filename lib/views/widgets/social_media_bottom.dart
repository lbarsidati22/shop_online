import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_online/utils/app_colors.dart';

class SocialMediaBottom extends StatelessWidget {
  final String? text;
  final String? imgUrl;
  final VoidCallback? onTap;
  final bool isLeading;
  SocialMediaBottom({
    super.key,
    this.text,
    this.imgUrl,
    this.onTap,
    this.isLeading = false,
  }) {
    assert((text != null && imgUrl != null) || isLeading == true);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLeading
              ? CircularProgressIndicator.adaptive()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imgUrl!,
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      text!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
