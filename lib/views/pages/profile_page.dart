import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/utils/app_routes.dart';
import 'package:shop_online/view_models/auth_cubit/auth_cubit.dart';
import 'package:shop_online/views/widgets/main_bottom.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              current is AuthLogeOutError || current is AuthLoggedOut,
          listener: (context, state) {
            if (state is AuthLoggedOut) {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(
                      AppRoutes.loginRoute, (route) => false);
            } else if (state is AuthLogeOutError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          bloc: cubit,
          buildWhen: (previous, current) => current is AuthLogingOut,
          builder: (context, state) {
            if (state is AuthLogingOut) {
              return MainBottom(
                isLeading: true,
              );
            }
            return MainBottom(
              text: 'LogOut',
              onTap: () async {
                await cubit.logOut();
              },
            );
          },
        ),
      ),
    );
  }
}
