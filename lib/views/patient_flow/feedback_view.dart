import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';

class FeedbackView extends StatefulWidget {
  final String exerciseName;
  final String exerciseNumber;

  const FeedbackView({
    super.key,
    required this.exerciseName,
    required this.exerciseNumber,
  });

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  bool?
  paceFeedback; // true for thumbs up, false for thumbs down, null for no selection
  int painLevel = 0; // 0-5 scale

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Exercise Title
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.sixteen,
                vertical: Dimens.twelve,
              ),
              child: Text(
                '${widget.exerciseNumber} ${widget.exerciseName}',
                style: Styles.whiteBold16,
                textAlign: TextAlign.center,
              ),
            ),

            // Feedback Form Card
            Expanded(
              child: Container(
                margin: EdgeInsets.all(Dimens.sixteen),
                padding: EdgeInsets.all(Dimens.twenty),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimens.twenty),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Success Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    Dimens.boxHeight16,

                    // Title
                    Text('Send Feedback!', style: Styles.blackBold16),

                    Dimens.boxHeight32,

                    // Pace Feedback Section
                    _buildPaceFeedback(),

                    Dimens.boxHeight32,

                    // Pain Feedback Section
                    _buildPainFeedback(),

                    const Spacer(),
                  ],
                ),
              ),
            ),

            // Send Button
            Container(
              padding: EdgeInsets.all(Dimens.sixteen),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canSubmit() ? _submitFeedback : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: Dimens.sixteen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.eight),
                    ),
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontSize: Dimens.forteen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaceFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Did you keep up the pace?', style: Styles.blackBold14),
        Dimens.boxHeight16,

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Thumbs Up
            GestureDetector(
              onTap: () {
                setState(() {
                  paceFeedback = true;
                });
              },
              child: Container(
                padding: EdgeInsets.all(Dimens.sixteen),
                decoration: BoxDecoration(
                  color: paceFeedback == true
                      ? Colors.green.shade100
                      : Colors.transparent,
                  border: Border.all(color: Colors.green.shade400, width: 2),
                  borderRadius: BorderRadius.circular(Dimens.eight),
                ),
                child: Icon(
                  Icons.thumb_up_outlined,
                  color: Colors.green.shade600,
                  size: 32,
                ),
              ),
            ),

            // Thumbs Down
            GestureDetector(
              onTap: () {
                setState(() {
                  paceFeedback = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(Dimens.sixteen),
                decoration: BoxDecoration(
                  color: paceFeedback == false
                      ? Colors.red.shade100
                      : Colors.transparent,
                  border: Border.all(color: Colors.red.shade400, width: 2),
                  borderRadius: BorderRadius.circular(Dimens.eight),
                ),
                child: Icon(
                  Icons.thumb_down_outlined,
                  color: Colors.red.shade600,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPainFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How was your pain?', style: Styles.blackBold14),
        Dimens.boxHeight16,

        // Emoji Pain Scale
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  painLevel = index;
                });
              },
              child: Container(
                padding: EdgeInsets.all(Dimens.eight),
                decoration: BoxDecoration(
                  color: painLevel == index
                      ? Colors.blue.shade100
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimens.eight),
                ),
                child: Text(
                  _getPainEmoji(index),
                  style: TextStyle(fontSize: 24),
                ),
              ),
            );
          }),
        ),

        Dimens.boxHeight16,

        // Color Gradient Bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              colors: [Colors.green, Colors.yellow, Colors.orange, Colors.red],
            ),
          ),
        ),

        Dimens.boxHeight8,

        // Pain Level Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'No Pain',
              style: TextStyle(
                color: Colors.green.shade600,
                fontSize: Dimens.ten,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Severe Pain',
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: Dimens.ten,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getPainEmoji(int level) {
    switch (level) {
      case 0:
        return '😄'; // Very happy
      case 1:
        return '🙂'; // Happy
      case 2:
        return '😐'; // Neutral
      case 3:
        return '😕'; // Slightly sad
      case 4:
        return '😢'; // Sad
      case 5:
        return '😭'; // Very sad/crying
      default:
        return '😐';
    }
  }

  bool _canSubmit() {
    return paceFeedback != null; // Pain level is optional
  }

  void _submitFeedback() {
    // Handle feedback submission
    Get.snackbar(
      'Feedback Submitted',
      'Thank you for your feedback!',
      backgroundColor: Colors.green.shade400,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );

    // Navigate back to session view or home
    Future.delayed(const Duration(seconds: 2), () {
      Get.until((route) => route.isFirst);
    });
  }
}
