import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/clinic_model.dart';

class ClinicFormScreen extends StatefulWidget {
  final ClinicModel? clinic; // null para nova clínica

  const ClinicFormScreen({
    super.key,
    this.clinic,
  });

  @override
  State<ClinicFormScreen> createState() => _ClinicFormScreenState();
}

class _ClinicFormScreenState extends State<ClinicFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _cnaeController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _responsibleNameController = TextEditingController();
  final _responsibleCpfController = TextEditingController();
  final _responsibleCrmController = TextEditingController();
  final _responsibleRqeController = TextEditingController();
  final _backupHospitalNameController = TextEditingController();
  final _backupHospitalAddressController = TextEditingController();
  final _backupHospitalPhoneController = TextEditingController();
  
  ClinicStatus _selectedStatus = ClinicStatus.pending;
  List<String> _selectedProcedures = [];
  List<String> _selectedEquipment = [];
  List<ClinicDocument> _documents = [];
  
  bool _isLoading = false;
  bool _showBackupHospital = false;

  final List<String> _availableProcedures = [
    'Sedação Consciente',
    'Sedação Profunda',
    'Procedimentos Odontológicos',
    'Procedimentos Cirúrgicos',
    'Procedimentos Dermatológicos',
    'Procedimentos Oftalmológicos',
    'Procedimentos Ginecológicos',
    'Procedimentos Urológicos',
  ];

  final List<String> _availableEquipment = [
    'Monitor Multiparamétrico',
    'Desfibrilador',
    'Ventilador Mecânico',
    'Bomba de Infusão',
    'Oxímetro de Pulso',
    'Capnógrafo',
    'Eletrocardiógrafo',
    'Sistema de Aspiração',
    'Carro de Emergência',
    'Maca de Transporte',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.clinic != null) {
      _loadClinicData();
    }
  }

  void _loadClinicData() {
    final clinic = widget.clinic!;
    _nameController.text = clinic.name;
    _cnpjController.text = clinic.cnpj;
    _cnaeController.text = clinic.cnae;
    _addressController.text = clinic.address;
    _cityController.text = clinic.city;
    _stateController.text = clinic.state;
    _phoneController.text = clinic.phone;
    _emailController.text = clinic.email;
    _responsibleNameController.text = clinic.responsibleName;
    _responsibleCpfController.text = clinic.responsibleCpf;
    _responsibleCrmController.text = clinic.responsibleCrm;
    _responsibleRqeController.text = clinic.responsibleRqe;
    _backupHospitalNameController.text = clinic.backupHospitalName ?? '';
    _backupHospitalAddressController.text = clinic.backupHospitalAddress ?? '';
    _backupHospitalPhoneController.text = clinic.backupHospitalPhone ?? '';
    
    _selectedStatus = clinic.status;
    _selectedProcedures = List.from(clinic.authorizedProcedures);
    _selectedEquipment = List.from(clinic.equipment);
    _documents = List.from(clinic.documents);
    _showBackupHospital = clinic.backupHospitalName != null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cnpjController.dispose();
    _cnaeController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _responsibleNameController.dispose();
    _responsibleCpfController.dispose();
    _responsibleCrmController.dispose();
    _responsibleRqeController.dispose();
    _backupHospitalNameController.dispose();
    _backupHospitalAddressController.dispose();
    _backupHospitalPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clinic != null ? 'Editar Clínica' : 'Nova Clínica'),
        backgroundColor: AppConstants.secondaryColor,
        actions: [
          if (!_isLoading)
            TextButton(
              onPressed: _saveClinic,
              child: const Text(
                'Salvar',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Informações básicas
                    _buildSection(
                      'Informações Básicas',
                      [
                        _buildTextField(
                          controller: _nameController,
                          label: 'Nome da Clínica',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nome é obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        _buildTextField(
                          controller: _cnpjController,
                          label: 'CNPJ',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(14),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CNPJ é obrigatório';
                            }
                            if (value.length != 14) {
                              return 'CNPJ deve ter 14 dígitos';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        _buildTextField(
                          controller: _cnaeController,
                          label: 'CNAE',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CNAE é obrigatório';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.paddingLarge),
                    
                    // Endereço e contato
                    _buildSection(
                      'Endereço e Contato',
                      [
                        _buildTextField(
                          controller: _addressController,
                          label: 'Endereço',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Endereço é obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _cityController,
                                label: 'Cidade',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Cidade é obrigatória';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Expanded(
                              child: _buildTextField(
                                controller: _stateController,
                                label: 'Estado',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Estado é obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        _buildTextField(
                          controller: _phoneController,
                          label: 'Telefone',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Telefone é obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        _buildTextField(
                          controller: _emailController,
                          label: 'E-mail',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'E-mail é obrigatório';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.paddingLarge),
                    
                    // Responsável técnico
                    _buildSection(
                      'Responsável Técnico',
                      [
                        _buildTextField(
                          controller: _responsibleNameController,
                          label: 'Nome do Responsável',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nome do responsável é obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        _buildTextField(
                          controller: _responsibleCpfController,
                          label: 'CPF',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CPF é obrigatório';
                            }
                            if (value.length != 11) {
                              return 'CPF deve ter 11 dígitos';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        _buildTextField(
                          controller: _responsibleCrmController,
                          label: 'CRM',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CRM é obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        _buildTextField(
                          controller: _responsibleRqeController,
                          label: 'RQE',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'RQE é obrigatório';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.paddingLarge),
                    
                    // Status
                    _buildSection(
                      'Status',
                      [
                        DropdownButtonFormField<ClinicStatus>(
                          value: _selectedStatus,
                          decoration: const InputDecoration(
                            labelText: 'Status da Clínica',
                            border: OutlineInputBorder(),
                          ),
                          items: ClinicStatus.values
                              .where((status) => status != ClinicStatus.all)
                              .map((status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(_getStatusLabel(status)),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.paddingLarge),
                    
                    // Procedimentos autorizados
                    _buildSection(
                      'Procedimentos Autorizados',
                      [
                        Wrap(
                          spacing: AppConstants.paddingSmall,
                          runSpacing: AppConstants.paddingSmall,
                          children: _availableProcedures.map((procedure) {
                            final isSelected = _selectedProcedures.contains(procedure);
                            return FilterChip(
                              label: Text(procedure),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedProcedures.add(procedure);
                                  } else {
                                    _selectedProcedures.remove(procedure);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.paddingLarge),
                    
                    // Equipamentos
                    _buildSection(
                      'Equipamentos',
                      [
                        Wrap(
                          spacing: AppConstants.paddingSmall,
                          runSpacing: AppConstants.paddingSmall,
                          children: _availableEquipment.map((equipment) {
                            final isSelected = _selectedEquipment.contains(equipment);
                            return FilterChip(
                              label: Text(equipment),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedEquipment.add(equipment);
                                  } else {
                                    _selectedEquipment.remove(equipment);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.paddingLarge),
                    
                    // Hospital de retaguarda
                    _buildSection(
                      'Hospital de Retaguarda',
                      [
                        SwitchListTile(
                          title: const Text('Possui hospital de retaguarda'),
                          value: _showBackupHospital,
                          onChanged: (value) {
                            setState(() {
                              _showBackupHospital = value;
                            });
                          },
                        ),
                        if (_showBackupHospital) ...[
                          const SizedBox(height: AppConstants.paddingMedium),
                          _buildTextField(
                            controller: _backupHospitalNameController,
                            label: 'Nome do Hospital',
                          ),
                          const SizedBox(height: AppConstants.paddingMedium),
                          _buildTextField(
                            controller: _backupHospitalAddressController,
                            label: 'Endereço do Hospital',
                          ),
                          const SizedBox(height: AppConstants.paddingMedium),
                          _buildTextField(
                            controller: _backupHospitalPhoneController,
                            label: 'Telefone do Hospital',
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.paddingLarge),
                    
                    // Documentos
                    _buildSection(
                      'Documentos',
                      [
                        if (_documents.isEmpty)
                          const Text('Nenhum documento adicionado.')
                        else
                          ..._documents.map((doc) => _buildDocumentItem(doc)),
                        const SizedBox(height: AppConstants.paddingMedium),
                        ElevatedButton.icon(
                          onPressed: _addDocument,
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar Documento'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.secondaryColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.paddingLarge),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }

  Widget _buildDocumentItem(ClinicDocument document) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
      child: ListTile(
        leading: Icon(
          _getDocumentIcon(document.type),
          color: _getDocumentColor(document.status),
        ),
        title: Text(document.name),
        subtitle: Text(_getDocumentTypeLabel(document.type)),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            setState(() {
              _documents.remove(document);
            });
          },
        ),
      ),
    );
  }

  String _getStatusLabel(ClinicStatus status) {
    switch (status) {
      case ClinicStatus.approved:
        return 'Aprovada';
      case ClinicStatus.pending:
        return 'Pendente';
      case ClinicStatus.suspended:
        return 'Suspensa';
      case ClinicStatus.rejected:
        return 'Rejeitada';
      case ClinicStatus.all:
        return 'Todas';
    }
  }

  String _getDocumentTypeLabel(DocumentType type) {
    switch (type) {
      case DocumentType.healthLicense:
        return 'Alvará Sanitário';
      case DocumentType.anvisaRegistration:
        return 'Registro ANVISA';
      case DocumentType.socialContract:
        return 'Contrato Social';
      case DocumentType.operatingLicense:
        return 'Licença de Funcionamento';
      case DocumentType.croAnnexes:
        return 'Anexos CRO';
      case DocumentType.sanitarySurveillanceAnnexes:
        return 'Anexos Vigilância Sanitária';
      case DocumentType.equipmentList:
        return 'Lista de Equipamentos';
      case DocumentType.backupHospital:
        return 'Hospital de Retaguarda';
      case DocumentType.responsibilityTerm:
        return 'Termo de Responsabilidade';
    }
  }

  IconData _getDocumentIcon(DocumentType type) {
    switch (type) {
      case DocumentType.healthLicense:
        return Icons.health_and_safety;
      case DocumentType.anvisaRegistration:
        return Icons.verified;
      case DocumentType.socialContract:
        return Icons.description;
      case DocumentType.operatingLicense:
        return Icons.business;
      case DocumentType.croAnnexes:
        return Icons.medical_services;
      case DocumentType.sanitarySurveillanceAnnexes:
        return Icons.security;
      case DocumentType.equipmentList:
        return Icons.build;
      case DocumentType.backupHospital:
        return Icons.local_hospital;
      case DocumentType.responsibilityTerm:
        return Icons.gavel;
    }
  }

  Color _getDocumentColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.approved:
        return AppConstants.successColor;
      case DocumentStatus.pending:
        return AppConstants.warningColor;
      case DocumentStatus.rejected:
        return AppConstants.errorColor;
      case DocumentStatus.expired:
        return AppConstants.errorColor;
    }
  }

  void _addDocument() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Documento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<DocumentType>(
              decoration: const InputDecoration(
                labelText: 'Tipo de Documento',
                border: OutlineInputBorder(),
              ),
              items: DocumentType.values.map((type) => DropdownMenuItem(
                value: type,
                child: Text(_getDocumentTypeLabel(type)),
              )).toList(),
              onChanged: (value) {
                if (value != null) {
                  // TODO: Implementar upload de arquivo
                  final document = ClinicDocument(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _getDocumentTypeLabel(value),
                    type: value,
                    status: DocumentStatus.pending,
                    uploadDate: DateTime.now(),
                    expiryDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  
                  setState(() {
                    _documents.add(document);
                  });
                  
                  Navigator.pop(context);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Documento adicionado! Upload será implementado em breve.'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveClinic() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular salvamento
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.clinic != null 
                  ? 'Clínica atualizada com sucesso!' 
                  : 'Clínica criada com sucesso!',
            ),
            backgroundColor: AppConstants.successColor,
          ),
        );
        
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar: $e'),
            backgroundColor: AppConstants.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
} 