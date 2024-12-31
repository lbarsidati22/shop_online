import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/view_models/cart_cubit/cart_cubit.dart';
import 'package:shop_online/views/widgets/cart_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CartCubit, CartState>(
        bloc: BlocProvider.of<CartCubit>(context),
        builder: (context, state) {
          if (state is CartLeading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CartLoaded) {
            final cartItems = state.cartsItem;
            if (cartItems.isEmpty) {
              return Center(
                child: Text('no item i your cart'),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.grey2,
                      );
                    },
                    itemCount: cartItems.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return CartItemWidget(cartItem: cartItem);
                    },
                  ),
                  Divider(
                    color: AppColors.grey2,
                  ),
                ],
              ),
            );
          } else if (state is CartError) {
            Center(
              child: Text(state.message),
            );
          } else {
            Center(
              child: Text('some thing is rong'),
            );
          }
          return Text('rooong');
        },
      ),
    );
  }
}
