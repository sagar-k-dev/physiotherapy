import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String selectedFilter = 'Day'; // Day, Week, Overall
  final List<String> filters = ['Day', 'Week', 'Overall'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Date Selector
            _buildDateSelector(),

            // Filter Bar
            _buildFilterBar(),

            // Main Content
            Expanded(
              child: selectedFilter == 'Week'
                  ? _buildWeekView()
                  : selectedFilter == 'Overall'
                  ? _buildOverallView()
                  : SingleChildScrollView(
                      padding: EdgeInsets.all(Dimens.sixteen),
                      child: Column(
                        children: [
                          // Adherence Metric
                          _buildAdherenceMetric(),

                          Dimens.boxHeight24,

                          // Active Time
                          _buildActiveTime(),

                          Dimens.boxHeight32,

                          // Session Details
                          _buildSessionDetails(),

                          Dimens.boxHeight24,

                          // Exercise Cards
                          _buildExerciseCards(),
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

          // Title
          Text('DashBoard', style: Styles.whiteBold16),

          const Spacer(),

          // Filter Dropdown
          GestureDetector(
            onTap: () {
              _showFilterMenu();
            },
            child: Row(
              children: [
                Text(selectedFilter, style: Styles.white14),
                Dimens.boxWidth4,
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    if (selectedFilter == 'Week') {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.sixteen),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.sixteen,
            vertical: Dimens.twelve,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimens.eight),
          ),
          child: Text(
            '13 Aug - 19 Aug',
            style: Styles.blackBold14,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (selectedFilter == 'Overall') {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.sixteen),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.sixteen,
            vertical: Dimens.twelve,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimens.eight),
          ),
          child: Text(
            '13 Aug - Today',
            style: Styles.blackBold14,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.sixteen),
      child: Row(
        children: [
          // Left Arrow
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_left, color: Colors.white, size: 24),
          ),

          // Date Buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDateButton('Aug 13', false),
                _buildDateButton('Today', true),
                _buildDateButton('Aug 15', false),
              ],
            ),
          ),

          // Right Arrow
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateButton(String date, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.twelve,
        vertical: Dimens.eight,
      ),
      decoration: BoxDecoration(
        color: isSelected ? ColorsValue.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(Dimens.eight),
        border: Border.all(
          color: isSelected ? ColorsValue.primaryColor : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Text(
        date,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: Dimens.twelve,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimens.sixteen,
        vertical: Dimens.twelve,
      ),
      padding: EdgeInsets.all(Dimens.four),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimens.eight),
      ),
      child: Row(
        children: filters.map((filter) {
          final isSelected = filter == selectedFilter;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Dimens.eight),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimens.six),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? ColorsValue.primaryColor : Colors.white,
                    fontSize: Dimens.twelve,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAdherenceMetric() {
    return Center(
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '100%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Dimens.boxHeight8,
            Text(
              'Adherence',
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimens.forteen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.access_time, color: Colors.white, size: 20),
        Dimens.boxWidth8,
        Text('Active Time: ${_getActiveTime()}', style: Styles.white14),
      ],
    );
  }

  Widget _buildSessionDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session 1', style: Styles.whiteBold16),
        Dimens.boxHeight8,
        Row(
          children: [
            const Icon(Icons.access_time, color: Colors.white, size: 16),
            Dimens.boxWidth8,
            Text('11:20 AM - 11:23 AM', style: Styles.white14),
          ],
        ),
      ],
    );
  }

  Widget _buildExerciseCards() {
    return Column(
      children: [
        _buildExerciseCard(
          exerciseNumber: '1/2',
          exerciseName: 'Neck Warmup',
          reps: '1X5 Reps',
          weight: '0 kg',
          duration: '1m:30s',
          difficulty: 'Medium',
          completion: 100,
        ),
        Dimens.boxHeight16,
        _buildExerciseCard(
          exerciseNumber: '2/2',
          exerciseName: 'Left Straight Leg Raise',
          reps: '2X5 Reps',
          weight: '0 kg',
          duration: '1m:30s',
          difficulty: 'Medium',
          completion: 100,
        ),
      ],
    );
  }

  Widget _buildExerciseCard({
    required String exerciseNumber,
    required String exerciseName,
    required String reps,
    required String weight,
    required String duration,
    required String difficulty,
    required int completion,
  }) {
    return Container(
      padding: EdgeInsets.all(Dimens.sixteen),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(Dimens.twelve),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Completion Circle
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    '$completion%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.twelve,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Dimens.boxHeight8,
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 12),
                  Dimens.boxWidth4,
                  Text(
                    duration,
                    style: TextStyle(color: Colors.white, fontSize: Dimens.ten),
                  ),
                ],
              ),
            ],
          ),

          Dimens.boxWidth16,

          // Exercise Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$exerciseNumber $exerciseName',
                  style: Styles.whiteBold14,
                ),
                Dimens.boxHeight4,
                Text(
                  '$reps $weight',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: Dimens.twelve,
                  ),
                ),
                Dimens.boxHeight8,
                Row(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.teal, size: 16),
                    Dimens.boxWidth4,
                    Text(
                      difficulty,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimens.twelve,
                      ),
                    ),
                    Dimens.boxWidth16,
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green,
                              Colors.yellow,
                              Colors.orange,
                              Colors.red,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getActiveTime() {
    switch (selectedFilter) {
      case 'Day':
        return '3m:0s';
      case 'Week':
        return '15m:30s';
      case 'Overall':
        return '2h:15m';
      default:
        return '3m:0s';
    }
  }

  Widget _buildOverallView() {
    return Column(
      children: [
        // Session Progress
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.sixteen),
          child: Text(
            '0 out of 0 session done',
            style: Styles.white14,
            textAlign: TextAlign.center,
          ),
        ),

        Dimens.boxHeight24,

        // Overall Adherence Metric
        _buildOverallAdherenceMetric(),
        Dimens.boxHeight16,

        // White Background Section
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.twenty),
                topRight: Radius.circular(Dimens.twenty),
              ),
            ),
            child: Column(
              children: [
                // Goal Reached Header
                _buildGoalReachedHeader(),

                // Line Chart
                Expanded(child: _buildLineChart()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverallAdherenceMetric() {
    return Center(
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: Stack(
          children: [
            // Progress Arc
            CustomPaint(
              size: Size(200, 200),
              painter: OverallProgressPainter(progress: 0.21), // 21%
            ),
            // Center Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '21%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Dimens.boxHeight8,
                  Text(
                    'Adherence',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.forteen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    final List<LineChartData> chartData = [
      LineChartData('1', 0),
      LineChartData('2', 100),
    ];

    return Container(
      padding: EdgeInsets.all(Dimens.sixteen),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Dimens.ten,
          ),
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 100,
          interval: 20,
          majorGridLines: MajorGridLines(width: 1, color: Colors.grey.shade200),
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Dimens.ten,
          ),
        ),
        series: <CartesianSeries>[
          AreaSeries<LineChartData, String>(
            dataSource: chartData,
            xValueMapper: (LineChartData data, _) => data.day,
            yValueMapper: (LineChartData data, _) => data.percentage,
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade300.withValues(alpha: 0.3),
                Colors.grey.shade300.withValues(alpha: 0.1),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderColor: Colors.grey.shade400,
            borderWidth: 2,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Day point.x : point.y%',
        ),
      ),
    );
  }

  void _showFilterMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.twenty),
            topRight: Radius.circular(Dimens.twenty),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: Dimens.twelve),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ...filters
                .map(
                  (filter) => ListTile(
                    title: Text(filter),
                    trailing: selectedFilter == filter
                        ? Icon(Icons.check, color: ColorsValue.primaryColor)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
            Dimens.boxHeight16,
          ],
        ),
      ),
    );
  }

  Widget _buildWeekView() {
    return Column(
      children: [
        // Session Progress
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.sixteen),
          child: Text(
            '1 out of 4 sessions done',
            style: Styles.white14,
            textAlign: TextAlign.center,
          ),
        ),

        Dimens.boxHeight24,

        // Week Adherence Metric
        _buildWeekAdherenceMetric(),
        Dimens.boxHeight16,

        // White Background Section
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.twenty),
                topRight: Radius.circular(Dimens.twenty),
              ),
            ),
            child: Column(
              children: [
                // Goal Reached Header
                _buildGoalReachedHeader(),

                // Bar Chart
                Expanded(child: _buildBarChart()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekAdherenceMetric() {
    return Center(
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: Stack(
          children: [
            // Progress Arc
            CustomPaint(
              size: Size(180, 180),
              painter: WeekProgressPainter(progress: 0.15), // 15%
            ),
            // Center Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '15%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Dimens.boxHeight8,
                  Text(
                    'Adherence',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.forteen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalReachedHeader() {
    return Container(
      padding: EdgeInsets.all(Dimens.sixteen),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Goal Reached', style: Styles.blackBold14),
          Dimens.boxWidth8,
          const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 20),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    final List<ChartData> chartData = [
      ChartData('13', 100, false),
      ChartData('14', 100, true),
      ChartData('15', 100, false),
      ChartData('16', 0, false),
      ChartData('17', 0, false),
      ChartData('18', 0, false),
      ChartData('19', 0, false),
    ];

    return Container(
      padding: EdgeInsets.all(Dimens.sixteen),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Dimens.ten,
          ),
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 100,
          interval: 20,
          majorGridLines: MajorGridLines(width: 1, color: Colors.grey.shade200),
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Dimens.ten,
          ),
        ),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.date,
            yValueMapper: (ChartData data, _) => data.percentage,
            pointColorMapper: (ChartData data, _) => data.isSelected
                ? ColorsValue.primaryColor
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(2),
            width: 0.6,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y%',
        ),
      ),
    );
  }
}

// Chart data model
class ChartData {
  final String date;
  final double percentage;
  final bool isSelected;

  ChartData(this.date, this.percentage, this.isSelected);
}

// Custom painter for week progress arc
class WeekProgressPainter extends CustomPainter {
  final double progress;

  WeekProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 8) / 2;

    // Draw progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -90 * (3.14159 / 180), // Start from top
      progress * 2 * 3.14159, // Convert percentage to radians
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Line chart data model
class LineChartData {
  final String day;
  final double percentage;

  LineChartData(this.day, this.percentage);
}

// Custom painter for overall progress arc
class OverallProgressPainter extends CustomPainter {
  final double progress;

  OverallProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 8) / 2;

    // Draw progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -90 * (3.14159 / 180), // Start from top
      progress * 2 * 3.14159, // Convert percentage to radians
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
