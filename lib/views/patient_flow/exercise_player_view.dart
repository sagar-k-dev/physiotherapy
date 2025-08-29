import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/views/patient_flow/feedback_view.dart';

class ExercisePlayerView extends StatefulWidget {
  final String exerciseName;
  final String exerciseNumber;

  const ExercisePlayerView({
    super.key,
    required this.exerciseName,
    required this.exerciseNumber,
  });

  @override
  State<ExercisePlayerView> createState() => _ExercisePlayerViewState();
}

class _ExercisePlayerViewState extends State<ExercisePlayerView> {
  int currentReps = 0;
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Video Player Section (Top 40%)
            Expanded(flex: 4, child: _buildVideoPlayer()),

            // Control Panel Section (Bottom 60%)
            Expanded(flex: 6, child: _buildControlPanel()),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade900),
      child: Stack(
        children: [
          // Video Placeholder
          Center(child: _buildVideoPlaceholder()),

          // Video Controls Overlay
          Positioned(
            top: Dimens.sixteen,
            left: Dimens.sixteen,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(Dimens.eight),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(Dimens.eight),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.grey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Person Icon (representing the exercise video)
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getExerciseIcon(widget.exerciseName),
              size: 60,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          Dimens.boxHeight16,
          Text(
            'Exercise Video',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: Dimens.forteen,
              fontWeight: FontWeight.w500,
            ),
          ),
          Dimens.boxHeight8,
          Text(
            widget.exerciseName,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: Dimens.twelve,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: EdgeInsets.all(Dimens.sixteen),
      child: Column(
        children: [
          // Exercise Title and Progress
          _buildExerciseHeader(),

          Dimens.boxHeight32,

          // Rep Counter
          _buildRepCounter(),

          const Spacer(),

          // Navigation Controls
          _buildNavigationControls(),
        ],
      ),
    );
  }

  Widget _buildExerciseHeader() {
    return Expanded(
      child: Text(
        '${widget.exerciseNumber} ${widget.exerciseName}',
        style: Styles.whiteBold16,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRepCounter() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentReps.toString().padLeft(2, '0'),
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimens.twenty,
              fontWeight: FontWeight.bold,
            ),
          ),
          Dimens.boxHeight4,
          Text(
            'Reps',
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimens.twenty,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Home Button
        GestureDetector(
          onTap: () {
            Get.until((route) => route.isFirst);
          },
          child: Container(
            padding: EdgeInsets.all(Dimens.sixteen),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Dimens.eight),
            ),
            child: const Icon(Icons.home, color: Colors.white, size: 24),
          ),
        ),

        // Pause/Play Button
        GestureDetector(
          onTap: () {
            setState(() {
              isPaused = !isPaused;
            });

            if (!isPaused) {
              // Start rep counting
              _startRepCounting();
            }
          },
          child: Container(
            padding: EdgeInsets.all(Dimens.sixteen),
            decoration: BoxDecoration(
              color: Colors.orange.shade400,
              borderRadius: BorderRadius.circular(Dimens.eight),
            ),
            child: Icon(
              isPaused ? Icons.play_arrow : Icons.pause,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),

        // Next Exercise Button
        GestureDetector(
          onTap: () {
            // Navigate to next exercise or complete session
            Get.snackbar(
              'Next Exercise',
              'Moving to next exercise...',
              backgroundColor: Colors.orange.shade300,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          },
          child: Container(
            padding: EdgeInsets.all(Dimens.sixteen),
            decoration: BoxDecoration(
              color: Colors.orange.shade400,
              borderRadius: BorderRadius.circular(Dimens.eight),
            ),
            child: const Icon(Icons.skip_next, color: Colors.white, size: 24),
          ),
        ),
      ],
    );
  }

  IconData _getExerciseIcon(String exerciseName) {
    if (exerciseName.toLowerCase().contains('neck')) {
      return Icons.accessibility_new;
    } else if (exerciseName.toLowerCase().contains('leg')) {
      return Icons.directions_run;
    } else {
      return Icons.fitness_center;
    }
  }

  void _startRepCounting() {
    // Simulate rep counting
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && !isPaused) {
        setState(() {
          currentReps++;
        });
        if (currentReps < 5) {
          // Assuming 5 reps total
          _startRepCounting();
        } else {
          // Exercise completed, show feedback
          _showFeedback();
        }
      }
    });
  }

  void _showFeedback() {
    // Navigate to feedback screen
    Get.to(
      () => FeedbackView(
        exerciseName: widget.exerciseName,
        exerciseNumber: widget.exerciseNumber,
      ),
    );
  }
}
