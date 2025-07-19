import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/clinic_model.dart';
import 'clinic_detail_screen.dart';
import 'clinic_form_screen.dart';

class ClinicManagementScreen extends StatefulWidget {
  const ClinicManagementScreen({super.key});

  @override
  State<ClinicManagementScreen> createState() => _ClinicManagementScreenState();
}

class _ClinicManagementScreenState extends State<ClinicManagementScreen> {
  List<ClinicModel> _clinics = [];
  List<ClinicModel> _filteredClinics = [];
  String _searchQuery = '';
  ClinicStatus _selectedStatus = ClinicStatus.all;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadClinics();
  }

  Future<void> _loadClinics() async {
    setState(() {
      _isLoading = true;
    });

    // Simular carregamento de dados
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _clinics = _getMockClinics();
      _filteredClinics = _clinics;
      _isLoading = false;
    });
  }

  List<ClinicModel> _getMockClinics() {
    return [
      ClinicModel(
        id: '1',
        name: 'Clínica São Lucas',
        cnpj: '12.345.678/0001-90',
        address: 'Rua das Flores, 123 - Centro',
        city: 'São Paulo',
        state: 'SP',
        phone: '(11) 99999-9999',
        email: 'contato@saolucas.com.br',
        responsibleName: 'Dr. João Silva',
        responsibleCrm: 'CRM-SP 12345',
        status: ClinicStatus.approved,
        authorizedProcedures: ['Sedação Consciente', 'Procedimentos Odontológicos'],
        documents: [
          ClinicDocument(
            id: '1',
            name: 'Alvará Sanitário',
            type: DocumentType.healthLicense,
            status: DocumentStatus.approved,
            uploadDate: DateTime.now().subtract(const Duration(days: 30)),
            expiryDate: DateTime.now().add(const Duration(days: 335)),
          ),
          ClinicDocument(
            id: '2',
            name: 'Registro ANVISA',
            type: DocumentType.anvisaRegistration,
            status: DocumentStatus.pending,
            uploadDate: DateTime.now().subtract(const Duration(days: 15)),
            expiryDate: DateTime.now().add(const Duration(days: 350)),
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      ClinicModel(
        id: '2',
        name: 'Centro Médico Esperança',
        cnpj: '98.765.432/0001-10',
        address: 'Av. Principal, 456 - Jardins',
        city: 'Rio de Janeiro',
        state: 'RJ',
        phone: '(21) 88888-8888',
        email: 'contato@esperanca.com.br',
        responsibleName: 'Dra. Maria Santos',
        responsibleCrm: 'CRM-RJ 54321',
        status: ClinicStatus.pending,
        authorizedProcedures: ['Sedação Profunda', 'Procedimentos Cirúrgicos'],
        documents: [
          ClinicDocument(
            id: '3',
            name: 'Alvará Sanitário',
            type: DocumentType.healthLicense,
            status: DocumentStatus.pending,
            uploadDate: DateTime.now().subtract(const Duration(days: 10)),
            expiryDate: DateTime.now().add(const Duration(days: 355)),
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ClinicModel(
        id: '3',
        name: 'Instituto de Saúde Moderno',
        cnpj: '55.444.333/0001-22',
        address: 'Rua da Tecnologia, 789 - Vila Nova',
        city: 'Belo Horizonte',
        state: 'MG',
        phone: '(31) 77777-7777',
        email: 'contato@moderno.com.br',
        responsibleName: 'Dr. Carlos Oliveira',
        responsibleCrm: 'CRM-MG 98765',
        status: ClinicStatus.suspended,
        authorizedProcedures: ['Sedação Consciente'],
        documents: [
          ClinicDocument(
            id: '4',
            name: 'Alvará Sanitário',
            type: DocumentType.healthLicense,
            status: DocumentStatus.expired,
            uploadDate: DateTime.now().subtract(const Duration(days: 400)),
            expiryDate: DateTime.now().subtract(const Duration(days: 5)),
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  void _filterClinics() {
    setState(() {
      _filteredClinics = _clinics.where((clinic) {
        final matchesSearch = clinic.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            clinic.cnpj.contains(_searchQuery) ||
            clinic.city.toLowerCase().contains(_searchQuery.toLowerCase());
        
        final matchesStatus = _selectedStatus == ClinicStatus.all || clinic.status == _selectedStatus;
        
        return matchesSearch && matchesStatus;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Clínicas'),
        backgroundColor: AppConstants.secondaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadClinics,
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
                    _filterClinics();
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar clínicas...',
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
                      _buildStatusFilter('Todas', ClinicStatus.all),
                      const SizedBox(width: AppConstants.paddingSmall),
                      _buildStatusFilter('Aprovadas', ClinicStatus.approved),
                      const SizedBox(width: AppConstants.paddingSmall),
                      _buildStatusFilter('Pendentes', ClinicStatus.pending),
                      const SizedBox(width: AppConstants.paddingSmall),
                      _buildStatusFilter('Suspensas', ClinicStatus.suspended),
                      const SizedBox(width: AppConstants.paddingSmall),
                      _buildStatusFilter('Rejeitadas', ClinicStatus.rejected),
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
                    _clinics.length.toString(),
                    Icons.local_hospital,
                    AppConstants.secondaryColor,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingSmall),
                Expanded(
                  child: _buildStatCard(
                    'Aprovadas',
                    _clinics.where((c) => c.status == ClinicStatus.approved).length.toString(),
                    Icons.check_circle,
                    AppConstants.successColor,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingSmall),
                Expanded(
                  child: _buildStatCard(
                    'Pendentes',
                    _clinics.where((c) => c.status == ClinicStatus.pending).length.toString(),
                    Icons.pending,
                    AppConstants.warningColor,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingSmall),
                Expanded(
                  child: _buildStatCard(
                    'Suspensas',
                    _clinics.where((c) => c.status == ClinicStatus.suspended).length.toString(),
                    Icons.block,
                    AppConstants.errorColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Lista de clínicas
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredClinics.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.all(AppConstants.paddingMedium),
                        itemCount: _filteredClinics.length,
                        itemBuilder: (context, index) {
                          final clinic = _filteredClinics[index];
                          return _buildClinicCard(clinic);
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToClinicForm(),
        backgroundColor: AppConstants.secondaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatusFilter(String label, ClinicStatus status) {
    final isSelected = _selectedStatus == status;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = status;
          _filterClinics();
        });
      },
      selectedColor: AppConstants.secondaryColor.withOpacity(0.2),
      checkmarkColor: AppConstants.secondaryColor,
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

  Widget _buildClinicCard(ClinicModel clinic) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: InkWell(
        onTap: () => _navigateToClinicDetail(clinic),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clinic.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppConstants.paddingSmall),
                        Text(
                          clinic.cnpj,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppConstants.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(clinic.status),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingMedium),
              
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppConstants.textSecondaryColor,
                  ),
                  const SizedBox(width: AppConstants.paddingSmall),
                  Expanded(
                    child: Text(
                      '${clinic.city}, ${clinic.state}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingSmall),
              
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 16,
                    color: AppConstants.textSecondaryColor,
                  ),
                  const SizedBox(width: AppConstants.paddingSmall),
                  Expanded(
                    child: Text(
                      clinic.responsibleName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingMedium),
              
              // Documentos
              Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 16,
                    color: AppConstants.textSecondaryColor,
                  ),
                  const SizedBox(width: AppConstants.paddingSmall),
                  Text(
                    '${clinic.documents.length} documentos',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppConstants.textSecondaryColor,
                    ),
                  ),
                  const Spacer(),
                  if (clinic.documents.any((doc) => doc.status == DocumentStatus.expired))
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingSmall,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                      ),
                      child: Text(
                        'Documento vencido',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppConstants.errorColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(ClinicStatus status) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case ClinicStatus.approved:
        color = AppConstants.successColor;
        label = 'Aprovada';
        icon = Icons.check_circle;
        break;
      case ClinicStatus.pending:
        color = AppConstants.warningColor;
        label = 'Pendente';
        icon = Icons.pending;
        break;
      case ClinicStatus.suspended:
        color = AppConstants.errorColor;
        label = 'Suspensa';
        icon = Icons.block;
        break;
      case ClinicStatus.rejected:
        color = AppConstants.errorColor;
        label = 'Rejeitada';
        icon = Icons.cancel;
        break;
      case ClinicStatus.all:
        color = AppConstants.textSecondaryColor;
        label = 'Todas';
        icon = Icons.all_inclusive;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingSmall,
        vertical: 4,
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
            Icons.local_hospital_outlined,
            size: 64,
            color: AppConstants.textSecondaryColor,
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Text(
            'Nenhuma clínica encontrada',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppConstants.textSecondaryColor,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            'Tente ajustar os filtros ou adicione uma nova clínica',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppConstants.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          ElevatedButton.icon(
            onPressed: _navigateToClinicForm,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar Clínica'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.secondaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToClinicDetail(ClinicModel clinic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ClinicDetailScreen(clinic: clinic),
      ),
    );
  }

  void _navigateToClinicForm() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ClinicFormScreen(),
      ),
    );
  }
} 