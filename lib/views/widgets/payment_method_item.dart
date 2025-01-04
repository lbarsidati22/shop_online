import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_online/models/payment_cart_model.dart';
import 'package:shop_online/utils/app_colors.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentCartModel paymentCart;
  final VoidCallback onItemTap;
  const PaymentMethodItem(
      {super.key, required this.paymentCart, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.grey,
          ),
        ),
        child: ListTile(
          leading: CachedNetworkImage(
            height: 50,
            width: 50,
            fit: BoxFit.contain,
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png',
          ),
          title: Text('MACTER CARD'),
          subtitle: Text(paymentCart.cardNumber),
          trailing: Icon(
            Icons.chevron_right_sharp,
          ),
        ),
      ),
    );
  }
}
