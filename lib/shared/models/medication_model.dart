enum MedicationType {
  controlled, // Psicotrópicos
  regular,    // Medicamentos comuns
  emergency,  // Medicamentos de emergência
}

enum MedicationUnit {
  mg,
  mcg,
  ml,
  units,
  ampoules,
  vials,
  tablets,
  capsules,
}

class MedicationModel {
  final String id;
  final String name;
  final String activeIngredient;
  final String concentration;
  final MedicationType type;
  final MedicationUnit unit;
  final String manufacturer;
  final String? registrationNumber; // Número de registro ANVISA
  final String? controlledSubstanceCode; // Código da substância controlada
  final bool requiresPrescription;
  final String? therapeuticClass;
  final String? description;
  final String? contraindications;
  final String? sideEffects;
  final String? dosageInstructions;
  
  // Controle de estoque
  final double currentStock;
  final double minimumStock;
  final double maximumStock;
  final String? location; // Localização física no estoque
  
  // Lotes
  final List<MedicationLot> lots;
  
  // Metadados
  final DateTime createdAt;
  final DateTime? lastUpdated;
  final String createdBy;
  final bool isActive;

  MedicationModel({
    required this.id,
    required this.name,
    required this.activeIngredient,
    required this.concentration,
    required this.type,
    required this.unit,
    required this.manufacturer,
    this.registrationNumber,
    this.controlledSubstanceCode,
    this.requiresPrescription = false,
    this.therapeuticClass,
    this.description,
    this.contraindications,
    this.sideEffects,
    this.dosageInstructions,
    this.currentStock = 0,
    this.minimumStock = 0,
    this.maximumStock = 0,
    this.location,
    this.lots = const [],
    required this.createdAt,
    this.lastUpdated,
    required this.createdBy,
    this.isActive = true,
  });

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      activeIngredient: json['activeIngredient'] as String,
      concentration: json['concentration'] as String,
      type: MedicationType.values.firstWhere(
        (e) => e.toString() == 'MedicationType.${json['type']}',
      ),
      unit: MedicationUnit.values.firstWhere(
        (e) => e.toString() == 'MedicationUnit.${json['unit']}',
      ),
      manufacturer: json['manufacturer'] as String,
      registrationNumber: json['registrationNumber'] as String?,
      controlledSubstanceCode: json['controlledSubstanceCode'] as String?,
      requiresPrescription: json['requiresPrescription'] as bool? ?? false,
      therapeuticClass: json['therapeuticClass'] as String?,
      description: json['description'] as String?,
      contraindications: json['contraindications'] as String?,
      sideEffects: json['sideEffects'] as String?,
      dosageInstructions: json['dosageInstructions'] as String?,
      currentStock: json['currentStock'] as double? ?? 0,
      minimumStock: json['minimumStock'] as double? ?? 0,
      maximumStock: json['maximumStock'] as double? ?? 0,
      location: json['location'] as String?,
      lots: json['lots'] != null 
          ? (json['lots'] as List)
              .map((lot) => MedicationLot.fromJson(lot as Map<String, dynamic>))
              .toList()
          : [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdated: json['lastUpdated'] != null 
          ? DateTime.parse(json['lastUpdated'] as String) 
          : null,
      createdBy: json['createdBy'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'activeIngredient': activeIngredient,
      'concentration': concentration,
      'type': type.toString().split('.').last,
      'unit': unit.toString().split('.').last,
      'manufacturer': manufacturer,
      'registrationNumber': registrationNumber,
      'controlledSubstanceCode': controlledSubstanceCode,
      'requiresPrescription': requiresPrescription,
      'therapeuticClass': therapeuticClass,
      'description': description,
      'contraindications': contraindications,
      'sideEffects': sideEffects,
      'dosageInstructions': dosageInstructions,
      'currentStock': currentStock,
      'minimumStock': minimumStock,
      'maximumStock': maximumStock,
      'location': location,
      'lots': lots.map((lot) => lot.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'createdBy': createdBy,
      'isActive': isActive,
    };
  }

  bool get isLowStock => currentStock <= minimumStock;
  bool get isOutOfStock => currentStock <= 0;
  bool get isOverStocked => currentStock > maximumStock && maximumStock > 0;

  List<MedicationLot> get validLots {
    final now = DateTime.now();
    return lots.where((lot) => lot.expiryDate.isAfter(now) && lot.remainingQuantity > 0).toList();
  }

  List<MedicationLot> get expiredLots {
    final now = DateTime.now();
    return lots.where((lot) => lot.expiryDate.isBefore(now)).toList();
  }

  List<MedicationLot> get expiringSoonLots {
    final now = DateTime.now();
    final thirtyDaysFromNow = now.add(const Duration(days: 30));
    return lots.where((lot) => 
        lot.expiryDate.isAfter(now) && 
        lot.expiryDate.isBefore(thirtyDaysFromNow) && 
        lot.remainingQuantity > 0).toList();
  }

  String get typeDisplay {
    switch (type) {
      case MedicationType.controlled:
        return 'Controlado';
      case MedicationType.regular:
        return 'Regular';
      case MedicationType.emergency:
        return 'Emergência';
    }
  }

  String get unitDisplay {
    switch (unit) {
      case MedicationUnit.mg:
        return 'mg';
      case MedicationUnit.mcg:
        return 'mcg';
      case MedicationUnit.ml:
        return 'ml';
      case MedicationUnit.units:
        return 'unidades';
      case MedicationUnit.ampoules:
        return 'ampolas';
      case MedicationUnit.vials:
        return 'frascos';
      case MedicationUnit.tablets:
        return 'comprimidos';
      case MedicationUnit.capsules:
        return 'cápsulas';
    }
  }

  MedicationModel copyWith({
    String? id,
    String? name,
    String? activeIngredient,
    String? concentration,
    MedicationType? type,
    MedicationUnit? unit,
    String? manufacturer,
    String? registrationNumber,
    String? controlledSubstanceCode,
    bool? requiresPrescription,
    String? therapeuticClass,
    String? description,
    String? contraindications,
    String? sideEffects,
    String? dosageInstructions,
    double? currentStock,
    double? minimumStock,
    double? maximumStock,
    String? location,
    List<MedicationLot>? lots,
    DateTime? createdAt,
    DateTime? lastUpdated,
    String? createdBy,
    bool? isActive,
  }) {
    return MedicationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      activeIngredient: activeIngredient ?? this.activeIngredient,
      concentration: concentration ?? this.concentration,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      manufacturer: manufacturer ?? this.manufacturer,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      controlledSubstanceCode: controlledSubstanceCode ?? this.controlledSubstanceCode,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
      therapeuticClass: therapeuticClass ?? this.therapeuticClass,
      description: description ?? this.description,
      contraindications: contraindications ?? this.contraindications,
      sideEffects: sideEffects ?? this.sideEffects,
      dosageInstructions: dosageInstructions ?? this.dosageInstructions,
      currentStock: currentStock ?? this.currentStock,
      minimumStock: minimumStock ?? this.minimumStock,
      maximumStock: maximumStock ?? this.maximumStock,
      location: location ?? this.location,
      lots: lots ?? this.lots,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      createdBy: createdBy ?? this.createdBy,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() {
    return 'MedicationModel(id: $id, name: $name, currentStock: $currentStock)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MedicationModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class MedicationLot {
  final String id;
  final String lotNumber;
  final String supplier;
  final DateTime expiryDate;
  final double initialQuantity;
  final double remainingQuantity;
  final double unitPrice;
  final DateTime receivedDate;
  final String? invoiceNumber;
  final String? notes;

  MedicationLot({
    required this.id,
    required this.lotNumber,
    required this.supplier,
    required this.expiryDate,
    required this.initialQuantity,
    required this.remainingQuantity,
    required this.unitPrice,
    required this.receivedDate,
    this.invoiceNumber,
    this.notes,
  });

  factory MedicationLot.fromJson(Map<String, dynamic> json) {
    return MedicationLot(
      id: json['id'] as String,
      lotNumber: json['lotNumber'] as String,
      supplier: json['supplier'] as String,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      initialQuantity: json['initialQuantity'] as double,
      remainingQuantity: json['remainingQuantity'] as double,
      unitPrice: json['unitPrice'] as double,
      receivedDate: DateTime.parse(json['receivedDate'] as String),
      invoiceNumber: json['invoiceNumber'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lotNumber': lotNumber,
      'supplier': supplier,
      'expiryDate': expiryDate.toIso8601String(),
      'initialQuantity': initialQuantity,
      'remainingQuantity': remainingQuantity,
      'unitPrice': unitPrice,
      'receivedDate': receivedDate.toIso8601String(),
      'invoiceNumber': invoiceNumber,
      'notes': notes,
    };
  }

  bool get isExpired => expiryDate.isBefore(DateTime.now());
  bool get isExpiringSoon {
    final thirtyDaysFromNow = DateTime.now().add(const Duration(days: 30));
    return expiryDate.isBefore(thirtyDaysFromNow) && !isExpired;
  }

  double get consumedQuantity => initialQuantity - remainingQuantity;
  double get totalValue => initialQuantity * unitPrice;
  double get remainingValue => remainingQuantity * unitPrice;

  MedicationLot copyWith({
    String? id,
    String? lotNumber,
    String? supplier,
    DateTime? expiryDate,
    double? initialQuantity,
    double? remainingQuantity,
    double? unitPrice,
    DateTime? receivedDate,
    String? invoiceNumber,
    String? notes,
  }) {
    return MedicationLot(
      id: id ?? this.id,
      lotNumber: lotNumber ?? this.lotNumber,
      supplier: supplier ?? this.supplier,
      expiryDate: expiryDate ?? this.expiryDate,
      initialQuantity: initialQuantity ?? this.initialQuantity,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
      unitPrice: unitPrice ?? this.unitPrice,
      receivedDate: receivedDate ?? this.receivedDate,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() {
    return 'MedicationLot(id: $id, lotNumber: $lotNumber, remainingQuantity: $remainingQuantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MedicationLot && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 