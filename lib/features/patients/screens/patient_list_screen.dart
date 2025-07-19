import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/patient_model.dart';
import 'patient_detail_screen.dart';
import 'patient_form_screen.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<PatientModel> _patients = [];
  List<PatientModel> _filteredPatients = [];
  String _searchQuery = '';
  PatientStatus _selectedStatus = PatientStatus.all;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    setState(() {
      _isLoading = true;
    });

    // Simular carregamento de dados
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _patients = _getMockPatients();
      _filteredPatients = _patients;
      _isLoading = false;
    });
  }

  List<PatientModel> _getMockPatients() {
    return [
      PatientModel(
        id: '1',
        name: 'João Silva Santos',
        cpf: '123.456.789-00',
        rg: '12.345.678-9',
        birthDate: DateTime(1985, 5, 15),
        gender: Gender.male,
        phone: '(11) 99999-9999',
        email: 'joao.silva@email.com',
        address: 'Rua das Flores, 123 - Centro',
        city: 'São Paulo',
        state: 'SP',
        emergencyContact: 'Maria Silva',
        emergencyPhone: '(11) 88888-8888',
        emergencyRelationship: 'Esposa',
        status: PatientStatus.active,
        asaClassification: ASAClassification.asa2,
        riskLevel: RiskLevel.low,
        evaluationStatus: EvaluationStatus.completed,
        evaluationDate: DateTime.now().subtract(const Duration(days: 5)),
        nextEvaluationDate: DateTime.now().add(const Duration(days: 30)),
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      PatientModel(
        id: '2',
        name: 'Maria Oliveira Costa',
        cpf: '987.654.321-00',
        rg: '98.765.432-1',
        birthDate: DateTime(1978, 12, 3),
        gender: Gender.female,
        phone: '(21) 77777-7777',
        email: 'maria.oliveira@email.com',
        address: 'Av. Principal, 456 - Jardins',
        city: 'Rio de Janeiro',
        state: 'RJ',
        emergencyContact: 'Carlos Costa',
        emergencyPhone: '(21) 66666-6666',
        emergencyRelationship: 'Marido',
        status: PatientStatus.active,
        asaClassification: ASAClassification.asa3,
        riskLevel: RiskLevel.medium,
        evaluationStatus: EvaluationStatus.pending,
        evaluationDate: null,
        nextEvaluationDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      PatientModel(
        id: '3',
        name: 'Pedro Santos Lima',
        cpf: '555.444.333-22',
        rg: '55.444.333-2',
        birthDate: DateTime(1992, 8, 20),
        gender: Gender.male,
        phone: '(31) 55555-5555',
        email: 'pedro.santos@email.com',
        address: 'Rua da Tecnologia, 789 - Vila Nova',
        city: 'Belo Horizonte',
        state: 'MG',
        emergencyContact: 'Ana Lima',
        emergencyPhone: '(31) 44444-4444',
        emergencyRelationship: 'Mãe',
        status: PatientStatus.inactive,
        asaClassification: ASAClassification.asa1,
        riskLevel: RiskLevel.low,
        evaluationStatus: EvaluationStatus.completed,
        evaluationDate: DateTime.now().subtract(const Duration(days: 60)),
        nextEvaluationDate: DateTime.now().add(const Duration(days: 300)),
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
        updatedAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
    ];
  }

  void _filterPatients() {
    setState(() {
      _filteredPatients = _patients.where((patient) {
        final matchesSearch = patient.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            patient.cpf.contains(_searchQuery) ||
            patient.email.toLowerCase().contains(_searchQuery.toLowerCase());
        
        final matchesStatus = _selectedStatus == PatientStatus.all || patient.status == _selectedStatus;
        
        return matchesSearch && matchesStatus;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Pacientes'),
        backgroundColor: AppConstants.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPatients,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros e busca
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Barra de busca
                TextField(
                  onChanged: (value) {
                    _searchQuery = value;
                    _filterPatients();
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar pacientes...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                
                const SizedBox(height: AppConstants.paddingMedium),
                
                // Filtros de status
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildStatusFilter('Todos', PatientStatus.all),
                      const SizedBox(width: AppConstants.paddingSmall),
                      _buildStatusFilter('Ativos', PatientStatus.active),
                      const SizedBox(width: AppConstants.paddingSmall),
                      _buildStatusFilter('Inativos', PatientStatus.inactive),
                      const SizedBox(width: AppConstants.paddingSmall),
                      _buildStatusFilter('Pendentes', PatientStatus.pending),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Estatísticas rápidas
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            color: Colors.grey[50],
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total',
                    _patients.length.toString(),
                    Icons.people,
                    AppConstants.primaryColor,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingSmall),
                Expanded(
                  child: _buildStatCard(
                    'Ativos',
                    _patients.where((p) => p.status == PatientStatus.active).length.toString(),
                    Icons.check_circle,
                    AppConstants.successColor,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingSmall),
                Expanded(
                  child: _buildStatCard(
                    'Pendentes',
                    _patients.where((p) => p.evaluationStatus == EvaluationStatus.pending).length.toString(),
                    Icons.pending,
                    AppConstants.warningColor,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingSmall),
                Expanded(
                  child: _buildStatCard(
                    'Alto Risco',
                    _patients.where((p) => p.riskLevel == RiskLevel.high).length.toString(),
                    Icons.warning,
                    AppConstants.errorColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Lista de pacientes
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredPatients.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.all(AppConstants.paddingMedium),
                        itemCount: _filteredPatients.length,
                        itemBuilder: (context, index) {
                          final patient = _filteredPatients[index];
                          return _buildPatientCard(patient);
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToPatientForm(),
        backgroundColor: AppConstants.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatusFilter(String label, PatientStatus status) {
    final isSelected = _selectedStatus == status;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = status;
          _filterPatients();
        });
      },
      selectedColor: AppConstants.primaryColor.withOpacity(0.2),
      checkmarkColor: AppConstants.primaryColor,
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppConstants.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientCard(PatientModel patient) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: InkWell(
        onTap: () => _navigateToPatientDetail(patient),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _getGenderColor(patient.gender),
                    child: Icon(
                      _getGenderIcon(patient.gender),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'CPF: ${patient.cpf}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppConstants.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildStatusChip(patient.status),
                      const SizedBox(height: AppConstants.paddingSmall),
                      _buildASAChip(patient.asaClassification),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingMedium),
              
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppConstants.textSecondaryColor,
                  ),
                  const SizedBox(width: AppConstants.paddingSmall),
                  Text(
                    'Nascimento: ${_formatDate(patient.birthDate)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    'Idade: ${_calculateAge(patient.birthDate)} anos',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingSmall),
              
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 16,
                    color: AppConstants.textSecondaryColor,
                  ),
                  const SizedBox(width: AppConstants.paddingSmall),
                  Expanded(
                    child: Text(
                      patient.phone,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingMedium),
              
              // Status da avaliação
              Row(
                children: [
                  Icon(
                    Icons.medical_services,
                    size: 16,
                    color: AppConstants.textSecondaryColor,
                  ),
                  const SizedBox(width: AppConstants.paddingSmall),
                  Text(
                    'Avaliação: ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppConstants.textSecondaryColor,
                    ),
                  ),
                  _buildEvaluationStatusChip(patient.evaluationStatus),
                  const Spacer(),
                  if (patient.evaluationDate != null)
                    Text(
                      'Última: ${_formatDate(patient.evaluationDate!)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppConstants.textSecondaryColor,
                      ),
                    ),
                ],
              ),
              
              if (patient.evaluationStatus == EvaluationStatus.pending) ...[
                const SizedBox(height: AppConstants.paddingSmall),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingSmall,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.warningColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                  ),
                  child: Text(
                    'Avaliação pendente - ${_formatDate(patient.nextEvaluationDate)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppConstants.warningColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
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
        horizontal: AppConstants.paddingSmall,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
        horizontal: AppConstants.paddingSmall,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
        horizontal: AppConstants.paddingSmall,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: AppConstants.textSecondaryColor,
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Text(
            'Nenhum paciente encontrado',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppConstants.textSecondaryColor,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            'Tente ajustar os filtros ou adicione um novo paciente',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppConstants.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          ElevatedButton.icon(
            onPressed: _navigateToPatientForm,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar Paciente'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _getGenderColor(Gender gender) {
    switch (gender) {
      case Gender.male:
        return Colors.blue;
      case Gender.female:
        return Colors.pink;
      case Gender.other:
        return Colors.grey;
    }
  }

  IconData _getGenderIcon(Gender gender) {
    switch (gender) {
      case Gender.male:
        return Icons.male;
      case Gender.female:
        return Icons.female;
      case Gender.other:
        return Icons.person;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void _navigateToPatientDetail(PatientModel patient) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PatientDetailScreen(patient: patient),
      ),
    );
  }

  void _navigateToPatientForm() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PatientFormScreen(),
      ),
    );
  }
} 