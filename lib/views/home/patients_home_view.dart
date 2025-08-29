import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/views/views.dart';
import 'package:physiotherapy/views/patient_flow/award_popup_view.dart';
import 'package:physiotherapy/views/patient_flow/dashboard_view.dart';
import 'package:table_calendar/table_calendar.dart';

class PatientHomeView extends StatefulWidget {
  const PatientHomeView({super.key});

  @override
  State<PatientHomeView> createState() => _PatientHomeViewState();
}

class _PatientHomeViewState extends State<PatientHomeView> {
  DateTime _focusedDay = DateTime(2025, 8, 15); // August 15, 2025
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay; // Initialize selected day to August 15
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      body: SafeArea(
        child: Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(),

            // Patient Information Section
            _buildPatientInfo(),

            // Main Content Card
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // Date Selector
                    _buildDateSelector(),

                    // Session Details
                    _buildSessionDetails(),
                    const Spacer(),

                    // Progress Section
                    _buildProgressSection(),

                    // Bottom Navigation
                    _buildBottomNavigation(),
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
          // Profile Picture
          GestureDetector(
            onTap: () {
              Get.to(() => const DashboardView());
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              child: const Icon(Icons.person, color: Colors.white, size: 24),
            ),
          ),

          Dimens.boxWidth12,

          // App Title
          Text('Pheezee Home', style: Styles.whiteBold16),

          const Spacer(),

          // Action Icons
          Row(
            children: [
              // Document/Checklist Icon
              Container(
                padding: EdgeInsets.all(Dimens.eight),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Dimens.eight),
                ),
                child: const Icon(
                  Icons.checklist,
                  color: Colors.white,
                  size: 20,
                ),
              ),

              Dimens.boxWidth12,

              // Notification Icon with Badge
              GestureDetector(
                onTap: () {
                  Get.to(() => const AwardPopupView());
                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimens.eight),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(Dimens.eight),
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    // Notification Badge
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.sixteen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Greetings!', style: Styles.white14),
          Dimens.boxHeight4,
          Text('Patientname', style: Styles.whiteBold20),
          Dimens.boxHeight4,
          Text(
            'Start Date : 13 Aug 2025',
            style: Styles.white12.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          Dimens.boxHeight20,
          Text('You have 1 new session today!', style: Styles.white14),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.sixteen,
        vertical: Dimens.twenty,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table Calendar
          TableCalendar(
            firstDay: DateTime.utc(2024, 8, 1),
            lastDay: DateTime.utc(2025, 8, 31),
            focusedDay: _focusedDay,
            currentDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },

            // Calendar styling
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: ColorsValue.primaryColor,
                shape: BoxShape.circle,
              ),
              isTodayHighlighted: true,

              defaultDecoration: BoxDecoration(shape: BoxShape.circle),
              weekendTextStyle: TextStyle(color: Colors.red.shade400),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayTextStyle: TextStyle(color: Colors.white),
            ),

            // Header styling
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: Styles.blackBold14,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: ColorsValue.primaryColor,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: ColorsValue.primaryColor,
              ),
            ),

            // Days of week styling
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              weekendStyle: TextStyle(
                color: Colors.red.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.sixteen),
      padding: EdgeInsets.all(Dimens.twelve),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(Dimens.twelve),
        border: Border.all(color: ColorsValue.primaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time Icon and Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.grey.shade600,
                    size: 25,
                  ),
                  Dimens.boxWidth8,
                  Text(
                    '9:30 AM',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: Dimens.forteen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text('Session 1', style: Styles.blackBold14),
            ],
          ),

          // Start Button
          GestureDetector(
            onTap: () {
              Get.to(() => const SessionView());
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.sixteen,
                vertical: Dimens.eight,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimens.eight),
                border: Border.all(color: Colors.orange.shade300),
              ),
              child: Text(
                'Start',
                style: TextStyle(
                  color: Colors.orange.shade700,
                  fontSize: Dimens.twelve,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimens.sixteen,
        vertical: Dimens.twenty,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '3 days left',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: Dimens.forteen,
                ),
              ),
              Text(
                '25%',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: Dimens.forteen,
                ),
              ),
            ],
          ),

          Dimens.boxHeight10,

          // Progress Bar
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.25, // 25%
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.sixteen,
        vertical: Dimens.twenty,
      ),
      decoration: BoxDecoration(
        color: ColorsValue.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', true),
          _buildNavItem(Icons.calendar_today, 'Schedule', false),
          _buildNavItem(Icons.assessment, 'Progress', false),
          _buildNavItem(Icons.person, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected
              ? Colors.white
              : Colors.white.withValues(alpha: 0.6),
          size: 24,
        ),
        Dimens.boxHeight4,
        Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.6),
            fontSize: Dimens.ten,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
