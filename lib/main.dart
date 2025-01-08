import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/utils/app_router.dart';
import 'package:shop_online/utils/app_routes.dart';
import 'package:shop_online/view_models/auth_cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..checkAuth(),
      child: Builder(builder: (context) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        return BlocBuilder<AuthCubit, AuthState>(
          bloc: authCubit,
          buildWhen: (previous, current) =>
              current is AuthDone || current is AuthInitial,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Shop-Online',
              theme: ThemeData(
                primaryColor: Colors.deepPurple,
                useMaterial3: true,
              ),
              initialRoute: state is AuthDone
                  ? AppRoutes.homeRoute
                  : AppRoutes.loginRoute,
              onGenerateRoute: AppRouter.onGenariteRoute,
            );
          },
        );
      }),
    );
  }
}
