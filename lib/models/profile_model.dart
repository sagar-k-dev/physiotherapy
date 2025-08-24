class ProfileModel {
  final String fullName;
  final String title;
  final String profileImage;
  final double rating;
  final int reviewCount;
  final PersonalInfo personalInfo;
  final ProfessionalInfo professionalInfo;
  final ContactInfo contactInfo;

  ProfileModel({
    required this.fullName,
    required this.title,
    required this.profileImage,
    required this.rating,
    required this.reviewCount,
    required this.personalInfo,
    required this.professionalInfo,
    required this.contactInfo,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] ?? '',
      title: json['title'] ?? '',
      profileImage: json['profileImage'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      personalInfo: PersonalInfo.fromJson(json['personalInfo'] ?? {}),
      professionalInfo: ProfessionalInfo.fromJson(
        json['professionalInfo'] ?? {},
      ),
      contactInfo: ContactInfo.fromJson(json['contactInfo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'title': title,
      'profileImage': profileImage,
      'rating': rating,
      'reviewCount': reviewCount,
      'personalInfo': personalInfo.toJson(),
      'professionalInfo': professionalInfo.toJson(),
      'contactInfo': contactInfo.toJson(),
    };
  }

  ProfileModel copyWith({
    String? fullName,
    String? title,
    String? profileImage,
    double? rating,
    int? reviewCount,
    PersonalInfo? personalInfo,
    ProfessionalInfo? professionalInfo,
    ContactInfo? contactInfo,
  }) {
    return ProfileModel(
      fullName: fullName ?? this.fullName,
      title: title ?? this.title,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      personalInfo: personalInfo ?? this.personalInfo,
      professionalInfo: professionalInfo ?? this.professionalInfo,
      contactInfo: contactInfo ?? this.contactInfo,
    );
  }
}

class PersonalInfo {
  final String dateOfBirth;
  final String gender;
  final String nationality;
  final String languages;

  PersonalInfo({
    required this.dateOfBirth,
    required this.gender,
    required this.nationality,
    required this.languages,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      nationality: json['nationality'] ?? '',
      languages: json['languages'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'nationality': nationality,
      'languages': languages,
    };
  }

  PersonalInfo copyWith({
    String? dateOfBirth,
    String? gender,
    String? nationality,
    String? languages,
  }) {
    return PersonalInfo(
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      languages: languages ?? this.languages,
    );
  }
}

class ProfessionalInfo {
  final String licenseNumber;
  final String specialization;
  final String experience;
  final String education;
  final String certifications;
  final String memberships;

  ProfessionalInfo({
    required this.licenseNumber,
    required this.specialization,
    required this.experience,
    required this.education,
    required this.certifications,
    required this.memberships,
  });

  factory ProfessionalInfo.fromJson(Map<String, dynamic> json) {
    return ProfessionalInfo(
      licenseNumber: json['licenseNumber'] ?? '',
      specialization: json['specialization'] ?? '',
      experience: json['experience'] ?? '',
      education: json['education'] ?? '',
      certifications: json['certifications'] ?? '',
      memberships: json['memberships'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'licenseNumber': licenseNumber,
      'specialization': specialization,
      'experience': experience,
      'education': education,
      'certifications': certifications,
      'memberships': memberships,
    };
  }

  ProfessionalInfo copyWith({
    String? licenseNumber,
    String? specialization,
    String? experience,
    String? education,
    String? certifications,
    String? memberships,
  }) {
    return ProfessionalInfo(
      licenseNumber: licenseNumber ?? this.licenseNumber,
      specialization: specialization ?? this.specialization,
      experience: experience ?? this.experience,
      education: education ?? this.education,
      certifications: certifications ?? this.certifications,
      memberships: memberships ?? this.memberships,
    );
  }
}

class ContactInfo {
  final String email;
  final String phone;
  final String address;
  final String clinicHours;
  final String emergencyContact;

  ContactInfo({
    required this.email,
    required this.phone,
    required this.address,
    required this.clinicHours,
    required this.emergencyContact,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      clinicHours: json['clinicHours'] ?? '',
      emergencyContact: json['emergencyContact'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'address': address,
      'clinicHours': clinicHours,
      'emergencyContact': emergencyContact,
    };
  }

  ContactInfo copyWith({
    String? email,
    String? phone,
    String? address,
    String? clinicHours,
    String? emergencyContact,
  }) {
    return ContactInfo(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      clinicHours: clinicHours ?? this.clinicHours,
      emergencyContact: emergencyContact ?? this.emergencyContact,
    );
  }
}
