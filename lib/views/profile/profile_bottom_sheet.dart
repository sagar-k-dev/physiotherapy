import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/utils/navigators/routes_management.dart';

class ProfileMenuBottomSheet extends StatelessWidget {
  const ProfileMenuBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - (kToolbarHeight),
      decoration: const BoxDecoration(
        color: ColorsValue.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Top section with profile icons and close button
          _buildTopSection(),

          // White popup menu section
          _buildMenuSection(),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: Dimens.edgeInsets16,
      child: Column(
        children: [
          // Close button and refresh icon row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close, color: Colors.white, size: 24),
              ),
              IconButton(
                onPressed: () => RouteManagement.goToProfile(),
                icon: const Icon(
                  Icons.edit_square,
                  color: Colors.white54,
                  size: 20,
                ),
              ),
            ],
          ),

          Dimens.boxHeight20,

          // Large profile icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 40),
          ),

          Dimens.boxHeight16,
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Dimens.boxHeight20,

            // My Dashboard
            _buildMenuItem(
              icon: Icons.dashboard,
              title: 'My Dashboard',
              hasArrow: true,
              onTap: () {
                // Handle dashboard navigation
              },
            ),

            // Notifications with toggle
            _buildMenuItemWithToggle(
              icon: Icons.notifications,
              title: 'Notifications',
              isEnabled: true,
              onToggle: (value) {
                // Handle notification toggle
              },
            ),

            // About
            _buildMenuItem(
              icon: Icons.info,
              title: 'About',
              hasArrow: true,
              onTap: () {
                RouteManagement.goToAbout();
              },
            ),

            // Logout
            _buildMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              hasArrow: true,
              onTap: () {
                // Handle logout
              },
            ),

            Dimens.boxHeight20,
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required bool hasArrow,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: ColorsValue.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: ColorsValue.primaryColor, size: 20),
      ),
      title: Text(title, style: Styles.black16w500),
      trailing: hasArrow
          ? const Icon(Icons.chevron_right, color: Colors.grey, size: 20)
          : null,
      onTap: onTap,
    );
  }

  Widget _buildMenuItemWithToggle({
    required IconData icon,
    required String title,
    required bool isEnabled,
    required ValueChanged<bool> onToggle,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: ColorsValue.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: ColorsValue.primaryColor, size: 20),
      ),
      title: Text(title, style: Styles.black16w500),
      trailing: Switch(
        value: isEnabled,
        onChanged: onToggle,
        activeColor: ColorsValue.primaryColor,
        activeTrackColor: ColorsValue.primaryColor.withOpacity(0.3),
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey.withOpacity(0.3),
      ),
    );
  }
}
