import 'package:flutter/material.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/utils/app_routes.dart';
import 'package:shop_online/views/widgets/label_with_text_feild.dart';
import 'package:shop_online/views/widgets/main_bottom.dart';
import 'package:shop_online/views/widgets/social_media_bottom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  Text(
                    'Login Account',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please, login with registerd account!',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                  SizedBox(height: 24),
                  LabelWithTextFeild(
                    label: 'Gmail',
                    hintText: 'Enter your Email',
                    icon: Icons.mail,
                    controller: emailController,
                  ),
                  SizedBox(height: 24),
                  LabelWithTextFeild(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.visibility,
                      ),
                    ),
                    label: 'Password',
                    hintText: 'Enter your Password',
                    icon: Icons.lock,
                    controller: passwordController,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  MainBottom(
                    text: 'Login',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushNamed(AppRoutes.homeRoute);
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            AppRoutes.registerRoute,
                          );
                        },
                        child: Text('Register'),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or using other methods',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppColors.grey,
                          ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SocialMediaBottom(
                    imgUrl:
                        'https://image.similarpng.com/very-thumbnail/2020/06/Logo-google-icon-PNG.png',
                    text: 'Login with Google',
                    onTap: () {},
                  ),
                  SizedBox(height: 10),
                  SocialMediaBottom(
                    imgUrl:
                        'https://1000logos.net/wp-content/uploads/2017/02/Facebook-Logosu.png',
                    text: 'Login with Facebook',
                    onTap: () {},
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
