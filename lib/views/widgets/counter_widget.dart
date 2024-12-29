import 'package:flutter/material.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/view_models/prudact_details_cubit/prudact_details_cubit.dart';

class CounterWidget extends StatelessWidget {
  final int value;
  final String prudactId;
  final dynamic cubit;
  const CounterWidget({
    super.key,
    required this.value,
    required this.cubit,
    required this.prudactId,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(34),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => cubit.decrementCounter(prudactId),
            icon: Icon(Icons.remove),
          ),
          Text(value.toString()),
          IconButton(
            onPressed: () => cubit.incrementCounter(prudactId),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
