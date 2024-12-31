import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/utils/app_router.dart';
import 'package:shop_online/utils/app_routes.dart';
import 'package:shop_online/view_models/cart_cubit/cart_cubit.dart';
import 'package:shop_online/views/widgets/cart_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CartCubit();
        cubit.getCartsItems();
        return cubit;
      },
      child: Builder(builder: (context) {
        final cubit = BlocProvider.of<CartCubit>(context);
        return BlocBuilder<CartCubit, CartState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is CartLeading ||
              current is CartLoaded ||
              current is CartError,
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
                    SizedBox(
                      height: 12,
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: AppColors.grey3,
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
                      color: AppColors.grey3,
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      bloc: cubit,
                      buildWhen: (brevires, current) =>
                          current is SubtotalUpdated,
                      builder: (context, subtotalState) {
                        if (subtotalState is SubtotalUpdated) {
                          return Column(
                            children: [
                              totalAndSubtotalWidget(
                                  title: 'Subtotal',
                                  amount: subtotalState.subtotal,
                                  context: context),
                              totalAndSubtotalWidget(
                                  title: 'Shipping',
                                  amount: 10,
                                  context: context),
                              SizedBox(height: 5),
                              Dash(
                                dashColor: AppColors.grey4,
                                length: MediaQuery.of(context).size.width - 32,
                              ),
                              SizedBox(height: 5),
                              totalAndSubtotalWidget(
                                  title: 'Total Amount',
                                  amount: subtotalState.subtotal + 10,
                                  context: context),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            totalAndSubtotalWidget(
                                title: 'Subtotal',
                                amount: state.subTotal,
                                context: context),
                            totalAndSubtotalWidget(
                                title: 'Shipping',
                                amount: 10,
                                context: context),
                            SizedBox(height: 5),
                            Dash(
                              dashColor: AppColors.grey4,
                              length: MediaQuery.of(context).size.width - 32,
                            ),
                            SizedBox(height: 5),
                            totalAndSubtotalWidget(
                                title: 'Total Amount',
                                amount: state.subTotal + 10,
                                context: context),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(AppRoutes.checkoutRour);
                          },
                          child: Text(
                            'Ckekout',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.white,
                                ),
                          ),
                        ),
                      ),
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
        );
      }),
    );
  }

  Widget totalAndSubtotalWidget({
    required String title,
    required double amount,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.grey,
                ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
