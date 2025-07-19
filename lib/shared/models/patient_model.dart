enum AsaClass {
  asa1,
  asa2,
  asa3,
  asa4,
  asa5,
  asa6,
}

enum MallampatiClass {
  class1,
  class2,
  class3,
  class4,
}

class PatientModel {
  final String id;
  final String name;
  final String cpf;
  final DateTime birthDate;
  final String gender;
  final double weight; // kg
  final double height; // cm
  final String? phone;
  final String? email;
  final String? address;
  final String? emergencyContact;
  final String? emergencyPhone;
  
  // Anamnese
  final List<String> diseases;
  final List<String> allergies;
  final List<String> medications;
  final bool hasApnea;
  final String? apneaDetails;
  final bool isSmoker;
  final bool isAlcoholic;
  final String? previousSurgeries;
  final String? familyHistory;
  
  // Exame físico
  final double? bmi;
  final int? heartRate;
  final String? bloodPressure;
  final int? oxygenSaturation;
  final MallampatiClass? mallampati;
  final String? airwayAssessment;
  final String? physicalExamNotes;
  
  // ASA e avaliação
  final AsaClass? asaClass;
  final String? asaNotes;
  final String? labResultsUrl;
  final String? additionalExamsUrl;
  
  // Parecer final
  final String? finalOpinion; // liberado, com ressalvas, contraindicado
  final String? restrictions;
  final String? recommendations;
  
  // Metadados
  final DateTime createdAt;
  final DateTime? lastUpdated;
  final String createdBy;
  final String? clinicId;

