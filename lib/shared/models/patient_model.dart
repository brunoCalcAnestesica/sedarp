enum Gender {
  male,
  female,
  other,
}

enum PatientStatus {
  all,
  active,
  inactive,
  pending,
}

enum ASAClassification {
  asa1,
  asa2,
  asa3,
  asa4,
  asa5,
  asa6,
}

enum RiskLevel {
  low,
  medium,
  high,
  critical,
}

enum EvaluationStatus {
  completed,
  pending,
  inProgress,
  expired,
}

class PatientModel {
  final String id;
  final String name;
  final String cpf;
  final String rg;
  final DateTime birthDate;
  final Gender gender;
  final String phone;
  final String email;
  final String address;
  final String city;
  final String state;
  final String emergencyContact;
  final String emergencyPhone;
  final String emergencyRelationship;
  final PatientStatus status;
  final ASAClassification asaClassification;
  final RiskLevel riskLevel;
  final EvaluationStatus evaluationStatus;
  final DateTime? evaluationDate;
  final DateTime nextEvaluationDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  // Dados da avaliação pré-anestésica
  final String? weight;
  final String? height;
  final String? bmi;
  final String? bloodType;
  final String? allergies;
  final String? currentMedications;
  final String? medicalHistory;
  final String? surgicalHistory;
  final String? familyHistory;
  final String? socialHistory;
  final String? physicalExam;
  final String? labResults;
  final String? ecgResults;
  final String? chestXrayResults;
  final String? additionalExams;
  final String? anesthesiologistNotes;
  final String? recommendations;
  final bool? fastingStatus;
  final DateTime? lastMealTime;
  final String? specialInstructions;

