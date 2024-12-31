import 'package:flutter/material.dart';
import 'package:shop_online/utils/app_colors.dart';

class EmptyShoppingPeyment extends StatelessWidget {
  final String title;
  const EmptyShoppingPeyment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        child: Column(
          children: [
            Icon(Icons.add, size: 28),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ),
      ),
    );
  }
}
