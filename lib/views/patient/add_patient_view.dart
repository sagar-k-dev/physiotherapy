import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy/res/res.dart';
import 'package:physiotherapy/widgets/custom_button.dart';

class AddPatientView extends StatefulWidget {
  const AddPatientView({super.key});

  @override
  State<AddPatientView> createState() => _AddPatientViewState();
}

class _AddPatientViewState extends State<AddPatientView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referredByController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;
  String? _selectedCondition;
  String? _selectedLocation;
  String? _selectedDuration;
  String? _selectedDurationUnit;
  String? _selectedRestTimer;
  String? _selectedPrepTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    _referredByController.dispose();
    super.dispose();
  }

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
        title: Text('Add Patient', style: Styles.whiteBold20),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Profile Picture Section
          _buildProfileSection(),

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
                Tab(text: 'Personal Details'),
                Tab(text: 'Treatment Details'),
              ],
            ),
          ),

          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPersonalDetailsTab(),
                _buildTreatmentDetailsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: Dimens.edgeInsets16,
      child: Column(
        children: [
          // Profile Picture
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.grey, size: 50),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: ColorsValue.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),

          Dimens.boxHeight8,

          Text(
            'Add Profile Picture',
            style: Styles.white16.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsTab() {
    return Container(
      margin: const EdgeInsets.all(16),
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
      child: Padding(
        padding: Dimens.edgeInsets16,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Name Field
              _buildTextField(
                controller: _nameController,
                label: 'Name',
                hint: 'Enter patient name',
                icon: Icons.person,
              ),

              Dimens.boxHeight16,

              // Number Field
              _buildTextField(
                controller: _numberController,
                label: 'Phone Number',
                hint: 'Enter phone number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),

              Dimens.boxHeight16,

              // Email Field
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Enter email address',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),

              Dimens.boxHeight16,

              // Gender Field
              _buildDropdownField(
                label: 'Gender',
                value: _selectedGender,
                items: const ['Male', 'Female', 'Other'],
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                icon: Icons.person_outline,
              ),

              Dimens.boxHeight16,

              // Date of Birth Field
              _buildDateField(),

              Dimens.boxHeight16,

              // Referred By Field
              _buildTextField(
                controller: _referredByController,
                label: 'Referred By',
                hint: 'Enter referring doctor/physician',
                icon: Icons.medical_services,
              ),
              Dimens.boxHeight16,

              CustomButton(title: 'Next', onTap: _savePersonalDetails),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTreatmentDetailsTab() {
    return Container(
      margin: const EdgeInsets.all(16),
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
      child: Padding(
        padding: Dimens.edgeInsets16,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Condition Field
              _buildDropdownField(
                label: 'Condition',
                value: _selectedCondition,
                items: const [
                  'Stroke',
                  'Fracture',
                  'Sprain',
                  'Arthritis',
                  'Back Pain',
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCondition = value;
                  });
                },
                icon: Icons.medical_information,
              ),

              Dimens.boxHeight16,

              // Location Field
              _buildTextField(
                controller: TextEditingController(
                  text: _selectedLocation ?? '',
                ),
                label: 'Location',
                hint: 'Enter location',
                icon: Icons.location_on,
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
              ),

              Dimens.boxHeight16,

              // Start Date Field
              _buildDateField(label: 'Start Date'),

              Dimens.boxHeight16,

              // Duration Field
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      label: 'Duration',
                      value: _selectedDuration,
                      items: List.generate(
                        30,
                        (index) => (index + 1).toString(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedDuration = value;
                        });
                      },
                      icon: Icons.schedule,
                    ),
                  ),
                  Dimens.boxWidth16,
                  Expanded(
                    child: _buildDropdownField(
                      label: 'Unit',
                      value: _selectedDurationUnit,
                      items: const ['days', 'weeks', 'months'],
                      onChanged: (value) {
                        setState(() {
                          _selectedDurationUnit = value;
                        });
                      },
                      icon: null,
                    ),
                  ),
                ],
              ),

              Dimens.boxHeight16,

              // Rest Timer Field
              _buildDropdownField(
                label: 'Rest Timer',
                value: _selectedRestTimer,
                items: List.generate(60, (index) => '${index + 1} s'),
                onChanged: (value) {
                  setState(() {
                    _selectedRestTimer = value;
                  });
                },
                icon: Icons.timer,
              ),

              Dimens.boxHeight16,

              // Preparation Timer Field
              _buildDropdownField(
                label: 'Preparation Timer',
                value: _selectedPrepTimer,
                items: List.generate(60, (index) => '${index + 1} s'),
                onChanged: (value) {
                  setState(() {
                    _selectedPrepTimer = value;
                  });
                },
                icon: Icons.timer_outlined,
              ),

              Dimens.boxHeight16,

              CustomButton(
                title: 'Save & Start',
                onTap: _saveAndStartTreatment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Styles.black16w500),
        Dimens.boxHeight8,
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: ColorsValue.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorsValue.primaryColor),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(label, style: Styles.black16w500),
          Dimens.boxHeight8,
        ],
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: icon != null
                ? Icon(icon, color: ColorsValue.primaryColor)
                : null,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorsValue.primaryColor),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({String label = 'Date of Birth'}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Styles.black16w500),
        Dimens.boxHeight8,
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              setState(() {
                _selectedDate = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[50],
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: ColorsValue.primaryColor),
                Dimens.boxWidth16,
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                      : 'Select date',
                  style: _selectedDate != null ? Styles.black16 : Styles.grey14,
                ),
                const Spacer(),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _savePersonalDetails() {
    _tabController.animateTo(1);
  }

  void _saveAndStartTreatment() {
    Get.snackbar('Success', 'Treatment started successfully');
  }
}
