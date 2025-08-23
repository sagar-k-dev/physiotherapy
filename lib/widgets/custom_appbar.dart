import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    this.centerTitle,
    this.leading,
    this.actions,
    this.showBorderRadius = true,
    this.autoImplyLeading = true,
    this.titleStyle,
    this.titleWidget,
    this.backgroundColor,
    this.titleSpacing,
  });

  final String? title;
  final bool? centerTitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBorderRadius;
  final bool autoImplyLeading;
  final TextStyle? titleStyle;
  final Widget? titleWidget;
  final Color? backgroundColor;
  final double? titleSpacing;

  @override
  Size get preferredSize => Size.fromHeight(Get.height * 0.06);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: showBorderRadius
          ? BorderRadius.only(
              bottomLeft: Radius.circular(Dimens.twelve),
              bottomRight: Radius.circular(Dimens.twelve),
            )
          : BorderRadius.circular(Dimens.zero),
      child: AppBar(
        title:
            titleWidget ??
            Text(title ?? '', style: titleStyle ?? Styles.black18),
        titleSpacing: titleSpacing ?? Dimens.five,
        centerTitle: centerTitle ?? false,
        automaticallyImplyLeading: autoImplyLeading,
        leading:
            leading ??
            (autoImplyLeading
                ? IconButton(
                    onPressed: Get.back,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                    ),
                  )
                : null),
        leadingWidth: Dimens.fifty,
        actions: actions,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
