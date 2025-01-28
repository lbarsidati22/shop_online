import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/loaction_item_model.dart';
import 'package:shop_online/models/payment_cart_model.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/utils/app_routes.dart';
import 'package:shop_online/view_models/add_new_card_cubit/payment_mothods_cubit.dart';
import 'package:shop_online/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:shop_online/views/pages/empty_shopping_peyment.dart';
import 'package:shop_online/views/widgets/checkout_headlins_item.dart';
import 'package:shop_online/views/widgets/payment_bottom_sheett.dart';
import 'package:shop_online/views/widgets/payment_method_item.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});
  Widget buildPaymentMethod(
      PaymentCartModel? chosenCard, BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    final paymentMethodsCubit = BlocProvider.of<PaymentMethodsCubit>(context);
    if (chosenCard != null) {
      return PaymentMethodItem(
        paymentCart: chosenCard,
        onItemTap: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: double.infinity,
                  child: BlocProvider(
                    create: (context) =>
                        PaymentMethodsCubit()..fetchPaymentMethod(),
                    child: PaymentBottomSheett(),
                  ),
                );
              }).then((value) async {
            await checkoutCubit.getCartItems();
          });
        },
      );
    } else {
      return EmptyShoppingPeyment(
        isPayment: true,
        title: 'Add Payment Method',
      );
    }
  }

  Widget buildShippingItem(LoactionItemModel? chosenAddress, context) {
    if (chosenAddress != null) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              imageUrl: chosenAddress.imgUrl,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chosenAddress.city,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: 8),
              Text(
                '${chosenAddress.city} - ${chosenAddress.country}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.grey,
                    ),
              ),
            ],
          ),
        ],
      );
    } else {
      return EmptyShoppingPeyment(
        isPayment: false,
        title: 'Add Shopping Address',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = CheckoutCubit();
            cubit.getCartItems();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => PaymentMethodsCubit(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Checkout'),
        ),
        body: Builder(builder: (context) {
          final cubit = BlocProvider.of<CheckoutCubit>(context);
          return BlocBuilder<CheckoutCubit, CheckoutState>(
            bloc: cubit,
            buildWhen: (previous, current) =>
                current is CheckoutLeading ||
                current is CheckoutError ||
                current is CheckoutLoaded,
            builder: (context, state) {
              if (state is CheckoutLeading) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is CheckoutError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is CheckoutLoaded) {
                final cartItems = state.cartItems;
                final chosenPaymentCards = state.chosenPaymentCards;
                final chosenAddress = state.chosenAdderss;
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          CheckoutHeadlinsItem(
                            title: 'Address',
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(AppRoutes.choseLocationRoute)
                                  .then((value) async {
                                await cubit.getCartItems();
                              });
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          buildShippingItem(chosenAddress, context),
                          SizedBox(
                            height: 16,
                          ),
                          CheckoutHeadlinsItem(
                            title: 'Prudact',
                            numOfPrudact: state.numOfPrudacts,
                          ),
                          SizedBox(height: 8),
                          ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: AppColors.grey2,
                              );
                            },
                            shrinkWrap: true,
                            itemCount: cartItems.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final cartItem = cartItems[index];
                              return Row(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItem.prudact.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!,
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text: 'Size ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      color: AppColors.grey,
                                                    ),
                                                children: [
                                                  TextSpan(
                                                    text: cartItem.size.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(),
                                                  ),
                                                ],
                                              ),
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          CheckoutHeadlinsItem(
                            title: 'Payment Method',
                          ),
                          SizedBox(height: 14),
                          buildPaymentMethod(chosenPaymentCards, context),
                          SizedBox(height: 14),
                          Divider(
                            color: AppColors.grey,
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total amount',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColors.grey,
                                    ),
                              ),
                              Text(
                                '\$${state.totalAmount.toStringAsFixed(1)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 35),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                'Checkout Now',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColors.white,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text('something is rong'),
                );
              }
            },
          );
        }),
      ),
    );
  }
}
