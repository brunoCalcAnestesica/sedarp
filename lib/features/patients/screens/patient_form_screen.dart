import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/patient_model.dart';

class PatientFormScreen extends StatefulWidget {
  final PatientModel? patient; // null para novo paciente

  const PatientFormScreen({
    super.key,
    this.patient,
  });

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _rgController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();
  final _emergencyRelationshipController = TextEditingController();
  
  // Avaliação pré-anestésica
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _currentMedicationsController = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  final _surgicalHistoryController = TextEditingController();
  final _familyHistoryController = TextEditingController();
  final _socialHistoryController = TextEditingController();
  final _physicalExamController = TextEditingController();
  final _labResultsController = TextEditingController();
  final _ecgResultsController = TextEditingController();
  final _chestXrayResultsController = TextEditingController();
  final _additionalExamsController = TextEditingController();
  final _anesthesiologistNotesController = TextEditingController();
  final _recommendationsController = TextEditingController();
  final _specialInstructionsController = TextEditingController();
  
  late TabController _tabController;
  DateTime? _selectedBirthDate;
  Gender _selectedGender = Gender.male;
  PatientStatus _selectedStatus = PatientStatus.active;
  ASAClassification _selectedASA = ASAClassification.asa1;
  RiskLevel _selectedRiskLevel = RiskLevel.low;
  EvaluationStatus _selectedEvaluationStatus = EvaluationStatus.pending;
  bool _isLoading = false;
  bool _showEvaluationTab = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    if (widget.patient != null) {
      _loadPatientData();
      _showEvaluationTab = true;
    }
  }

  void _loadPatientData() {
    final patient = widget.patient!;
    _nameController.text = patient.name;
    _cpfController.text = patient.cpf;
    _rgController.text = patient.rg;
    _phoneController.text = patient.phone;
    _emailController.text = patient.email;
    _addressController.text = patient.address;
    _cityController.text = patient.city;
    _stateController.text = patient.state;
    _emergencyContactController.text = patient.emergencyContact;
    _emergencyPhoneController.text = patient.emergencyPhone;
    _emergencyRelationshipController.text = patient.emergencyRelationship;
    
    _selectedBirthDate = patient.birthDate;
    _selectedGender = patient.gender;
    _selectedStatus = patient.status;
    _selectedASA = patient.asaClassification;
    _selectedRiskLevel = patient.riskLevel;
    _selectedEvaluationStatus = patient.evaluationStatus;
    
    // Dados da avaliação
    _weightController.text = patient.weight ?? '';
    _heightController.text = patient.height ?? '';
    _bloodTypeController.text = patient.bloodType ?? '';
    _allergiesController.text = patient.allergies ?? '';
    _currentMedicationsController.text = patient.currentMedications ?? '';
    _medicalHistoryController.text = patient.medicalHistory ?? '';
    _surgicalHistoryController.text = patient.surgicalHistory ?? '';
    _familyHistoryController.text = patient.familyHistory ?? '';
    _socialHistoryController.text = patient.socialHistory ?? '';
    _physicalExamController.text = patient.physicalExam ?? '';
    _labResultsController.text = patient.labResults ?? '';
    _ecgResultsController.text = patient.ecgResults ?? '';
    _chestXrayResultsController.text = patient.chestXrayResults ?? '';
    _additionalExamsController.text = patient.additionalExams ?? '';
    _anesthesiologistNotesController.text = patient.anesthesiologistNotes ?? '';
    _recommendationsController.text = patient.recommendations ?? '';
    _specialInstructionsController.text = patient.specialInstructions ?? '';
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _cpfController.dispose();
    _rgController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _emergencyContactController.dispose();
    _emergencyPhoneController.dispose();
    _emergencyRelationshipController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _bloodTypeController.dispose();
    _allergiesController.dispose();
    _currentMedicationsController.dispose();
    _medicalHistoryController.dispose();
    _surgicalHistoryController.dispose();
    _familyHistoryController.dispose();
    _socialHistoryController.dispose();
    _physicalExamController.dispose();
    _labResultsController.dispose();
    _ecgResultsController.dispose();
    _chestXrayResultsController.dispose();
    _additionalExamsController.dispose();
    _anesthesiologistNotesController.dispose();
    _recommendationsController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient != null ? 'Editar Paciente' : 'Novo Paciente'),
        backgroundColor: AppConstants.primaryColor,
        actions: [
          if (!_isLoading)
            TextButton(
              onPressed: _savePatient,
              child: const Text(
                'Salvar',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(text: 'Dados Pessoais'),
            const Tab(text: 'Contato'),
            if (_showEvaluationTab) const Tab(text: 'Avaliação Pré-anestésica'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPersonalDataTab(),
                  _buildContactTab(),
                  if (_showEvaluationTab) _buildEvaluationTab(),
                ],
              ),
            ),
    );
  }

  Widget _buildPersonalDataTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Informações Básicas',
            [
              _buildTextField(
                controller: _nameController,
                label: 'Nome Completo',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _cpfController,
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
                controller: _rgController,
                label: 'RG',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'RG é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildDateField(),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildGenderField(),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildStatusField(),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          if (widget.patient != null)
            _buildSection(
              'Classificação',
              [
                _buildASAField(),
                const SizedBox(height: AppConstants.paddingMedium),
                _buildRiskLevelField(),
                const SizedBox(height: AppConstants.paddingMedium),
                _buildEvaluationStatusField(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Contato',
            [
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
              const SizedBox(height: AppConstants.paddingMedium),
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
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          _buildSection(
            'Contato de Emergência',
            [
              _buildTextField(
                controller: _emergencyContactController,
                label: 'Nome do Contato',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome do contato é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _emergencyPhoneController,
                label: 'Telefone do Contato',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telefone do contato é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _emergencyRelationshipController,
                label: 'Relacionamento',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Relacionamento é obrigatório';
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEvaluationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Dados Antropométricos',
            [
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _weightController,
                      label: 'Peso (kg)',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  Expanded(
                    child: _buildTextField(
                      controller: _heightController,
                      label: 'Altura (cm)',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _bloodTypeController,
                label: 'Tipo Sanguíneo',
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          _buildSection(
            'Histórico Médico',
            [
              _buildTextField(
                controller: _allergiesController,
                label: 'Alergias',
                maxLines: 3,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _currentMedicationsController,
                label: 'Medicamentos Atuais',
                maxLines: 3,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _medicalHistoryController,
                label: 'Histórico Médico',
                maxLines: 4,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _surgicalHistoryController,
                label: 'Histórico Cirúrgico',
                maxLines: 4,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _familyHistoryController,
                label: 'Histórico Familiar',
                maxLines: 3,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _socialHistoryController,
                label: 'Histórico Social',
                maxLines: 3,
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          _buildSection(
            'Exame Físico',
            [
              _buildTextField(
                controller: _physicalExamController,
                label: 'Exame Físico',
                maxLines: 4,
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          _buildSection(
            'Exames',
            [
              _buildTextField(
                controller: _labResultsController,
                label: 'Exames Laboratoriais',
                maxLines: 4,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _ecgResultsController,
                label: 'Eletrocardiograma (ECG)',
                maxLines: 3,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _chestXrayResultsController,
                label: 'Raio-X de Tórax',
                maxLines: 3,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _additionalExamsController,
                label: 'Exames Adicionais',
                maxLines: 3,
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          _buildSection(
            'Observações e Recomendações',
            [
              _buildTextField(
                controller: _anesthesiologistNotesController,
                label: 'Observações do Anestesiologista',
                maxLines: 4,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _recommendationsController,
                label: 'Recomendações',
                maxLines: 4,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              _buildTextField(
                controller: _specialInstructionsController,
                label: 'Instruções Especiais',
                maxLines: 3,
              ),
            ],
          ),
        ],
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
    int? maxLines,
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
      maxLines: maxLines ?? 1,
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _selectedBirthDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          setState(() {
            _selectedBirthDate = date;
          });
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Data de Nascimento',
          border: OutlineInputBorder(),
        ),
        child: Text(
          _selectedBirthDate != null
              ? '${_selectedBirthDate!.day.toString().padLeft(2, '0')}/${_selectedBirthDate!.month.toString().padLeft(2, '0')}/${_selectedBirthDate!.year}'
              : 'Selecione a data',
        ),
      ),
    );
  }

  Widget _buildGenderField() {
    return DropdownButtonFormField<Gender>(
      value: _selectedGender,
      decoration: const InputDecoration(
        labelText: 'Gênero',
        border: OutlineInputBorder(),
      ),
      items: Gender.values.map((gender) => DropdownMenuItem(
        value: gender,
        child: Text(_getGenderLabel(gender)),
      )).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value!;
        });
      },
    );
  }

  Widget _buildStatusField() {
    return DropdownButtonFormField<PatientStatus>(
      value: _selectedStatus,
      decoration: const InputDecoration(
        labelText: 'Status',
        border: OutlineInputBorder(),
      ),
      items: PatientStatus.values
          .where((status) => status != PatientStatus.all)
          .map((status) => DropdownMenuItem(
        value: status,
        child: Text(_getStatusLabel(status)),
      )).toList(),
      onChanged: (value) {
        setState(() {
          _selectedStatus = value!;
        });
      },
    );
  }

  Widget _buildASAField() {
    return DropdownButtonFormField<ASAClassification>(
      value: _selectedASA,
      decoration: const InputDecoration(
        labelText: 'Classificação ASA',
        border: OutlineInputBorder(),
      ),
      items: ASAClassification.values.map((asa) => DropdownMenuItem(
        value: asa,
        child: Text(_getASALabel(asa)),
      )).toList(),
      onChanged: (value) {
        setState(() {
          _selectedASA = value!;
        });
      },
    );
  }

  Widget _buildRiskLevelField() {
    return DropdownButtonFormField<RiskLevel>(
      value: _selectedRiskLevel,
      decoration: const InputDecoration(
        labelText: 'Nível de Risco',
        border: OutlineInputBorder(),
      ),
      items: RiskLevel.values.map((risk) => DropdownMenuItem(
        value: risk,
        child: Text(_getRiskLevelLabel(risk)),
      )).toList(),
      onChanged: (value) {
        setState(() {
          _selectedRiskLevel = value!;
        });
      },
    );
  }

  Widget _buildEvaluationStatusField() {
    return DropdownButtonFormField<EvaluationStatus>(
      value: _selectedEvaluationStatus,
      decoration: const InputDecoration(
        labelText: 'Status da Avaliação',
        border: OutlineInputBorder(),
      ),
      items: EvaluationStatus.values.map((status) => DropdownMenuItem(
        value: status,
        child: Text(_getEvaluationStatusLabel(status)),
      )).toList(),
      onChanged: (value) {
        setState(() {
          _selectedEvaluationStatus = value!;
        });
      },
    );
  }

  String _getGenderLabel(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'Masculino';
      case Gender.female:
        return 'Feminino';
      case Gender.other:
        return 'Outro';
    }
  }

  String _getStatusLabel(PatientStatus status) {
    switch (status) {
      case PatientStatus.active:
        return 'Ativo';
      case PatientStatus.inactive:
        return 'Inativo';
      case PatientStatus.pending:
        return 'Pendente';
      case PatientStatus.all:
        return 'Todos';
    }
  }

  String _getASALabel(ASAClassification asa) {
    switch (asa) {
      case ASAClassification.asa1:
        return 'ASA I - Paciente saudável';
      case ASAClassification.asa2:
        return 'ASA II - Doença sistêmica leve';
      case ASAClassification.asa3:
        return 'ASA III - Doença sistêmica grave';
      case ASAClassification.asa4:
        return 'ASA IV - Doença sistêmica grave com risco de vida';
      case ASAClassification.asa5:
        return 'ASA V - Paciente moribundo';
      case ASAClassification.asa6:
        return 'ASA VI - Paciente com morte cerebral';
    }
  }

  String _getRiskLevelLabel(RiskLevel risk) {
    switch (risk) {
      case RiskLevel.low:
        return 'Baixo Risco';
      case RiskLevel.medium:
        return 'Médio Risco';
      case RiskLevel.high:
        return 'Alto Risco';
      case RiskLevel.critical:
        return 'Risco Crítico';
    }
  }

  String _getEvaluationStatusLabel(EvaluationStatus status) {
    switch (status) {
      case EvaluationStatus.completed:
        return 'Concluída';
      case EvaluationStatus.pending:
        return 'Pendente';
      case EvaluationStatus.inProgress:
        return 'Em Andamento';
      case EvaluationStatus.expired:
        return 'Expirada';
    }
  }

  Future<void> _savePatient() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedBirthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data de nascimento é obrigatória'),
          backgroundColor: AppConstants.errorColor,
        ),
      );
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
              widget.patient != null 
                  ? 'Paciente atualizado com sucesso!' 
                  : 'Paciente criado com sucesso!',
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