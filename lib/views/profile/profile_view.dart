import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/controllers/profile/profile_controller.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/widgets/widgets.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppbar(
        title: 'Profile',
        titleStyle: Styles.whiteBold20,
        centerTitle: true,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: ColorsValue.primaryColor,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: Dimens.edgeInsets16,
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    Dimens.boxHeight24,
                    _buildPersonalInfoSection(),
                    Dimens.boxHeight20,
                    _buildProfessionalInfoSection(),
                    Dimens.boxHeight20,
                    _buildContactInfoSection(),
                    Dimens.boxHeight20,
                    _buildActionButtons(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: Dimens.edgeInsets16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.twelve),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Image
          Container(
            width: Dimens.oneHundredTwenty,
            height: Dimens.oneHundredTwenty,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorsValue.primaryColor.withOpacity(0.2),
                width: Dimens.three,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/app_logo.svg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorsValue.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: Dimens.fifty,
                      color: ColorsValue.primaryColor,
                    ),
                  );
                },
              ),
            ),
          ),
          Dimens.boxHeight16,
          // Name and Title
          Obx(
            () => Text(
              controller.fullName.value,
              style: Styles.blackBold20,
              textAlign: TextAlign.center,
            ),
          ),
          Dimens.boxHeight4,
          Obx(
            () => Text(
              controller.title.value,
              style: Styles.primary14w500,
              textAlign: TextAlign.center,
            ),
          ),
          Dimens.boxHeight8,
          // Rating
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber, size: Dimens.sixteen),
                Dimens.boxWidth4,
                Text(
                  controller.rating.value.toString(),
                  style: Styles.blackBold14,
                ),
                Dimens.boxWidth4,
                Text(
                  '(${controller.reviewCount.value} reviews)',
                  style: Styles.grey12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return _buildInfoCard(
      title: 'Personal Information',
      icon: Icons.person_outline,
      children: [
        Obx(() => _buildInfoRow('Full Name', controller.fullName.value)),
        Obx(() => _buildInfoRow('Date of Birth', controller.dateOfBirth.value)),
        Obx(() => _buildInfoRow('Gender', controller.gender.value)),
        Obx(() => _buildInfoRow('Nationality', controller.nationality.value)),
        Obx(() => _buildInfoRow('Languages', controller.languages.value)),
      ],
    );
  }

  Widget _buildProfessionalInfoSection() {
    return _buildInfoCard(
      title: 'Professional Information',
      icon: Icons.medical_services_outlined,
      children: [
        Obx(
          () => _buildInfoRow('License Number', controller.licenseNumber.value),
        ),
        Obx(
          () =>
              _buildInfoRow('Specialization', controller.specialization.value),
        ),
        Obx(() => _buildInfoRow('Experience', controller.experience.value)),
        Obx(() => _buildInfoRow('Education', controller.education.value)),
        Obx(
          () =>
              _buildInfoRow('Certifications', controller.certifications.value),
        ),
        Obx(() => _buildInfoRow('Memberships', controller.memberships.value)),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return _buildInfoCard(
      title: 'Contact Information',
      icon: Icons.contact_phone_outlined,
      children: [
        Obx(() => _buildInfoRow('Email', controller.email.value)),
        Obx(() => _buildInfoRow('Phone', controller.phone.value)),
        Obx(() => _buildInfoRow('Address', controller.address.value)),
        Obx(() => _buildInfoRow('Clinic Hours', controller.clinicHours.value)),
        Obx(
          () => _buildInfoRow(
            'Emergency Contact',
            controller.emergencyContact.value,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: Dimens.edgeInsets16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.twelve),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: ColorsValue.primaryColor, size: Dimens.twenty),
              Dimens.boxWidth8,
              Text(title, style: Styles.blackBold16),
            ],
          ),
          Dimens.boxHeight16,
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: Dimens.edgeInsets0_8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimens.hundred,
            child: Text(label, style: Styles.grey14w500),
          ),
          Dimens.boxWidth8,
          Expanded(child: Text(value, style: Styles.black14)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.white),
            label: Text('Edit Profile', style: Styles.white14w500),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsValue.primaryColor,
              padding: Dimens.edgeInsets12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.eight),
              ),
            ),
          ),
        ),
        Dimens.boxHeight10,
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => controller.shareProfile(),
            icon: Icon(
              Icons.share,
              color: ColorsValue.primaryColor,
              size: Dimens.sixteen,
            ),
            label: Text('Share Profile', style: Styles.primary14w500),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: ColorsValue.primaryColor),
              padding: Dimens.edgeInsets12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.eight),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
