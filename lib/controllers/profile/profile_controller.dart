import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Observable variables
  final RxString fullName = 'Dr. Sarah Johnson'.obs;
  final RxString title = 'Senior Physiotherapist'.obs;
  final RxString profileImage = 'assets/images/app_logo.svg'.obs;
  final RxDouble rating = 4.8.obs;
  final RxInt reviewCount = 127.obs;

  // Personal Information
  final RxString dateOfBirth = 'March 15, 1985'.obs;
  final RxString gender = 'Female'.obs;
  final RxString nationality = 'Canadian'.obs;
  final RxString languages = 'English, French, Spanish'.obs;

  // Professional Information
  final RxString licenseNumber = 'PT-12345'.obs;
  final RxString specialization = 'Sports Rehabilitation'.obs;
  final RxString experience = '12+ years'.obs;
  final RxString education = 'MSc Physiotherapy, University of Toronto'.obs;
  final RxString certifications = 'Sports Physiotherapy, Manual Therapy'.obs;
  final RxString memberships = 'Canadian Physiotherapy Association'.obs;

  // Contact Information
  final RxString email = 'sarah.johnson@physio.com'.obs;
  final RxString phone = '+1 (416) 555-0123'.obs;
  final RxString address = '123 Health Street, Toronto, ON M5V 2H1'.obs;
  final RxString clinicHours = 'Mon-Fri: 8:00 AM - 6:00 PM'.obs;
  final RxString emergencyContact = '+1 (416) 555-9999'.obs;

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  /// Load profile data from repository or local storage
  Future<void> loadProfileData() async {
    try {
      isLoading.value = true;
      // TODO: Implement actual data loading from repository
      // For now, using mock data
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load profile data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Update profile information
  Future<void> updateProfile({
    String? newFullName,
    String? newTitle,
    String? newEmail,
    String? newPhone,
    String? newAddress,
  }) async {
    try {
      isLoading.value = true;

      // Update observable values
      if (newFullName != null) fullName.value = newFullName;
      if (newTitle != null) title.value = newTitle;
      if (newEmail != null) email.value = newEmail;
      if (newPhone != null) phone.value = newPhone;
      if (newAddress != null) address.value = newAddress;

      // TODO: Implement actual API call to update profile
      await Future.delayed(const Duration(milliseconds: 1000));

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Share profile functionality
  void shareProfile() {
    // TODO: Implement share functionality
    Get.snackbar(
      'Share Profile',
      'Share functionality will be implemented',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
