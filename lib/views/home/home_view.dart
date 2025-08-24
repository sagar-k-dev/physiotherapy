import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/views/views.dart';
import 'package:physiotherapy/widgets/custom_button.dart';

import '../../utils/navigators/routes_management.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleDrawerMenu() {}

  void _handleAlertButton() {
    Get.snackbar(
      'Alerts',
      'Alerts feature coming soon!',
      backgroundColor: ColorsValue.primaryColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handleSearchButton() {
    Get.snackbar(
      'Search',
      'Search feature coming soon!',
      backgroundColor: ColorsValue.primaryColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handleProfileButton() {
    Get.bottomSheet(const ProfileMenuBottomSheet(), isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: ColorsValue.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: _handleDrawerMenu,
          icon: const Icon(Icons.menu, color: Colors.white, size: 24),
        ),
        title: Text('Physiotherapy', style: Styles.whiteBold20),
        centerTitle: true,
        actions: [
          // Alert Button
          IconButton(
            onPressed: _handleAlertButton,
            icon: Stack(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                // Notification badge
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '3',
                      style: Styles.white12.copyWith(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Search Button
          IconButton(
            onPressed: _handleSearchButton,
            icon: const Icon(Icons.search, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: ColorsValue.primaryColor,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
              labelStyle: Styles.whiteBold16,
              unselectedLabelStyle: Styles.white16,
              tabs: const [
                Tab(text: 'My Patients'),
                Tab(text: 'My Teams'),
              ],
            ),
          ),

          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildMyPatientsTab(), _buildMyTeamsTab()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => RouteManagement.goToAddPatient(),
        backgroundColor: ColorsValue.primaryColor,
        child: const Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(color: ColorsValue.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Dimens.boxHeight16,
                Text('Dr. John Doe', style: Styles.whiteBold16),
                Text(
                  'Physiotherapist',
                  style: Styles.white14.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          // Drawer Items
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.people,
            title: 'My Patients',
            onTap: () {
              Navigator.pop(context);
              _tabController.animateTo(0);
            },
          ),
          _buildDrawerItem(
            icon: Icons.group,
            title: 'My Teams',
            onTap: () {
              Navigator.pop(context);
              _tabController.animateTo(1);
            },
          ),
          _buildDrawerItem(
            icon: Icons.schedule,
            title: 'Appointments',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.assessment,
            title: 'Reports',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Navigator.pop(context);
              RouteManagement.goToSignIn();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: ColorsValue.primaryColor, size: 20),
      title: Text(title, style: Styles.black14w500),
      onTap: onTap,
    );
  }

  Widget _buildMyPatientsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Dimens.sixteen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomButton(
            title: '+ Add Patient',
            onTap: () => RouteManagement.goToAddPatient(),
          ),

          Dimens.boxHeight16,

          // Patients List
          Text('Recent Patients', style: Styles.blackBold16),

          Dimens.boxHeight10,

          // Sample Patients
          _buildPatientCard(
            name: 'Sarah Johnson',
            age: 28,
            condition: 'Lower Back Pain',
            lastVisit: '2 days ago',
            avatar: 'SJ',
          ),

          Dimens.boxHeight16,

          _buildPatientCard(
            name: 'Michael Chen',
            age: 45,
            condition: 'Knee Rehabilitation',
            lastVisit: '1 week ago',
            avatar: 'MC',
          ),

          Dimens.boxHeight16,

          _buildPatientCard(
            name: 'Emma Wilson',
            age: 32,
            condition: 'Shoulder Injury',
            lastVisit: '3 days ago',
            avatar: 'EW',
          ),

          Dimens.boxHeight16,

          _buildPatientCard(
            name: 'David Brown',
            age: 55,
            condition: 'Post-Surgery Recovery',
            lastVisit: '5 days ago',
            avatar: 'DB',
          ),
        ],
      ),
    );
  }

  Widget _buildMyTeamsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Dimens.sixteen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Teams Overview
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Dimens.twenty),
            decoration: BoxDecoration(
              color: ColorsValue.primaryColor,
              borderRadius: BorderRadius.circular(Dimens.ten),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Team Collaboration', style: Styles.whiteBold16),
                Dimens.boxHeight8,
                Text(
                  'You are part of 3 active teams',
                  style: Styles.white14.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          Dimens.boxHeight24,

          // Teams List
          Text('My Teams', style: Styles.blackBold16),

          Dimens.boxHeight16,

          // Sample Teams
          _buildTeamCard(
            name: 'Orthopedic Team',
            members: 8,
            leadBy: 'Dr. Smith',
            description: 'Specialized in bone and joint rehabilitation',
          ),

          Dimens.boxHeight16,

          _buildTeamCard(
            name: 'Sports Medicine',
            members: 6,
            leadBy: 'Dr. Johnson',
            description: 'Athletic injury treatment and recovery',
          ),

          Dimens.boxHeight16,

          _buildTeamCard(
            name: 'Neurological Rehab',
            members: 5,
            leadBy: 'Dr. Williams',
            description: 'Stroke and neurological condition therapy',
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard({
    required String name,
    required int age,
    required String condition,
    required String lastVisit,
    required String avatar,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Dimens.sixteen,
        Dimens.sixteen,
        Dimens.zero,
        Dimens.sixteen,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.ten),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 25,
            backgroundColor: ColorsValue.primaryColor,
            child: Text(avatar, style: Styles.whiteBold14),
          ),

          Dimens.boxWidth16,

          // Patient Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Styles.blackBold14),
                Dimens.boxHeight4,
                Text('$age years • $condition', style: Styles.grey12),
                Dimens.boxHeight4,
                Text('Last visit: $lastVisit', style: Styles.grey12),
              ],
            ),
          ),

          // Action Button
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.grey,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.grey, size: 30),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamCard({
    required String name,
    required int members,
    required String leadBy,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(Dimens.sixteen),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.ten),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Team Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorsValue.primaryColor,
                  borderRadius: BorderRadius.circular(Dimens.ten),
                ),
                child: const Icon(Icons.group, color: Colors.white, size: 20),
              ),

              Dimens.boxWidth16,

              // Team Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Styles.blackBold14),
                    Dimens.boxHeight4,
                    Text(
                      'Led by $leadBy • $members members',
                      style: Styles.grey12,
                    ),
                  ],
                ),
              ),

              // Action Button
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
            ],
          ),

          Dimens.boxHeight16,

          Text(description, style: Styles.grey14),
        ],
      ),
    );
  }
}
