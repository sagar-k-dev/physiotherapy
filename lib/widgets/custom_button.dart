import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/utils/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.titleWidget,
    required this.title,
    this.buttonType = ButtonType.continued,
    required this.onTap,
    this.isDisable,
    this.color,
    this.borderColor,
    this.titleColor,
  });

  final Widget? titleWidget;
  final String title;
  final ButtonType? buttonType;
  final Function() onTap;
  final bool? isDisable;
  final Color? color;
  final Color? borderColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) => InkWell(
    enableFeedback: false,
    onTap: isDisable == true ? null : onTap,
    child: Container(
      height: Dimens.fortySix,
      width: Get.width,
      decoration: BoxDecoration(
        color: buttonType == ButtonType.continued
            ? isDisable == true
                  ? Colors.grey.withValues(alpha: .6)
                  : color ?? ColorsValue.primaryColor
            : color ?? Colors.white,
        borderRadius: BorderRadius.circular(Dimens.ten),
        border: Border.all(
          color:
              borderColor ??
              (buttonType == ButtonType.cancelled
                  ? ColorsValue.primaryColor
                  : Colors.transparent),
          width: 1.5,
        ),
      ),
      child: Center(
        child:
            titleWidget ??
            Text(
              title,
              style: Styles.whiteBold14.copyWith(
                color:
                    titleColor ??
                    (buttonType == ButtonType.continued
                        ? Colors.white
                        : ColorsValue.primaryColor),
              ),
            ),
      ),
    ),
  );
}
