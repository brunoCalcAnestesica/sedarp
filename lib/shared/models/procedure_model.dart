enum ProcedureStatus {
  scheduled,
  inProgress,
  completed,
  cancelled,
  noShow,
}

enum ProcedureType {
  sedation,
  anesthesia,
  consultation,
  evaluation,
}

class ProcedureModel {
  final String id;
  final String patientId;
  final String clinicId;
  final String anesthesiologistId;
  final String procedureName;
  final ProcedureType type;
  final ProcedureStatus status;
  final DateTime scheduledDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final int estimatedDuration; // minutos
  final String? notes;
  final String? preoperativeInstructions;
  final bool requiresFasting;
  final int fastingHours;
  final String? fastingInstructions;
  
  // Dados do paciente (cópia para histórico)
  final String patientName;
  final String patientCpf;
  final int patientAge;
  final double patientWeight;
  final String? patientPhone;
  
  // Dados da clínica
  final String clinicName;
  final String clinicAddress;
  
  // Dados do anestesiologista
  final String anesthesiologistName;
  final String anesthesiologistCrm;
  
  // Avaliação pré-anestésica
  final String? preAnestheticEvaluationId;
  final bool preAnestheticCompleted;
  final String? preAnestheticStatus; // liberado, com ressalvas, contraindicado
  
  // Sedação/Anestesia
  final String? sedationRecordId;
  final bool sedationCompleted;
  
  // Documentos
  final String? consentFormUrl;
  final String? dischargeFormUrl;
  final String? anesthesiaRecordUrl;
  
  // Metadados
  final DateTime createdAt;
  final DateTime? lastUpdated;
  final String createdBy;
  final String? cancelledBy;
  final String? cancellationReason;

  ProcedureModel({
    required this.id,
    required this.patientId,
    required this.clinicId,
    required this.anesthesiologistId,
    required this.procedureName,
    required this.type,
    required this.status,
    required this.scheduledDate,
    this.startTime,
    this.endTime,
    required this.estimatedDuration,
    this.notes,
    this.preoperativeInstructions,
    this.requiresFasting = true,
    this.fastingHours = 8,
    this.fastingInstructions,
    required this.patientName,
    required this.patientCpf,
    required this.patientAge,
    required this.patientWeight,
    this.patientPhone,
    required this.clinicName,
    required this.clinicAddress,
    required this.anesthesiologistName,
    required this.anesthesiologistCrm,
    this.preAnestheticEvaluationId,
    this.preAnestheticCompleted = false,
    this.preAnestheticStatus,
    this.sedationRecordId,
    this.sedationCompleted = false,
    this.consentFormUrl,
    this.dischargeFormUrl,
    this.anesthesiaRecordUrl,
    required this.createdAt,
    this.lastUpdated,
    required this.createdBy,
    this.cancelledBy,
    this.cancellationReason,
  });

