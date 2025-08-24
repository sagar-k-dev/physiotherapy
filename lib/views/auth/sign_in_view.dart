import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/utils/navigators/navigators.dart';
import 'package:physiotherapy/utils/utils.dart';
import 'package:physiotherapy/widgets/widgets.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    RouteManagement.goToHome();
  }

  void _handleForgotPassword() {
    // TODO: Navigate to forgot password screen
    AppLog.info('Forgot password pressed');
  }

  void _handleSignUp() {
    RouteManagement.goToSignUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      body: Column(
        children: [
          Container(
            height: Get.height * 0.4,
            decoration: BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.vertical(
                bottom: Radius.circular(20),
              ),
              child: Image.asset(
                'assets/images/sign_in_image.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Login',
              style: Styles.whiteBold20,
              textAlign: TextAlign.center,
            ),
          ),

          // Login Form
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Dimens.sixteen),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextfield(
                  textEditingController: _emailController,
                  focusNode: _emailFocusNode,
                  hintText: 'Email',
                  fillColor: Colors.white,
                  isFilled: true,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChange: (value) {},
                  onEditingComplete: () {
                    _passwordFocusNode.requestFocus();
                  },
                ),
                Dimens.boxHeight16,
                CustomTextfield(
                  textEditingController: _passwordController,
                  focusNode: _passwordFocusNode,
                  hintText: 'Password',
                  fillColor: Colors.white,
                  isFilled: true,
                  isObscureText: !_isPasswordVisible,
                  textInputAction: TextInputAction.done,
                  onChange: (value) {},
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),

                Dimens.boxHeight20,

                // Forgot Password and Login Button Row
                Row(
                  children: [
                    // Forgot Password Link
                    GestureDetector(
                      onTap: _handleForgotPassword,
                      child: Text(
                        'Forgot password?',
                        style: Styles.white12w500.copyWith(color: Colors.white),
                      ),
                    ),

                    const Spacer(),

                    // Login Button
                    GestureDetector(
                      onTap: _handleSignIn,
                      child: Container(
                        width: Dimens.forty,
                        height: Dimens.forty,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4FC3F7), // Light blue
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Dimens.boxHeight24,

          // Sign Up Link
          GestureDetector(
            onTap: _handleSignUp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New User? ',
                  style: Styles.white14.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  'Sign Up',
                  style: Styles.white14w500.copyWith(
                    color: const Color(0xFF4FC3F7),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Terms and Conditions
          Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              'By signing in, you agree to our Terms of Service and Privacy Policy',
              style: Styles.white12.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
