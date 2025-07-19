enum ClinicStatus {
  active,
  inactive,
  pending,
  suspended,
  expired,
}

class ClinicModel {
  final String id;
  final String name;
  final String cnpj;
  final String cnae;
  final String address;
  final double latitude;
  final double longitude;
  final String responsibleName;
  final String responsibleCpf;
  final String responsibleCrm;
  final String responsibleRqe;
  final ClinicStatus status;
  final DateTime createdAt;
  final DateTime? lastUpdated;
  
  // Documentação
  final String? socialContractUrl;
  final String? sanitaryLicenseUrl;
  final String? operatingLicenseUrl;
  final String? croAnnexesUrl;
  final String? sanitarySurveillanceAnnexesUrl;
  final String? equipmentListUrl;
  final String? backupHospitalUrl;
  final String? responsibilityTermUrl;
  
  // Procedimentos autorizados
  final List<String> authorizedProcedures;
  
  // Equipamentos
  final List<String> equipment;
  
  // Hospital de retaguarda
  final String? backupHospitalName;
  final String? backupHospitalAddress;
  final String? backupHospitalPhone;
  
  // Configurações
  final Map<String, dynamic>? settings;
  final List<String>? anesthesiologistIds;

  ClinicModel({
    required this.id,
    required this.name,
    required this.cnpj,
    required this.cnae,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.responsibleName,
    required this.responsibleCpf,
    required this.responsibleCrm,
    required this.responsibleRqe,
    required this.status,
    required this.createdAt,
    this.lastUpdated,
    this.socialContractUrl,
    this.sanitaryLicenseUrl,
    this.operatingLicenseUrl,
    this.croAnnexesUrl,
    this.sanitarySurveillanceAnnexesUrl,
    this.equipmentListUrl,
    this.backupHospitalUrl,
    this.responsibilityTermUrl,
    this.authorizedProcedures = const [],
    this.equipment = const [],
    this.backupHospitalName,
    this.backupHospitalAddress,
    this.backupHospitalPhone,
    this.settings,
    this.anesthesiologistIds,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      id: json['id'] as String,
      name: json['name'] as String,
      cnpj: json['cnpj'] as String,
      cnae: json['cnae'] as String,
      address: json['address'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      responsibleName: json['responsibleName'] as String,
      responsibleCpf: json['responsibleCpf'] as String,
      responsibleCrm: json['responsibleCrm'] as String,
      responsibleRqe: json['responsibleRqe'] as String,
      status: ClinicStatus.values.firstWhere(
        (e) => e.toString() == 'ClinicStatus.${json['status']}',
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdated: json['lastUpdated'] != null 
          ? DateTime.parse(json['lastUpdated'] as String) 
          : null,
      socialContractUrl: json['socialContractUrl'] as String?,
      sanitaryLicenseUrl: json['sanitaryLicenseUrl'] as String?,
      operatingLicenseUrl: json['operatingLicenseUrl'] as String?,
      croAnnexesUrl: json['croAnnexesUrl'] as String?,
      sanitarySurveillanceAnnexesUrl: json['sanitarySurveillanceAnnexesUrl'] as String?,
      equipmentListUrl: json['equipmentListUrl'] as String?,
      backupHospitalUrl: json['backupHospitalUrl'] as String?,
      responsibilityTermUrl: json['responsibilityTermUrl'] as String?,
      authorizedProcedures: json['authorizedProcedures'] != null 
          ? List<String>.from(json['authorizedProcedures'] as List) 
          : [],
      equipment: json['equipment'] != null 
          ? List<String>.from(json['equipment'] as List) 
          : [],
      backupHospitalName: json['backupHospitalName'] as String?,
      backupHospitalAddress: json['backupHospitalAddress'] as String?,
      backupHospitalPhone: json['backupHospitalPhone'] as String?,
      settings: json['settings'] as Map<String, dynamic>?,
      anesthesiologistIds: json['anesthesiologistIds'] != null 
          ? List<String>.from(json['anesthesiologistIds'] as List) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cnpj': cnpj,
      'cnae': cnae,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'responsibleName': responsibleName,
      'responsibleCpf': responsibleCpf,
      'responsibleCrm': responsibleCrm,
      'responsibleRqe': responsibleRqe,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'socialContractUrl': socialContractUrl,
      'sanitaryLicenseUrl': sanitaryLicenseUrl,
      'operatingLicenseUrl': operatingLicenseUrl,
      'croAnnexesUrl': croAnnexesUrl,
      'sanitarySurveillanceAnnexesUrl': sanitarySurveillanceAnnexesUrl,
      'equipmentListUrl': equipmentListUrl,
      'backupHospitalUrl': backupHospitalUrl,
      'responsibilityTermUrl': responsibilityTermUrl,
      'authorizedProcedures': authorizedProcedures,
      'equipment': equipment,
      'backupHospitalName': backupHospitalName,
      'backupHospitalAddress': backupHospitalAddress,
      'backupHospitalPhone': backupHospitalPhone,
      'settings': settings,
      'anesthesiologistIds': anesthesiologistIds,
    };
  }

  ClinicModel copyWith({
    String? id,
    String? name,
    String? cnpj,
    String? cnae,
    String? address,
    double? latitude,
    double? longitude,
    String? responsibleName,
    String? responsibleCpf,
    String? responsibleCrm,
    String? responsibleRqe,
    ClinicStatus? status,
    DateTime? createdAt,
    DateTime? lastUpdated,
    String? socialContractUrl,
    String? sanitaryLicenseUrl,
    String? operatingLicenseUrl,
    String? croAnnexesUrl,
    String? sanitarySurveillanceAnnexesUrl,
    String? equipmentListUrl,
    String? backupHospitalUrl,
    String? responsibilityTermUrl,
    List<String>? authorizedProcedures,
    List<String>? equipment,
    String? backupHospitalName,
    String? backupHospitalAddress,
    String? backupHospitalPhone,
    Map<String, dynamic>? settings,
    List<String>? anesthesiologistIds,
  }) {
    return ClinicModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cnpj: cnpj ?? this.cnpj,
      cnae: cnae ?? this.cnae,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      responsibleName: responsibleName ?? this.responsibleName,
      responsibleCpf: responsibleCpf ?? this.responsibleCpf,
      responsibleCrm: responsibleCrm ?? this.responsibleCrm,
      responsibleRqe: responsibleRqe ?? this.responsibleRqe,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      socialContractUrl: socialContractUrl ?? this.socialContractUrl,
      sanitaryLicenseUrl: sanitaryLicenseUrl ?? this.sanitaryLicenseUrl,
      operatingLicenseUrl: operatingLicenseUrl ?? this.operatingLicenseUrl,
      croAnnexesUrl: croAnnexesUrl ?? this.croAnnexesUrl,
      sanitarySurveillanceAnnexesUrl: sanitarySurveillanceAnnexesUrl ?? this.sanitarySurveillanceAnnexesUrl,
      equipmentListUrl: equipmentListUrl ?? this.equipmentListUrl,
      backupHospitalUrl: backupHospitalUrl ?? this.backupHospitalUrl,
      responsibilityTermUrl: responsibilityTermUrl ?? this.responsibilityTermUrl,
      authorizedProcedures: authorizedProcedures ?? this.authorizedProcedures,
      equipment: equipment ?? this.equipment,
      backupHospitalName: backupHospitalName ?? this.backupHospitalName,
      backupHospitalAddress: backupHospitalAddress ?? this.backupHospitalAddress,
      backupHospitalPhone: backupHospitalPhone ?? this.backupHospitalPhone,
      settings: settings ?? this.settings,
      anesthesiologistIds: anesthesiologistIds ?? this.anesthesiologistIds,
    );
  }

  @override
  String toString() {
    return 'ClinicModel(id: $id, name: $name, cnpj: $cnpj, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClinicModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 