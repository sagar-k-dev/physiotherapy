import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/utils/utils.dart';
import 'package:physiotherapy/widgets/widgets.dart';

import '../../utils/navigators/routes_management.dart';

class EnterCodeView extends StatefulWidget {
  const EnterCodeView({super.key});

  @override
  State<EnterCodeView> createState() => _EnterCodeViewState();
}

class _EnterCodeViewState extends State<EnterCodeView> {
  final List<TextEditingController> _pinControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _pinFocusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _enteredPin = '';

  @override
  void initState() {
    super.initState();
    // Add listeners to track PIN changes
    for (int i = 0; i < 4; i++) {
      _pinControllers[i].addListener(() {
        _updatePin();
      });
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < 4; i++) {
      _pinControllers[i].dispose();
      _pinFocusNodes[i].dispose();
    }
    super.dispose();
  }

  void _updatePin() {
    _enteredPin = _pinControllers.map((controller) => controller.text).join();
    AppLog.info('PIN entered: $_enteredPin');
  }

  void _handleVerifyCode() {
    if (_formKey.currentState!.validate()) {
      if (_enteredPin.length == 4) {
        // TODO: Implement verification logic
        AppLog.info('Verifying code: $_enteredPin');
        RouteManagement.goToPhysiotherapistHome();
      } else {
        // Show error for incomplete PIN
        Get.snackbar(
          'Error',
          'Please enter the complete 4-digit code',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void _handleResendCode() {
    // TODO: Implement resend code logic
    AppLog.info('Resend code pressed');
    Get.snackbar(
      'Success',
      'Verification code has been resent',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _handleBackToSignIn() {
    Get.back();
  }

  String? _validatePinField(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    if (value.length > 1) {
      return '';
    }
    if (!RegExp(r'^[0-9]$').hasMatch(value)) {
      return '';
    }
    return null;
  }

  void _onPinChanged(String value, int index) {
    if (value.length == 1) {
      // Move to next field
      if (index < 3) {
        _pinFocusNodes[index + 1].requestFocus();
      } else {
        // Last field filled, hide keyboard
        _pinFocusNodes[index].unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      // Move to previous field on backspace
      _pinFocusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: _handleBackToSignIn,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('Enter Code', style: Styles.whiteBold20),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header Section
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    Dimens.boxHeight24,

                    // Title
                    Text(
                      'Verification Code',
                      style: Styles.whiteBold20,
                      textAlign: TextAlign.center,
                    ),

                    Dimens.boxHeight16,

                    // Description
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.thirty),
                      child: Text(
                        'We have sent a 4-digit verification code to your email address. Please enter it below.',
                        style: Styles.white14.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              // PIN Entry Section
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(Dimens.twenty),
                  child: Column(
                    children: [
                      // PIN Input Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          4,
                          (index) => Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(Dimens.ten),
                              border: Border.all(
                                color: _pinFocusNodes[index].hasFocus
                                    ? const Color(0xFF4FC3F7)
                                    : Colors.grey.withValues(alpha: 0.3),
                                width: 2,
                              ),
                            ),
                            child: TextFormField(
                              controller: _pinControllers[index],
                              focusNode: _pinFocusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(1),
                              ],
                              style: Styles.blackBold20.copyWith(fontSize: 24),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              validator: _validatePinField,
                              onChanged: (value) => _onPinChanged(value, index),
                              autofocus: index == 0,
                            ),
                          ),
                        ),
                      ),

                      Dimens.boxHeight32,

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          title: 'Verify Code',
                          onTap: _handleVerifyCode,
                          color: const Color(0xFF4FC3F7),
                        ),
                      ),

                      Dimens.boxHeight24,

                      // Resend Code Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code? ",
                            style: Styles.white14.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          GestureDetector(
                            onTap: _handleResendCode,
                            child: Text(
                              'Resend',
                              style: Styles.white14w500.copyWith(
                                color: const Color(0xFF4FC3F7),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Dimens.boxHeight16,

                      // Timer (Optional - can be implemented later)
                      Text(
                        'Resend available in 30 seconds',
                        style: Styles.white12.copyWith(
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Section
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    // Back to Sign In Link
                    GestureDetector(
                      onTap: _handleBackToSignIn,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Back to ',
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

                    const Spacer(),

                    // Terms and Conditions
                    Padding(
                      padding: EdgeInsets.all(Dimens.twenty),
                      child: Text(
                        'By continuing, you agree to our Terms of Service and Privacy Policy',
                        style: Styles.white12.copyWith(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
