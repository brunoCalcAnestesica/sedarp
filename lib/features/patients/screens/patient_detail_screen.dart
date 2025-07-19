import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/patient_model.dart';
import 'patient_form_screen.dart';

class PatientDetailScreen extends StatefulWidget {
  final PatientModel patient;

  const PatientDetailScreen({
    super.key,
    required this.patient,
  });

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient.name),
        backgroundColor: AppConstants.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PatientFormScreen(patient: widget.patient),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptionsMenu(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Dados Pessoais'),
            Tab(text: 'Avaliação Pré-anestésica'),
            Tab(text: 'Exames'),
            Tab(text: 'Histórico'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPersonalDataTab(),
          _buildPreAnestheticEvaluationTab(),
          _buildExamsTab(),
          _buildHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildPersonalDataTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status e classificação
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                children: [
                  _buildStatusChip(widget.patient.status),
                  const SizedBox(width: AppConstants.paddingMedium),
                  _buildASAChip(widget.patient.asaClassification),
                  const Spacer(),
                  _buildRiskLevelChip(widget.patient.riskLevel),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Informações básicas
          _buildInfoSection(
            'Informações Básicas',
            [
              _buildInfoRow('Nome', widget.patient.name),
              _buildInfoRow('CPF', widget.patient.cpf),
              _buildInfoRow('RG', widget.patient.rg),
              _buildInfoRow('Data de Nascimento', _formatDate(widget.patient.birthDate)),
              _buildInfoRow('Idade', '${_calculateAge(widget.patient.birthDate)} anos'),
              _buildInfoRow('Gênero', _getGenderLabel(widget.patient.gender)),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Contato
          _buildInfoSection(
            'Contato',
            [
              _buildInfoRow('Telefone', widget.patient.phone),
              _buildInfoRow('E-mail', widget.patient.email),
              _buildInfoRow('Endereço', widget.patient.address),
              _buildInfoRow('Cidade/Estado', '${widget.patient.city}, ${widget.patient.state}'),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Contato de emergência
          _buildInfoSection(
            'Contato de Emergência',
            [
              _buildInfoRow('Nome', widget.patient.emergencyContact),
              _buildInfoRow('Telefone', widget.patient.emergencyPhone),
              _buildInfoRow('Relacionamento', widget.patient.emergencyRelationship),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Datas
          _buildInfoSection(
            'Datas',
            [
              _buildInfoRow('Cadastrado em', _formatDate(widget.patient.createdAt)),
              if (widget.patient.updatedAt != null)
                _buildInfoRow('Atualizado em', _formatDate(widget.patient.updatedAt!)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreAnestheticEvaluationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status da avaliação
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status da Avaliação Pré-anestésica',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  Row(
                    children: [
                      _buildEvaluationStatusChip(widget.patient.evaluationStatus),
                      const Spacer(),
                      if (widget.patient.evaluationDate != null)
                        Text(
                          'Avaliado em: ${_formatDate(widget.patient.evaluationDate!)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  Text(
                    'Próxima avaliação: ${_formatDate(widget.patient.nextEvaluationDate)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: widget.patient.nextEvaluationDate.isBefore(DateTime.now())
                          ? AppConstants.errorColor
                          : AppConstants.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Dados antropométricos
          if (widget.patient.weight != null || widget.patient.height != null)
            _buildInfoSection(
              'Dados Antropométricos',
              [
                if (widget.patient.weight != null)
                  _buildInfoRow('Peso', '${widget.patient.weight} kg'),
                if (widget.patient.height != null)
                  _buildInfoRow('Altura', '${widget.patient.height} cm'),
                if (widget.patient.bmi != null)
                  _buildInfoRow('IMC', widget.patient.bmi!),
                if (widget.patient.bloodType != null)
                  _buildInfoRow('Tipo Sanguíneo', widget.patient.bloodType!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Alergias
          if (widget.patient.allergies != null && widget.patient.allergies!.isNotEmpty)
            _buildInfoSection(
              'Alergias',
              [
                _buildInfoRow('Alergias', widget.patient.allergies!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Medicamentos atuais
          if (widget.patient.currentMedications != null && widget.patient.currentMedications!.isNotEmpty)
            _buildInfoSection(
              'Medicamentos Atuais',
              [
                _buildInfoRow('Medicamentos', widget.patient.currentMedications!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Histórico médico
          if (widget.patient.medicalHistory != null && widget.patient.medicalHistory!.isNotEmpty)
            _buildInfoSection(
              'Histórico Médico',
              [
                _buildInfoRow('Histórico', widget.patient.medicalHistory!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Histórico cirúrgico
          if (widget.patient.surgicalHistory != null && widget.patient.surgicalHistory!.isNotEmpty)
            _buildInfoSection(
              'Histórico Cirúrgico',
              [
                _buildInfoRow('Cirurgias', widget.patient.surgicalHistory!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Histórico familiar
          if (widget.patient.familyHistory != null && widget.patient.familyHistory!.isNotEmpty)
            _buildInfoSection(
              'Histórico Familiar',
              [
                _buildInfoRow('Familiar', widget.patient.familyHistory!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Histórico social
          if (widget.patient.socialHistory != null && widget.patient.socialHistory!.isNotEmpty)
            _buildInfoSection(
              'Histórico Social',
              [
                _buildInfoRow('Social', widget.patient.socialHistory!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Exame físico
          if (widget.patient.physicalExam != null && widget.patient.physicalExam!.isNotEmpty)
            _buildInfoSection(
              'Exame Físico',
              [
                _buildInfoRow('Exame', widget.patient.physicalExam!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Observações do anestesiologista
          if (widget.patient.anesthesiologistNotes != null && widget.patient.anesthesiologistNotes!.isNotEmpty)
            _buildInfoSection(
              'Observações do Anestesiologista',
              [
                _buildInfoRow('Observações', widget.patient.anesthesiologistNotes!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Recomendações
          if (widget.patient.recommendations != null && widget.patient.recommendations!.isNotEmpty)
            _buildInfoSection(
              'Recomendações',
              [
                _buildInfoRow('Recomendações', widget.patient.recommendations!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Instruções especiais
          if (widget.patient.specialInstructions != null && widget.patient.specialInstructions!.isNotEmpty)
            _buildInfoSection(
              'Instruções Especiais',
              [
                _buildInfoRow('Instruções', widget.patient.specialInstructions!),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildExamsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exames laboratoriais
          if (widget.patient.labResults != null && widget.patient.labResults!.isNotEmpty)
            _buildInfoSection(
              'Exames Laboratoriais',
              [
                _buildInfoRow('Resultados', widget.patient.labResults!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // ECG
          if (widget.patient.ecgResults != null && widget.patient.ecgResults!.isNotEmpty)
            _buildInfoSection(
              'Eletrocardiograma (ECG)',
              [
                _buildInfoRow('Resultado', widget.patient.ecgResults!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Raio-X de tórax
          if (widget.patient.chestXrayResults != null && widget.patient.chestXrayResults!.isNotEmpty)
            _buildInfoSection(
              'Raio-X de Tórax',
              [
                _buildInfoRow('Resultado', widget.patient.chestXrayResults!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Exames adicionais
          if (widget.patient.additionalExams != null && widget.patient.additionalExams!.isNotEmpty)
            _buildInfoSection(
              'Exames Adicionais',
              [
                _buildInfoRow('Exames', widget.patient.additionalExams!),
              ],
            ),
          
          if (widget.patient.labResults == null && 
              widget.patient.ecgResults == null && 
              widget.patient.chestXrayResults == null && 
              widget.patient.additionalExams == null) {
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: Column(
                  children: [
                    Icon(
                      Icons.medical_services_outlined,
                      size: 64,
                      color: AppConstants.textSecondaryColor,
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),
                    Text(
                      'Nenhum exame registrado',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppConstants.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingSmall),
                    Text(
                      'Adicione resultados de exames para este paciente',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppConstants.textSecondaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          }
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status de jejum
          if (widget.patient.fastingStatus != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status de Jejum',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),
                    Row(
                      children: [
                        Icon(
                          widget.patient.fastingStatus! ? Icons.check_circle : Icons.cancel,
                          color: widget.patient.fastingStatus! ? AppConstants.successColor : AppConstants.errorColor,
                        ),
                        const SizedBox(width: AppConstants.paddingSmall),
                        Text(
                          widget.patient.fastingStatus! ? 'Em jejum' : 'Não está em jejum',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    if (widget.patient.lastMealTime != null) ...[
                      const SizedBox(height: AppConstants.paddingSmall),
                      Text(
                        'Última refeição: ${_formatDateTime(widget.patient.lastMealTime!)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Histórico de avaliações
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Histórico de Avaliações',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  _buildHistoryItem(
                    'Cadastro inicial',
                    _formatDateTime(widget.patient.createdAt),
                    Icons.person_add,
                    AppConstants.primaryColor,
                  ),
                  if (widget.patient.evaluationDate != null)
                    _buildHistoryItem(
                      'Avaliação pré-anestésica',
                      _formatDateTime(widget.patient.evaluationDate!),
                      Icons.medical_services,
                      AppConstants.successColor,
                    ),
                  if (widget.patient.updatedAt != null)
                    _buildHistoryItem(
                      'Atualização de dados',
                      _formatDateTime(widget.patient.updatedAt!),
                      Icons.edit,
                      AppConstants.infoColor,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppConstants.textSecondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String date, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppConstants.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(PatientStatus status) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case PatientStatus.active:
        color = AppConstants.successColor;
        label = 'Ativo';
        icon = Icons.check_circle;
        break;
      case PatientStatus.inactive:
        color = AppConstants.textSecondaryColor;
        label = 'Inativo';
        icon = Icons.cancel;
        break;
      case PatientStatus.pending:
        color = AppConstants.warningColor;
        label = 'Pendente';
        icon = Icons.pending;
        break;
      case PatientStatus.all:
        color = AppConstants.textSecondaryColor;
        label = 'Todos';
        icon = Icons.all_inclusive;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: AppConstants.paddingSmall),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildASAChip(ASAClassification asa) {
    Color color;
    String label;

    switch (asa) {
      case ASAClassification.asa1:
        color = AppConstants.successColor;
        label = 'ASA I';
        break;
      case ASAClassification.asa2:
        color = AppConstants.infoColor;
        label = 'ASA II';
        break;
      case ASAClassification.asa3:
        color = AppConstants.warningColor;
        label = 'ASA III';
        break;
      case ASAClassification.asa4:
        color = AppConstants.errorColor;
        label = 'ASA IV';
        break;
      case ASAClassification.asa5:
        color = AppConstants.errorColor;
        label = 'ASA V';
        break;
      case ASAClassification.asa6:
        color = Colors.black;
        label = 'ASA VI';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildRiskLevelChip(RiskLevel risk) {
    Color color;
    String label;

    switch (risk) {
      case RiskLevel.low:
        color = AppConstants.successColor;
        label = 'Baixo Risco';
        break;
      case RiskLevel.medium:
        color = AppConstants.warningColor;
        label = 'Médio Risco';
        break;
      case RiskLevel.high:
        color = AppConstants.errorColor;
        label = 'Alto Risco';
        break;
      case RiskLevel.critical:
        color = Colors.black;
        label = 'Risco Crítico';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEvaluationStatusChip(EvaluationStatus status) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case EvaluationStatus.completed:
        color = AppConstants.successColor;
        label = 'Concluída';
        icon = Icons.check_circle;
        break;
      case EvaluationStatus.pending:
        color = AppConstants.warningColor;
        label = 'Pendente';
        icon = Icons.pending;
        break;
      case EvaluationStatus.inProgress:
        color = AppConstants.infoColor;
        label = 'Em Andamento';
        icon = Icons.schedule;
        break;
      case EvaluationStatus.expired:
        color = AppConstants.errorColor;
        label = 'Expirada';
        icon = Icons.warning;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: AppConstants.paddingSmall),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
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

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatDateTime(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} às ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar Paciente'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PatientFormScreen(patient: widget.patient),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Nova Avaliação'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementar nova avaliação
              },
            ),
            ListTile(
              leading: const Icon(Icons.print),
              title: const Text('Imprimir Ficha'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementar impressão
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Excluir Paciente', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementar exclusão
              },
            ),
          ],
        ),
      ),
    );
  }
} 