  factory ProcedureModel.fromJson(Map<String, dynamic> json) {
    return ProcedureModel(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      clinicId: json['clinicId'] as String,
      anesthesiologistId: json['anesthesiologistId'] as String,
      procedureName: json['procedureName'] as String,
      type: ProcedureType.values.firstWhere(
        (e) => e.toString() == 'ProcedureType.${json['type']}',
      ),
      status: ProcedureStatus.values.firstWhere(
        (e) => e.toString() == 'ProcedureStatus.${json['status']}',
      ),
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
      startTime: json['startTime'] != null 
          ? DateTime.parse(json['startTime'] as String) 
          : null,
      endTime: json['endTime'] != null 
          ? DateTime.parse(json['endTime'] as String) 
          : null,
      estimatedDuration: json['estimatedDuration'] as int,
      notes: json['notes'] as String?,
      preoperativeInstructions: json['preoperativeInstructions'] as String?,
      requiresFasting: json['requiresFasting'] as bool? ?? true,
      fastingHours: json['fastingHours'] as int? ?? 8,
      fastingInstructions: json['fastingInstructions'] as String?,
      patientName: json['patientName'] as String,
      patientCpf: json['patientCpf'] as String,
      patientAge: json['patientAge'] as int,
      patientWeight: json['patientWeight'] as double,
      patientPhone: json['patientPhone'] as String?,
      clinicName: json['clinicName'] as String,
      clinicAddress: json['clinicAddress'] as String,
      anesthesiologistName: json['anesthesiologistName'] as String,
      anesthesiologistCrm: json['anesthesiologistCrm'] as String,
      preAnestheticEvaluationId: json['preAnestheticEvaluationId'] as String?,
      preAnestheticCompleted: json['preAnestheticCompleted'] as bool? ?? false,
      preAnestheticStatus: json['preAnestheticStatus'] as String?,
      sedationRecordId: json['sedationRecordId'] as String?,
      sedationCompleted: json['sedationCompleted'] as bool? ?? false,
      consentFormUrl: json['consentFormUrl'] as String?,
      dischargeFormUrl: json['dischargeFormUrl'] as String?,
      anesthesiaRecordUrl: json['anesthesiaRecordUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdated: json['lastUpdated'] != null 
          ? DateTime.parse(json['lastUpdated'] as String) 
          : null,
      createdBy: json['createdBy'] as String,
      cancelledBy: json['cancelledBy'] as String?,
      cancellationReason: json['cancellationReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'clinicId': clinicId,
      'anesthesiologistId': anesthesiologistId,
      'procedureName': procedureName,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'scheduledDate': scheduledDate.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'estimatedDuration': estimatedDuration,
      'notes': notes,
      'preoperativeInstructions': preoperativeInstructions,
      'requiresFasting': requiresFasting,
      'fastingHours': fastingHours,
      'fastingInstructions': fastingInstructions,
      'patientName': patientName,
      'patientCpf': patientCpf,
      'patientAge': patientAge,
      'patientWeight': patientWeight,
      'patientPhone': patientPhone,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'anesthesiologistName': anesthesiologistName,
      'anesthesiologistCrm': anesthesiologistCrm,
      'preAnestheticEvaluationId': preAnestheticEvaluationId,
      'preAnestheticCompleted': preAnestheticCompleted,
      'preAnestheticStatus': preAnestheticStatus,
      'sedationRecordId': sedationRecordId,
      'sedationCompleted': sedationCompleted,
      'consentFormUrl': consentFormUrl,
      'dischargeFormUrl': dischargeFormUrl,
      'anesthesiaRecordUrl': anesthesiaRecordUrl,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'createdBy': createdBy,
      'cancelledBy': cancelledBy,
      'cancellationReason': cancellationReason,
    };
  }

  Duration? get actualDuration {
    if (startTime == null || endTime == null) return null;
    return endTime!.difference(startTime!);
  }

  bool get isToday {
    final now = DateTime.now();
    return scheduledDate.year == now.year &&
           scheduledDate.month == now.month &&
           scheduledDate.day == now.day;
  }

  bool get isPast {
    return scheduledDate.isBefore(DateTime.now());
  }

  bool get isUpcoming {
    return scheduledDate.isAfter(DateTime.now());
  }

  String get statusDisplay {
    switch (status) {
      case ProcedureStatus.scheduled:
        return 'Agendado';
      case ProcedureStatus.inProgress:
        return 'Em Andamento';
      case ProcedureStatus.completed:
        return 'Concluído';
      case ProcedureStatus.cancelled:
        return 'Cancelado';
      case ProcedureStatus.noShow:
        return 'Não Compareceu';
    }
  }

  String get typeDisplay {
    switch (type) {
      case ProcedureType.sedation:
        return 'Sedação';
      case ProcedureType.anesthesia:
        return 'Anestesia';
      case ProcedureType.consultation:
        return 'Consulta';
      case ProcedureType.evaluation:
        return 'Avaliação';
    }
  }

  ProcedureModel copyWith({
    String? id,
    String? patientId,
    String? clinicId,
    String? anesthesiologistId,
    String? procedureName,
    ProcedureType? type,
    ProcedureStatus? status,
    DateTime? scheduledDate,
    DateTime? startTime,
    DateTime? endTime,
    int? estimatedDuration,
    String? notes,
    String? preoperativeInstructions,
    bool? requiresFasting,
    int? fastingHours,
    String? fastingInstructions,
    String? patientName,
    String? patientCpf,
    int? patientAge,
    double? patientWeight,
    String? patientPhone,
    String? clinicName,
    String? clinicAddress,
    String? anesthesiologistName,
    String? anesthesiologistCrm,
    String? preAnestheticEvaluationId,
    bool? preAnestheticCompleted,
    String? preAnestheticStatus,
    String? sedationRecordId,
    bool? sedationCompleted,
    String? consentFormUrl,
    String? dischargeFormUrl,
    String? anesthesiaRecordUrl,
    DateTime? createdAt,
    DateTime? lastUpdated,
    String? createdBy,
    String? cancelledBy,
    String? cancellationReason,
  }) {
    return ProcedureModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      clinicId: clinicId ?? this.clinicId,
      anesthesiologistId: anesthesiologistId ?? this.anesthesiologistId,
      procedureName: procedureName ?? this.procedureName,
      type: type ?? this.type,
      status: status ?? this.status,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      notes: notes ?? this.notes,
      preoperativeInstructions: preoperativeInstructions ?? this.preoperativeInstructions,
      requiresFasting: requiresFasting ?? this.requiresFasting,
      fastingHours: fastingHours ?? this.fastingHours,
      fastingInstructions: fastingInstructions ?? this.fastingInstructions,
      patientName: patientName ?? this.patientName,
      patientCpf: patientCpf ?? this.patientCpf,
      patientAge: patientAge ?? this.patientAge,
      patientWeight: patientWeight ?? this.patientWeight,
      patientPhone: patientPhone ?? this.patientPhone,
      clinicName: clinicName ?? this.clinicName,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      anesthesiologistName: anesthesiologistName ?? this.anesthesiologistName,
      anesthesiologistCrm: anesthesiologistCrm ?? this.anesthesiologistCrm,
      preAnestheticEvaluationId: preAnestheticEvaluationId ?? this.preAnestheticEvaluationId,
      preAnestheticCompleted: preAnestheticCompleted ?? this.preAnestheticCompleted,
      preAnestheticStatus: preAnestheticStatus ?? this.preAnestheticStatus,
      sedationRecordId: sedationRecordId ?? this.sedationRecordId,
      sedationCompleted: sedationCompleted ?? this.sedationCompleted,
      consentFormUrl: consentFormUrl ?? this.consentFormUrl,
      dischargeFormUrl: dischargeFormUrl ?? this.dischargeFormUrl,
      anesthesiaRecordUrl: anesthesiaRecordUrl ?? this.anesthesiaRecordUrl,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      createdBy: createdBy ?? this.createdBy,
      cancelledBy: cancelledBy ?? this.cancelledBy,
      cancellationReason: cancellationReason ?? this.cancellationReason,
    );
  }

  @override
  String toString() {
    return 'ProcedureModel(id: $id, patientName: $patientName, procedureName: $procedureName, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProcedureModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 