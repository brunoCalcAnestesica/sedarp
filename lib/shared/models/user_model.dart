enum UserRole {
  clinic,
  anesthesiologist,
  administrator,
}

enum UserStatus {
  active,
  inactive,
  pending,
  suspended,
}

class UserModel {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final UserStatus status;
  final String? phone;
  final String? cpf;
  final String? cnpj;
  final String? crm;
  final String? rqe;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final Map<String, dynamic>? profileData;
  final List<String>? clinicIds; // Para anestesiologistas vinculados a clínicas
  final bool twoFactorEnabled;
  final bool lgpdAccepted;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.status,
    this.phone,
    this.cpf,
    this.cnpj,
    this.crm,
    this.rqe,
    required this.createdAt,
    this.lastLogin,
    this.profileData,
    this.clinicIds,
    this.twoFactorEnabled = false,
    this.lgpdAccepted = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
      ),
      status: UserStatus.values.firstWhere(
        (e) => e.toString() == 'UserStatus.${json['status']}',
      ),
      phone: json['phone'] as String?,
      cpf: json['cpf'] as String?,
      cnpj: json['cnpj'] as String?,
      crm: json['crm'] as String?,
      rqe: json['rqe'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLogin: json['lastLogin'] != null 
          ? DateTime.parse(json['lastLogin'] as String) 
          : null,
      profileData: json['profileData'] as Map<String, dynamic>?,
      clinicIds: json['clinicIds'] != null 
          ? List<String>.from(json['clinicIds'] as List) 
          : null,
      twoFactorEnabled: json['twoFactorEnabled'] as bool? ?? false,
      lgpdAccepted: json['lgpdAccepted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.toString().split('.').last,
      'status': status.toString().split('.').last,
      'phone': phone,
      'cpf': cpf,
      'cnpj': cnpj,
      'crm': crm,
      'rqe': rqe,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'profileData': profileData,
      'clinicIds': clinicIds,
      'twoFactorEnabled': twoFactorEnabled,
      'lgpdAccepted': lgpdAccepted,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    UserRole? role,
    UserStatus? status,
    String? phone,
    String? cpf,
    String? cnpj,
    String? crm,
    String? rqe,
    DateTime? createdAt,
    DateTime? lastLogin,
    Map<String, dynamic>? profileData,
    List<String>? clinicIds,
    bool? twoFactorEnabled,
    bool? lgpdAccepted,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      cpf: cpf ?? this.cpf,
      cnpj: cnpj ?? this.cnpj,
      crm: crm ?? this.crm,
      rqe: rqe ?? this.rqe,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      profileData: profileData ?? this.profileData,
      clinicIds: clinicIds ?? this.clinicIds,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      lgpdAccepted: lgpdAccepted ?? this.lgpdAccepted,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, role: $role, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 