  PatientModel({
    required this.id,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.gender,
    required this.weight,
    required this.height,
    this.phone,
    this.email,
    this.address,
    this.emergencyContact,
    this.emergencyPhone,
    this.diseases = const [],
    this.allergies = const [],
    this.medications = const [],
    this.hasApnea = false,
    this.apneaDetails,
    this.isSmoker = false,
    this.isAlcoholic = false,
    this.previousSurgeries,
    this.familyHistory,
    this.bmi,
    this.heartRate,
    this.bloodPressure,
    this.oxygenSaturation,
    this.mallampati,
    this.airwayAssessment,
    this.physicalExamNotes,
    this.asaClass,
    this.asaNotes,
    this.labResultsUrl,
    this.additionalExamsUrl,
    this.finalOpinion,
    this.restrictions,
    this.recommendations,
    required this.createdAt,
    this.lastUpdated,
    required this.createdBy,
    this.clinicId,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      cpf: json['cpf'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      gender: json['gender'] as String,
      weight: json['weight'] as double,
      height: json['height'] as double,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      emergencyContact: json['emergencyContact'] as String?,
      emergencyPhone: json['emergencyPhone'] as String?,
      diseases: json['diseases'] != null 
          ? List<String>.from(json['diseases'] as List) 
          : [],
      allergies: json['allergies'] != null 
          ? List<String>.from(json['allergies'] as List) 
          : [],
      medications: json['medications'] != null 
          ? List<String>.from(json['medications'] as List) 
          : [],
      hasApnea: json['hasApnea'] as bool? ?? false,
      apneaDetails: json['apneaDetails'] as String?,
      isSmoker: json['isSmoker'] as bool? ?? false,
      isAlcoholic: json['isAlcoholic'] as bool? ?? false,
      previousSurgeries: json['previousSurgeries'] as String?,
      familyHistory: json['familyHistory'] as String?,
      bmi: json['bmi'] as double?,
      heartRate: json['heartRate'] as int?,
      bloodPressure: json['bloodPressure'] as String?,
      oxygenSaturation: json['oxygenSaturation'] as int?,
      mallampati: json['mallampati'] != null 
          ? MallampatiClass.values.firstWhere(
              (e) => e.toString() == 'MallampatiClass.${json['mallampati']}',
            )
          : null,
      airwayAssessment: json['airwayAssessment'] as String?,
      physicalExamNotes: json['physicalExamNotes'] as String?,
      asaClass: json['asaClass'] != null 
          ? AsaClass.values.firstWhere(
              (e) => e.toString() == 'AsaClass.${json['asaClass']}',
            )
          : null,
      asaNotes: json['asaNotes'] as String?,
      labResultsUrl: json['labResultsUrl'] as String?,
      additionalExamsUrl: json['additionalExamsUrl'] as String?,
      finalOpinion: json['finalOpinion'] as String?,
      restrictions: json['restrictions'] as String?,
      recommendations: json['recommendations'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdated: json['lastUpdated'] != null 
          ? DateTime.parse(json['lastUpdated'] as String) 
          : null,
      createdBy: json['createdBy'] as String,
      clinicId: json['clinicId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
      'weight': weight,
      'height': height,
      'phone': phone,
      'email': email,
      'address': address,
      'emergencyContact': emergencyContact,
      'emergencyPhone': emergencyPhone,
      'diseases': diseases,
      'allergies': allergies,
      'medications': medications,
      'hasApnea': hasApnea,
      'apneaDetails': apneaDetails,
      'isSmoker': isSmoker,
      'isAlcoholic': isAlcoholic,
      'previousSurgeries': previousSurgeries,
      'familyHistory': familyHistory,
      'bmi': bmi,
      'heartRate': heartRate,
      'bloodPressure': bloodPressure,
      'oxygenSaturation': oxygenSaturation,
      'mallampati': mallampati?.toString().split('.').last,
      'airwayAssessment': airwayAssessment,
      'physicalExamNotes': physicalExamNotes,
      'asaClass': asaClass?.toString().split('.').last,
      'asaNotes': asaNotes,
      'labResultsUrl': labResultsUrl,
      'additionalExamsUrl': additionalExamsUrl,
      'finalOpinion': finalOpinion,
      'restrictions': restrictions,
      'recommendations': recommendations,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'createdBy': createdBy,
      'clinicId': clinicId,
    };
  }

  int get age {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  double get bmiCalculated {
    if (height <= 0) return 0;
    final heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  PatientModel copyWith({
    String? id,
    String? name,
    String? cpf,
    DateTime? birthDate,
    String? gender,
    double? weight,
    double? height,
    String? phone,
    String? email,
    String? address,
    String? emergencyContact,
    String? emergencyPhone,
    List<String>? diseases,
    List<String>? allergies,
    List<String>? medications,
    bool? hasApnea,
    String? apneaDetails,
    bool? isSmoker,
    bool? isAlcoholic,
    String? previousSurgeries,
    String? familyHistory,
    double? bmi,
    int? heartRate,
    String? bloodPressure,
    int? oxygenSaturation,
    MallampatiClass? mallampati,
    String? airwayAssessment,
    String? physicalExamNotes,
    AsaClass? asaClass,
    String? asaNotes,
    String? labResultsUrl,
    String? additionalExamsUrl,
    String? finalOpinion,
    String? restrictions,
    String? recommendations,
    DateTime? createdAt,
    DateTime? lastUpdated,
    String? createdBy,
    String? clinicId,
  }) {
    return PatientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
      diseases: diseases ?? this.diseases,
      allergies: allergies ?? this.allergies,
      medications: medications ?? this.medications,
      hasApnea: hasApnea ?? this.hasApnea,
      apneaDetails: apneaDetails ?? this.apneaDetails,
      isSmoker: isSmoker ?? this.isSmoker,
      isAlcoholic: isAlcoholic ?? this.isAlcoholic,
      previousSurgeries: previousSurgeries ?? this.previousSurgeries,
      familyHistory: familyHistory ?? this.familyHistory,
      bmi: bmi ?? this.bmi,
      heartRate: heartRate ?? this.heartRate,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
      mallampati: mallampati ?? this.mallampati,
      airwayAssessment: airwayAssessment ?? this.airwayAssessment,
      physicalExamNotes: physicalExamNotes ?? this.physicalExamNotes,
      asaClass: asaClass ?? this.asaClass,
      asaNotes: asaNotes ?? this.asaNotes,
      labResultsUrl: labResultsUrl ?? this.labResultsUrl,
      additionalExamsUrl: additionalExamsUrl ?? this.additionalExamsUrl,
      finalOpinion: finalOpinion ?? this.finalOpinion,
      restrictions: restrictions ?? this.restrictions,
      recommendations: recommendations ?? this.recommendations,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      createdBy: createdBy ?? this.createdBy,
      clinicId: clinicId ?? this.clinicId,
    );
  }

  @override
  String toString() {
    return 'PatientModel(id: $id, name: $name, cpf: $cpf, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PatientModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 