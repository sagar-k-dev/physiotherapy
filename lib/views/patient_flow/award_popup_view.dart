import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';

class AwardPopupView extends StatefulWidget {
  const AwardPopupView({super.key});

  @override
  State<AwardPopupView> createState() => _AwardPopupViewState();
}

class _AwardPopupViewState extends State<AwardPopupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(Dimens.sixteen),
            padding: EdgeInsets.all(Dimens.twenty),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimens.twenty),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close Button
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(Dimens.eight),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                Dimens.boxHeight16,

                // Award Content
                _buildAwardContent(),

                Dimens.boxHeight24,

                // Social Media Sharing
                _buildSocialSharing(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAwardContent() {
    return Column(
      children: [
        // NEW AWARD Label
        Text(
          'NEW AWARD',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Dimens.twelve,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),

        Dimens.boxHeight8,

        // Congratulations
        Text('Congratulations', style: Styles.blackBold20),

        Dimens.boxHeight8,

        // Description
        Text(
          'You have received an appreciation.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Dimens.forteen,
          ),
          textAlign: TextAlign.center,
        ),

        Dimens.boxHeight24,

        // Award Icon with Confetti
        Stack(
          alignment: Alignment.center,
          children: [
            // Confetti Background
            Container(
              width: 120,
              height: 120,
              child: Stack(
                children: [
                  // Confetti dots
                  Positioned(
                    top: 10,
                    left: 20,
                    child: _buildConfettiDot(Colors.yellow),
                  ),
                  Positioned(
                    top: 30,
                    right: 15,
                    child: _buildConfettiDot(Colors.blue),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 15,
                    child: _buildConfettiDot(Colors.grey),
                  ),
                  Positioned(
                    bottom: 40,
                    right: 25,
                    child: _buildConfettiDot(Colors.yellow),
                  ),
                  Positioned(
                    top: 50,
                    left: 40,
                    child: _buildConfettiDot(Colors.blue),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 40,
                    child: _buildConfettiDot(Colors.grey),
                  ),
                ],
              ),
            ),

            // Award Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.amber.shade400,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 50,
              ),
            ),
          ],
        ),

        Dimens.boxHeight24,

        // Award Stats
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem('1', 'awards'),
            Container(width: 1, height: 30, color: Colors.grey.shade300),
            _buildStatItem('1', 'rank'),
          ],
        ),
      ],
    );
  }

  Widget _buildConfettiDot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(number, style: Styles.blackBold16),
        Dimens.boxHeight4,
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Dimens.twelve,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSharing() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimens.sixteen),
      decoration: BoxDecoration(
        color: ColorsValue.primaryColor,
        borderRadius: BorderRadius.circular(Dimens.twelve),
      ),
      child: Column(
        children: [
          Text(
            'Share it with your friends on',
            style: Styles.white14,
            textAlign: TextAlign.center,
          ),

          Dimens.boxHeight16,

          // Social Media Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialIcon(
                Icons.facebook,
                Colors.blue.shade600,
                'Facebook',
              ),
              _buildSocialIcon(
                Icons.chat_bubble,
                Colors.green.shade600,
                'WhatsApp',
              ),
              _buildSocialIcon(
                Icons.camera_alt,
                Colors.purple.shade600,
                'Instagram',
              ),
              _buildSocialIcon(
                Icons.flutter_dash,
                Colors.blue.shade400,
                'Twitter',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color, String platform) {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          'Sharing',
          'Sharing to $platform...',
          backgroundColor: color,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      },
      child: Container(
        padding: EdgeInsets.all(Dimens.twelve),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Dimens.eight),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}
