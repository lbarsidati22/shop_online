import 'package:flutter/material.dart';

class CheckoutHeadlinsItem extends StatelessWidget {
  final String title;
  final int? numOfPrudact;
  final VoidCallback? onTap;
  const CheckoutHeadlinsItem({
    super.key,
    required this.title,
    this.numOfPrudact,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (numOfPrudact != null)
              Text(
                '($numOfPrudact)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
          ],
        ),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: Text('Edit'),
          ),
      ],
    );
  }
}
