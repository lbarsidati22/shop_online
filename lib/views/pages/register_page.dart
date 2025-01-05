import 'package:flutter/material.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/utils/app_routes.dart';
import 'package:shop_online/views/widgets/label_with_text_feild.dart';
import 'package:shop_online/views/widgets/main_bottom.dart';
import 'package:shop_online/views/widgets/social_media_bottom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
final userNameController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<RegisterPage> {
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
                    'Create Account',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Get started with create your account',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                  SizedBox(height: 24),
                  LabelWithTextFeild(
                    label: 'UserName',
                    hintText: 'Enter your Name',
                    icon: Icons.person,
                    controller: userNameController,
                  ),
                  SizedBox(height: 16),
                  LabelWithTextFeild(
                    label: 'Gmail',
                    hintText: 'Enter your Email',
                    icon: Icons.mail,
                    controller: emailController,
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  MainBottom(
                    text: 'Register',
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
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text('Login'),
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
                    text: 'Register with Google',
                    onTap: () {},
                  ),
                  SizedBox(height: 10),
                  SocialMediaBottom(
                    imgUrl:
                        'https://1000logos.net/wp-content/uploads/2017/02/Facebook-Logosu.png',
                    text: 'Register with Facebook',
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
