enum ClinicStatus {
  all,
  approved,
  pending,
  suspended,
  rejected,
}

enum DocumentType {
  healthLicense,
  anvisaRegistration,
  socialContract,
  operatingLicense,
  croAnnexes,
  sanitarySurveillanceAnnexes,
  equipmentList,
  backupHospital,
  responsibilityTerm,
}

enum DocumentStatus {
  pending,
  approved,
  rejected,
  expired,
}

class ClinicDocument {
  final String id;
  final String name;
  final DocumentType type;
  final DocumentStatus status;
  final DateTime uploadDate;
  final DateTime expiryDate;
  final String? fileUrl;
  final String? notes;

  ClinicDocument({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.uploadDate,
    required this.expiryDate,
    this.fileUrl,
    this.notes,
  });

  factory ClinicDocument.fromJson(Map<String, dynamic> json) {
    return ClinicDocument(
      id: json['id'] as String,
      name: json['name'] as String,
      type: DocumentType.values.firstWhere(
        (e) => e.toString() == 'DocumentType.${json['type']}',
      ),
      status: DocumentStatus.values.firstWhere(
        (e) => e.toString() == 'DocumentStatus.${json['status']}',
      ),
      uploadDate: DateTime.parse(json['uploadDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      fileUrl: json['fileUrl'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'uploadDate': uploadDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'fileUrl': fileUrl,
      'notes': notes,
    };
  }
}

class ClinicModel {
  final String id;
  final String name;
  final String cnpj;
  final String cnae;
  final String address;
  final String city;
  final String state;
  final String phone;
  final String email;
  final double latitude;
  final double longitude;
  final String responsibleName;
  final String responsibleCpf;
  final String responsibleCrm;
  final String responsibleRqe;
  final ClinicStatus status;
  final DateTime createdAt;
  final DateTime? lastUpdated;
  final DateTime? updatedAt;
  
  // Documentos
  final List<ClinicDocument> documents;
  
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
    required this.city,
    required this.state,
    required this.phone,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.responsibleName,
    required this.responsibleCpf,
    required this.responsibleCrm,
    required this.responsibleRqe,
    required this.status,
    required this.createdAt,
    this.lastUpdated,
    this.updatedAt,
    this.documents = const [],
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
      city: json['city'] as String,
      state: json['state'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
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
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
      documents: json['documents'] != null 
          ? (json['documents'] as List).map((doc) => ClinicDocument.fromJson(doc)).toList()
          : [],
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
      'city': city,
      'state': state,
      'phone': phone,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'responsibleName': responsibleName,
      'responsibleCpf': responsibleCpf,
      'responsibleCrm': responsibleCrm,
      'responsibleRqe': responsibleRqe,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'documents': documents.map((doc) => doc.toJson()).toList(),
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
    String? city,
    String? state,
    String? phone,
    String? email,
    double? latitude,
    double? longitude,
    String? responsibleName,
    String? responsibleCpf,
    String? responsibleCrm,
    String? responsibleRqe,
    ClinicStatus? status,
    DateTime? createdAt,
    DateTime? lastUpdated,
    DateTime? updatedAt,
    List<ClinicDocument>? documents,
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
      city: city ?? this.city,
      state: state ?? this.state,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      responsibleName: responsibleName ?? this.responsibleName,
      responsibleCpf: responsibleCpf ?? this.responsibleCpf,
      responsibleCrm: responsibleCrm ?? this.responsibleCrm,
      responsibleRqe: responsibleRqe ?? this.responsibleRqe,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      updatedAt: updatedAt ?? this.updatedAt,
      documents: documents ?? this.documents,
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