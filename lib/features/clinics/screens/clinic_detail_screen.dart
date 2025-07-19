import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/clinic_model.dart';

class ClinicDetailScreen extends StatefulWidget {
  final ClinicModel clinic;

  const ClinicDetailScreen({
    super.key,
    required this.clinic,
  });

  @override
  State<ClinicDetailScreen> createState() => _ClinicDetailScreenState();
}

class _ClinicDetailScreenState extends State<ClinicDetailScreen>
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
        title: Text(widget.clinic.name),
        backgroundColor: AppConstants.secondaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implementar edição
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edição será implementada em breve!')),
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
            Tab(text: 'Informações'),
            Tab(text: 'Documentos'),
            Tab(text: 'Procedimentos'),
            Tab(text: 'Equipamentos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInfoTab(),
          _buildDocumentsTab(),
          _buildProceduresTab(),
          _buildEquipmentTab(),
        ],
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status da clínica
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                children: [
                  _buildStatusChip(widget.clinic.status),
                  const Spacer(),
                  Text(
                    'ID: ${widget.clinic.id}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppConstants.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Informações básicas
          _buildInfoSection(
            'Informações Básicas',
            [
              _buildInfoRow('Nome', widget.clinic.name),
              _buildInfoRow('CNPJ', widget.clinic.cnpj),
              _buildInfoRow('CNAE', widget.clinic.cnae),
              _buildInfoRow('Endereço', widget.clinic.address),
              _buildInfoRow('Cidade/Estado', '${widget.clinic.city}, ${widget.clinic.state}'),
              _buildInfoRow('Telefone', widget.clinic.phone),
              _buildInfoRow('E-mail', widget.clinic.email),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Responsável técnico
          _buildInfoSection(
            'Responsável Técnico',
            [
              _buildInfoRow('Nome', widget.clinic.responsibleName),
              _buildInfoRow('CPF', widget.clinic.responsibleCpf),
              _buildInfoRow('CRM', widget.clinic.responsibleCrm),
              _buildInfoRow('RQE', widget.clinic.responsibleRqe),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Hospital de retaguarda
          if (widget.clinic.backupHospitalName != null)
            _buildInfoSection(
              'Hospital de Retaguarda',
              [
                _buildInfoRow('Nome', widget.clinic.backupHospitalName!),
                if (widget.clinic.backupHospitalAddress != null)
                  _buildInfoRow('Endereço', widget.clinic.backupHospitalAddress!),
                if (widget.clinic.backupHospitalPhone != null)
                  _buildInfoRow('Telefone', widget.clinic.backupHospitalPhone!),
              ],
            ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Datas
          _buildInfoSection(
            'Datas',
            [
              _buildInfoRow('Criada em', _formatDate(widget.clinic.createdAt)),
              if (widget.clinic.lastUpdated != null)
                _buildInfoRow('Última atualização', _formatDate(widget.clinic.lastUpdated!)),
              if (widget.clinic.updatedAt != null)
                _buildInfoRow('Atualizada em', _formatDate(widget.clinic.updatedAt!)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resumo dos documentos
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumo dos Documentos',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDocumentStat(
                          'Total',
                          widget.clinic.documents.length.toString(),
                          Icons.description,
                          AppConstants.secondaryColor,
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingSmall),
                      Expanded(
                        child: _buildDocumentStat(
                          'Aprovados',
                          widget.clinic.documents
                              .where((doc) => doc.status == DocumentStatus.approved)
                              .length
                              .toString(),
                          Icons.check_circle,
                          AppConstants.successColor,
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingSmall),
                      Expanded(
                        child: _buildDocumentStat(
                          'Pendentes',
                          widget.clinic.documents
                              .where((doc) => doc.status == DocumentStatus.pending)
                              .length
                              .toString(),
                          Icons.pending,
                          AppConstants.warningColor,
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingSmall),
                      Expanded(
                        child: _buildDocumentStat(
                          'Vencidos',
                          widget.clinic.documents
                              .where((doc) => doc.status == DocumentStatus.expired)
                              .length
                              .toString(),
                          Icons.warning,
                          AppConstants.errorColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Lista de documentos
          if (widget.clinic.documents.isEmpty)
            _buildEmptyDocuments()
          else
            ...widget.clinic.documents.map((document) => _buildDocumentCard(document)),
        ],
      ),
    );
  }

  Widget _buildProceduresTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Procedimentos Autorizados',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  if (widget.clinic.authorizedProcedures.isEmpty)
                    const Text('Nenhum procedimento autorizado registrado.')
                  else
                    ...widget.clinic.authorizedProcedures.map((procedure) => 
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: AppConstants.successColor,
                              size: 16,
                            ),
                            const SizedBox(width: AppConstants.paddingSmall),
                            Expanded(child: Text(procedure)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Equipamentos',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  if (widget.clinic.equipment.isEmpty)
                    const Text('Nenhum equipamento registrado.')
                  else
                    ...widget.clinic.equipment.map((equipment) => 
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
                        child: Row(
                          children: [
                            Icon(
                              Icons.medical_services,
                              color: AppConstants.secondaryColor,
                              size: 16,
                            ),
                            const SizedBox(width: AppConstants.paddingSmall),
                            Expanded(child: Text(equipment)),
                          ],
                        ),
                      ),
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

  Widget _buildDocumentStat(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: AppConstants.paddingSmall),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
    );
  }

  Widget _buildDocumentCard(ClinicDocument document) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
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
                        document.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.paddingSmall),
                      Text(
                        _getDocumentTypeLabel(document.type),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppConstants.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildDocumentStatusChip(document.status),
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
                  'Upload: ${_formatDate(document.uploadDate)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Icon(
                  Icons.event,
                  size: 16,
                  color: AppConstants.textSecondaryColor,
                ),
                const SizedBox(width: AppConstants.paddingSmall),
                Text(
                  'Vencimento: ${_formatDate(document.expiryDate)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: document.expiryDate.isBefore(DateTime.now())
                        ? AppConstants.errorColor
                        : null,
                  ),
                ),
              ],
            ),
            
            if (document.notes != null) ...[
              const SizedBox(height: AppConstants.paddingMedium),
              Text(
                'Observações:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppConstants.paddingSmall),
              Text(
                document.notes!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            
            const SizedBox(height: AppConstants.paddingMedium),
            
            Row(
              children: [
                if (document.fileUrl != null)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Implementar visualização do arquivo
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Visualização será implementada em breve!')),
                        );
                      },
                      icon: const Icon(Icons.visibility),
                      label: const Text('Visualizar'),
                    ),
                  ),
                if (document.fileUrl != null && document.status != DocumentStatus.approved)
                  const SizedBox(width: AppConstants.paddingSmall),
                if (document.status != DocumentStatus.approved)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implementar aprovação
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Aprovação será implementada em breve!')),
                        );
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Aprovar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.successColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentStatusChip(DocumentStatus status) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case DocumentStatus.approved:
        color = AppConstants.successColor;
        label = 'Aprovado';
        icon = Icons.check_circle;
        break;
      case DocumentStatus.pending:
        color = AppConstants.warningColor;
        label = 'Pendente';
        icon = Icons.pending;
        break;
      case DocumentStatus.rejected:
        color = AppConstants.errorColor;
        label = 'Rejeitado';
        icon = Icons.cancel;
        break;
      case DocumentStatus.expired:
        color = AppConstants.errorColor;
        label = 'Vencido';
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

  Widget _buildEmptyDocuments() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          children: [
            Icon(
              Icons.description_outlined,
              size: 64,
              color: AppConstants.textSecondaryColor,
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Text(
              'Nenhum documento registrado',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppConstants.textSecondaryColor,
              ),
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              'Adicione documentos para esta clínica',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppConstants.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implementar upload de documentos
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Upload será implementado em breve!')),
                );
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Adicionar Documento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.secondaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
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
              title: const Text('Editar Clínica'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementar edição
              },
            ),
            ListTile(
              leading: const Icon(Icons.upload_file),
              title: const Text('Adicionar Documento'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementar upload
              },
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('Suspender Clínica'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementar suspensão
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Excluir Clínica', style: TextStyle(color: Colors.red)),
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