  PatientModel({
    required this.id,
    required this.name,
    required this.cpf,
    required this.rg,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.emergencyContact,
    required this.emergencyPhone,
    required this.emergencyRelationship,
    required this.status,
    required this.asaClassification,
    required this.riskLevel,
    required this.evaluationStatus,
    this.evaluationDate,
    required this.nextEvaluationDate,
    required this.createdAt,
    this.updatedAt,
    this.weight,
    this.height,
    this.bmi,
    this.bloodType,
    this.allergies,
    this.currentMedications,
    this.medicalHistory,
    this.surgicalHistory,
    this.familyHistory,
    this.socialHistory,
    this.physicalExam,
    this.labResults,
    this.ecgResults,
    this.chestXrayResults,
    this.additionalExams,
    this.anesthesiologistNotes,
    this.recommendations,
    this.fastingStatus,
    this.lastMealTime,
    this.specialInstructions,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      cpf: json['cpf'] as String,
      rg: json['rg'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      gender: Gender.values.firstWhere(
        (e) => e.toString() == 'Gender.${json['gender']}',
      ),
      phone: json['phone'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      emergencyContact: json['emergencyContact'] as String,
      emergencyPhone: json['emergencyPhone'] as String,
      emergencyRelationship: json['emergencyRelationship'] as String,
      status: PatientStatus.values.firstWhere(
        (e) => e.toString() == 'PatientStatus.${json['status']}',
      ),
      asaClassification: ASAClassification.values.firstWhere(
        (e) => e.toString() == 'ASAClassification.${json['asaClassification']}',
      ),
      riskLevel: RiskLevel.values.firstWhere(
        (e) => e.toString() == 'RiskLevel.${json['riskLevel']}',
      ),
      evaluationStatus: EvaluationStatus.values.firstWhere(
        (e) => e.toString() == 'EvaluationStatus.${json['evaluationStatus']}',
      ),
      evaluationDate: json['evaluationDate'] != null 
          ? DateTime.parse(json['evaluationDate'] as String) 
          : null,
      nextEvaluationDate: DateTime.parse(json['nextEvaluationDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
      weight: json['weight'] as String?,
      height: json['height'] as String?,
      bmi: json['bmi'] as String?,
      bloodType: json['bloodType'] as String?,
      allergies: json['allergies'] as String?,
      currentMedications: json['currentMedications'] as String?,
      medicalHistory: json['medicalHistory'] as String?,
      surgicalHistory: json['surgicalHistory'] as String?,
      familyHistory: json['familyHistory'] as String?,
      socialHistory: json['socialHistory'] as String?,
      physicalExam: json['physicalExam'] as String?,
      labResults: json['labResults'] as String?,
      ecgResults: json['ecgResults'] as String?,
      chestXrayResults: json['chestXrayResults'] as String?,
      additionalExams: json['additionalExams'] as String?,
      anesthesiologistNotes: json['anesthesiologistNotes'] as String?,
      recommendations: json['recommendations'] as String?,
      fastingStatus: json['fastingStatus'] as bool?,
      lastMealTime: json['lastMealTime'] != null 
          ? DateTime.parse(json['lastMealTime'] as String) 
          : null,
      specialInstructions: json['specialInstructions'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'rg': rg,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender.toString().split('.').last,
      'phone': phone,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
      'emergencyContact': emergencyContact,
      'emergencyPhone': emergencyPhone,
      'emergencyRelationship': emergencyRelationship,
      'status': status.toString().split('.').last,
      'asaClassification': asaClassification.toString().split('.').last,
      'riskLevel': riskLevel.toString().split('.').last,
      'evaluationStatus': evaluationStatus.toString().split('.').last,
      'evaluationDate': evaluationDate?.toIso8601String(),
      'nextEvaluationDate': nextEvaluationDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'bloodType': bloodType,
      'allergies': allergies,
      'currentMedications': currentMedications,
      'medicalHistory': medicalHistory,
      'surgicalHistory': surgicalHistory,
      'familyHistory': familyHistory,
      'socialHistory': socialHistory,
      'physicalExam': physicalExam,
      'labResults': labResults,
      'ecgResults': ecgResults,
      'chestXrayResults': chestXrayResults,
      'additionalExams': additionalExams,
      'anesthesiologistNotes': anesthesiologistNotes,
      'recommendations': recommendations,
      'fastingStatus': fastingStatus,
      'lastMealTime': lastMealTime?.toIso8601String(),
      'specialInstructions': specialInstructions,
    };
  }

  PatientModel copyWith({
    String? id,
    String? name,
    String? cpf,
    String? rg,
    DateTime? birthDate,
    Gender? gender,
    String? phone,
    String? email,
    String? address,
    String? city,
    String? state,
    String? emergencyContact,
    String? emergencyPhone,
    String? emergencyRelationship,
    PatientStatus? status,
    ASAClassification? asaClassification,
    RiskLevel? riskLevel,
    EvaluationStatus? evaluationStatus,
    DateTime? evaluationDate,
    DateTime? nextEvaluationDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? weight,
    String? height,
    String? bmi,
    String? bloodType,
    String? allergies,
    String? currentMedications,
    String? medicalHistory,
    String? surgicalHistory,
    String? familyHistory,
    String? socialHistory,
    String? physicalExam,
    String? labResults,
    String? ecgResults,
    String? chestXrayResults,
    String? additionalExams,
    String? anesthesiologistNotes,
    String? recommendations,
    bool? fastingStatus,
    DateTime? lastMealTime,
    String? specialInstructions,
  }) {
    return PatientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      rg: rg ?? this.rg,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
      emergencyRelationship: emergencyRelationship ?? this.emergencyRelationship,
      status: status ?? this.status,
      asaClassification: asaClassification ?? this.asaClassification,
      riskLevel: riskLevel ?? this.riskLevel,
      evaluationStatus: evaluationStatus ?? this.evaluationStatus,
      evaluationDate: evaluationDate ?? this.evaluationDate,
      nextEvaluationDate: nextEvaluationDate ?? this.nextEvaluationDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      currentMedications: currentMedications ?? this.currentMedications,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      surgicalHistory: surgicalHistory ?? this.surgicalHistory,
      familyHistory: familyHistory ?? this.familyHistory,
      socialHistory: socialHistory ?? this.socialHistory,
      physicalExam: physicalExam ?? this.physicalExam,
      labResults: labResults ?? this.labResults,
      ecgResults: ecgResults ?? this.ecgResults,
      chestXrayResults: chestXrayResults ?? this.chestXrayResults,
      additionalExams: additionalExams ?? this.additionalExams,
      anesthesiologistNotes: anesthesiologistNotes ?? this.anesthesiologistNotes,
      recommendations: recommendations ?? this.recommendations,
      fastingStatus: fastingStatus ?? this.fastingStatus,
      lastMealTime: lastMealTime ?? this.lastMealTime,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  String toString() {
    return 'PatientModel(id: $id, name: $name, cpf: $cpf, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PatientModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 