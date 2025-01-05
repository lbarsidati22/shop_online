import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/utils/app_routes.dart';
import 'package:shop_online/view_models/checkout_cubit/checkout_cubit.dart';

class EmptyShoppingPeyment extends StatelessWidget {
  final String title;
  final bool isPayment;
  const EmptyShoppingPeyment({
    super.key,
    required this.title,
    required this.isPayment,
  });

  @override
  Widget build(BuildContext context) {
    final checkouCubit = BlocProvider.of<CheckoutCubit>(context);
    return InkWell(
      onTap: () {
        if (isPayment) {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoutes.addNewCartRoute)
              .then((value) => checkouCubit.getCartItems());
        } else {
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(AppRoutes.choseLocationRoute);
        }
      },
      child: Container(
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
      ),
    );
  }
}
