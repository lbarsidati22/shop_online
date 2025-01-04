import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/view_models/add_new_card_cubit/add_new_card_cubit.dart';
import 'package:shop_online/views/widgets/label_with_text_feild_new_cart.dart';

class AddNewCartPage extends StatefulWidget {
  const AddNewCartPage({super.key});

  @override
  State<AddNewCartPage> createState() => _AddNewCartPageState();
}

class _AddNewCartPageState extends State<AddNewCartPage> {
  final TextEditingController _cartNumberController = TextEditingController();
  final TextEditingController _cartHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDataController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddNewCardCubit>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Cart'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWithTextFeildNewCart(
                    label: 'Cart Number',
                    hintText: 'Enter cart number',
                    icon: Icons.credit_card,
                    controller: _cartNumberController,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  LabelWithTextFeildNewCart(
                    label: 'Cart Holder Name',
                    hintText: 'Enter cart Holder Name',
                    icon: Icons.person,
                    controller: _cartHolderNameController,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  LabelWithTextFeildNewCart(
                    label: 'Expiry Date',
                    hintText: 'Enter Expiry Date',
                    icon: Icons.date_range,
                    controller: _expiryDataController,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  LabelWithTextFeildNewCart(
                    label: 'CVV',
                    hintText: 'Enter CVV',
                    icon: Icons.password,
                    controller: _cvvController,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.07,
                    child: BlocConsumer<AddNewCardCubit, AddNewCardState>(
                      listenWhen: (previous, current) =>
                          current is AddNewCardLoaded ||
                          current is AddNewCardError ||
                          current is AddNewCardLeading,
                      listener: (context, state) {
                        if (state is AddNewCardLoaded) {
                          Navigator.pop(context);
                        } else if (state is AddNewCardError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is AddNewCardLoaded ||
                          current is AddNewCardError,
                      bloc: cubit,
                      builder: (context, state) {
                        if (state is AddNewCardLeading) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.prymaryColor,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: null,
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.prymaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.addNewCard(
                                _cartNumberController.text,
                                _cartHolderNameController.text,
                                _expiryDataController.text,
                                _cvvController.text,
                              );
                            }
                          },
                          child: Text(
                            'Add Cart',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
