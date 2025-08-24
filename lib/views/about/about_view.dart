import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorsValue.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
        ),
        title: Text('About', style: Styles.whiteBold20),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // App Info Section
            _buildAppInfoSection(),

            // Menu Items Section
            Expanded(child: _buildMenuSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppInfoSection() {
    return Container(
      padding: Dimens.edgeInsets16,
      child: Column(
        children: [
          // App Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.cyan.withOpacity(0.3), width: 2),
            ),
            child: const Icon(
              Icons.medical_services,
              color: Colors.cyan,
              size: 40,
            ),
          ),

          Dimens.boxHeight20,

          // App Name and Version
          Text(
            'Pheezee Admin',
            style: Styles.whiteBold20,
            textAlign: TextAlign.center,
          ),

          Dimens.boxHeight8,

          Text(
            'version 2.1.0',
            style: Styles.white16.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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

          // FAQ
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'FAQ',
            onTap: () {
              // Handle FAQ navigation
            },
          ),

          // Terms of Use
          _buildMenuItem(
            icon: Icons.description_outlined,
            title: 'Terms of Use',
            onTap: () {
              // Handle Terms of Use navigation
            },
          ),

          // Help
          _buildMenuItem(
            icon: Icons.support_agent,
            title: 'Help',
            onTap: () {
              // Handle Help navigation
            },
          ),

          // Contact Us
          _buildMenuItem(
            icon: Icons.contact_support_outlined,
            title: 'Contact Us',
            onTap: () {
              // Handle Contact Us navigation
            },
          ),

          Dimens.boxHeight20,
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
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
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      onTap: onTap,
    );
  }
}
