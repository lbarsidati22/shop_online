import 'package:flutter/material.dart';
import 'package:shop_online/models/add_to_cart_model.dart';
import 'package:shop_online/utils/app_colors.dart';

class CounterWidget extends StatelessWidget {
  final int value;
  final String? prudactId;
  final AddToCartModel? cartItem;
  final dynamic cubit;
  final int? initialValue;
  const CounterWidget({
    super.key,
    this.cartItem,
    this.initialValue,
    required this.value,
    required this.cubit,
    this.prudactId,
  }) : assert(cartItem != null || prudactId != null);
  Future<void> decrementCounter(
    dynamic param,
  ) async {
    if (initialValue != null) {
      await cubit.decrementCounter(param, initialValue);
    } else {
      await cubit.decrementCounter(param);
    }
  }

  Future<void> incrementCounter(
    dynamic param,
  ) async {
    if (initialValue != null) {
      await cubit.incrementCounter(param, initialValue);
    } else {
      await cubit.incrementCounter(param);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grey3,
        borderRadius: BorderRadius.circular(34),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => cartItem != null
                ? decrementCounter(cartItem)
                : decrementCounter(prudactId),
            icon: Icon(Icons.remove),
          ),
          Text(value.toString()),
          IconButton(
            onPressed: () => cartItem != null
                ? incrementCounter(cartItem)
                : incrementCounter(prudactId),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
