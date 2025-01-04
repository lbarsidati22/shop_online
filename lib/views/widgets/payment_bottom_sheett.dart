import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/utils/app_routes.dart';
import 'package:shop_online/view_models/add_new_card_cubit/payment_mothods_cubit.dart';
import 'package:shop_online/views/widgets/main_bottom.dart';

class PaymentBottomSheett extends StatelessWidget {
  const PaymentBottomSheett({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Methods',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 16,
            ),
            BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
              bloc: BlocProvider.of<PaymentMethodsCubit>(context),
              buildWhen: (previous, current) =>
                  current is FetchingPaymentMethods ||
                  current is FetchedPaymentMethods ||
                  current is FetchPaymentMethodsError,
              builder: (_, state) {
                if (state is FetchingPaymentMethods) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is FetchedPaymentMethods) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.paymentCarts.length,
                      itemBuilder: (context, index) {
                        final paymentCarts = state.paymentCarts[index];
                        return Card(
                          color: AppColors.white,
                          child: ListTile(
                            leading: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.grey2,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 8),
                                child: CachedNetworkImage(
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.contain,
                                  imageUrl:
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png',
                                ),
                              ),
                            ),
                            title: Text(paymentCarts.cardNumber),
                            subtitle: Text(paymentCarts.cardHolderName),
                          ),
                        );
                      });
                } else if (state is FetchPaymentMethodsError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(
                      AppRoutes.addNewCartRoute,
                    )
                    .then((onValue) =>
                        PaymentMethodsCubit().fetchPaymentMethod());
              },
              child: Card(
                color: AppColors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.add_circle_outlined,
                    size: 28,
                  ),
                  title: Text(
                    'Add Payment Method',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            MainBottom(
              onTap: () {},
              text: 'Confirm Payment',
            ),
          ],
        ),
      ),
    );
  }
}
