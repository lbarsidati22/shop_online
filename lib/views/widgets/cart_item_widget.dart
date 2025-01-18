import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/add_to_cart_model.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/view_models/cart_cubit/cart_cubit.dart';
import 'package:shop_online/views/widgets/counter_widget.dart';

class CartItemWidget extends StatelessWidget {
  final AddToCartModel cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.grey3,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CachedNetworkImage(
              height: 125,
              width: 125,
              imageUrl: cartItem.prudact.imgUrl,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.prudact.name,
                  style: Theme.of(context).textTheme.labelLarge!,
                ),
                SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    text: 'Size ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.grey,
                        ),
                    children: [
                      TextSpan(
                        text: cartItem.size.name,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                BlocBuilder<CartCubit, CartState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is QuantityCounterLoaded &&
                      current.prudactId == cartItem.prudact.id,
                  builder: (context, state) {
                    if (state is QuantityCounterLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CounterWidget(
                            value: state.value,
                            cubit: cubit,
                            cartItem: cartItem,
                          ),
                          Text(
                            '\$${state.value * cartItem.prudact.price}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                          initialValue: cartItem.quantity,
                          value: cartItem.quantity,
                          cubit: cubit,
                          cartItem: cartItem,
                        ),
                        Text(
                          '\$${cartItem.totalPrice.toStringAsFixed(1)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
