import 'package:flutter/material.dart';

class CustomDotIndicator extends StatelessWidget {
  const CustomDotIndicator({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.itemCount,
    required this.radius,
    this.activeColor,
    this.padding,
  });

  final PageController pageController;
  final int currentPage;
  final int itemCount;
  final double? radius;
  final double? padding;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: padding ?? 10),
          child: GestureDetector(
            onTap: () {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            },
            child: CircleAvatar(
              radius: radius ?? 6,
              backgroundColor: currentPage == index
                  ? (activeColor ?? Colors.white)
                  : Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}
