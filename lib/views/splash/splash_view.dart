import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import '../../controllers/splash/splash_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});

  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ColorsValue.primaryColor,
    body: Center(
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .4),
          borderRadius: BorderRadius.circular(50),
        ),
        child: SvgPicture.asset(AssetConstants.splashLogo),
      ),
    ),
  );
}
