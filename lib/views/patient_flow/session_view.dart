import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/views/patient_flow/exercise_player_view.dart';

class SessionView extends StatefulWidget {
  const SessionView({super.key});

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Exercise List
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorsValue.primaryColor,
                ),
                child: ListView(
                  padding: EdgeInsets.all(Dimens.sixteen),
                  children: [
                    _buildExerciseCard(
                      exerciseNumber: '1/2',
                      exerciseName: 'Neck Warmup',
                      reps: '1X5 Rops',
                      weight: '0 kg',
                      difficulty: 'Medium',
                    ),
                    Dimens.boxHeight16,
                    _buildExerciseCard(
                      exerciseNumber: '2/2',
                      exerciseName: 'Left Straight Leg Raise',
                      reps: '2X5 Rops',
                      weight: '0 kg',
                      difficulty: 'Medium',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.sixteen,
        vertical: Dimens.twelve,
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(Dimens.eight),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Dimens.eight),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          Dimens.boxWidth12,

          // Session Title
          Text('Session I', style: Styles.whiteBold16),

          const Spacer(),

          // Time
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.white, size: 16),
              Dimens.boxWidth4,
              Text('12:15 PM', style: Styles.white14),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard({
    required String exerciseNumber,
    required String exerciseName,
    required String reps,
    required String weight,
    required String difficulty,
  }) {
    return Container(
      padding: EdgeInsets.all(Dimens.twelve),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.twelve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise Title
          Row(
            children: [
              Expanded(
                child: Text(
                  '$exerciseNumber $exerciseName',
                  style: Styles.blackBold16,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to exercise player
                  Get.to(
                    () => ExercisePlayerView(
                      exerciseName: exerciseName,
                      exerciseNumber: exerciseNumber,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: Dimens.eight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.eight),
                  ),
                ),
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: Dimens.forteen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Dimens.boxHeight10,

          // Exercise Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Expanded(
                flex: 2,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(Dimens.eight),
                  ),
                  child: _buildExerciseThumbnail(exerciseName),
                ),
              ),

              Dimens.boxWidth16,

              // Exercise Details
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Reps', reps),
                    Dimens.boxHeight8,
                    _buildDetailRow('Weight', weight),
                    Dimens.boxHeight8,
                    _buildDetailRow('Difficulty', difficulty),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseThumbnail(String exerciseName) {
    // Return different icons based on exercise type
    IconData iconData;
    Color iconColor;

    if (exerciseName.toLowerCase().contains('neck')) {
      iconData = Icons.accessibility_new;
      iconColor = Colors.blue.shade400;
    } else if (exerciseName.toLowerCase().contains('leg')) {
      iconData = Icons.directions_run;
      iconColor = Colors.green.shade400;
    } else {
      iconData = Icons.fitness_center;
      iconColor = Colors.orange.shade400;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 40, color: iconColor),
          Dimens.boxHeight8,
          Text(
            exerciseName,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: Dimens.ten,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Dimens.ten,
            fontWeight: FontWeight.w500,
          ),
        ),
        Dimens.boxHeight2,
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: Dimens.twelve,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
