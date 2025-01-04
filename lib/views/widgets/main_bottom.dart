import 'package:flutter/material.dart';
import 'package:shop_online/utils/app_colors.dart';

class MainBottom extends StatelessWidget {
  final double height;
  final VoidCallback? onTap;
  final Color backGroundColor;
  final Color forGroundColor;
  final String text;
  const MainBottom({
    super.key,
    this.height = 60,
    this.onTap,
    this.backGroundColor = AppColors.prymaryColor,
    this.forGroundColor = AppColors.white,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backGroundColor,
          foregroundColor: forGroundColor,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.white,
              ),
        ),
      ),
    );
  }
}
