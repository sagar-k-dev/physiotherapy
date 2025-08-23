import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/widgets/widgets.dart';

import '../../utils/navigators/routes_management.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      RouteManagement.goToEnterCode();
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    if (value.trim().length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (value.trim().length > 20) {
      return 'Username must be less than 20 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase and number';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('Sign Up', style: Styles.whiteBold20),
      ),
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sign Up Form
              SingleChildScrollView(
                padding: EdgeInsets.all(Dimens.sixteen),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username Field
                    CustomTextfield(
                      textEditingController: _usernameController,
                      focusNode: _usernameFocusNode,
                      hintText: 'Username',
                      fillColor: Colors.white,
                      isFilled: true,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChange: (value) {},
                      validator: _validateUsername,
                      onEditingComplete: () {
                        _emailFocusNode.requestFocus();
                      },
                    ),

                    Dimens.boxHeight16,

                    // Email Field
                    CustomTextfield(
                      textEditingController: _emailController,
                      focusNode: _emailFocusNode,
                      hintText: 'Email',
                      fillColor: Colors.white,
                      isFilled: true,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChange: (value) {},
                      validator: _validateEmail,
                      onEditingComplete: () {
                        _passwordFocusNode.requestFocus();
                      },
                    ),

                    Dimens.boxHeight16,

                    // Password Field
                    CustomTextfield(
                      textEditingController: _passwordController,
                      focusNode: _passwordFocusNode,
                      hintText: 'Password',
                      fillColor: Colors.white,
                      isFilled: true,
                      isObscureText: !_isPasswordVisible,
                      textInputAction: TextInputAction.next,
                      onChange: (value) {
                        // Re-validate confirm password when password changes
                        if (_confirmPasswordController.text.isNotEmpty) {
                          setState(() {});
                        }
                      },
                      validator: _validatePassword,
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
                      onEditingComplete: () {
                        _confirmPasswordFocusNode.requestFocus();
                      },
                    ),

                    Dimens.boxHeight16,

                    // Confirm Password Field
                    CustomTextfield(
                      textEditingController: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      hintText: 'Confirm Password',
                      fillColor: Colors.white,
                      isFilled: true,
                      isObscureText: !_isConfirmPasswordVisible,
                      textInputAction: TextInputAction.done,
                      onChange: (value) {},
                      validator: _validateConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),

                    Dimens.boxHeight24,

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        title: 'Sign Up',
                        onTap: _handleSignUp,
                        color: const Color(0xFF4FC3F7),
                      ),
                    ),

                    Dimens.boxHeight24,

                    // Back to Sign In Link
                    GestureDetector(
                      onTap: Get.back,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: Styles.white14.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          Text(
                            'Sign In',
                            style: Styles.white14w500.copyWith(
                              color: const Color(0xFF4FC3F7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Terms and Conditions
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'By signing up, you agree to our Terms of Service and Privacy Policy',
                  style: Styles.white12.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
