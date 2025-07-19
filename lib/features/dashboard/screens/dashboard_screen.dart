import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/user_model.dart';

class DashboardScreen extends StatefulWidget {
  final UserRole userRole;
  final String userName;

  const DashboardScreen({
    super.key,
    required this.userRole,
    required this.userName,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getDashboardTitle()),
        backgroundColor: _getRoleColor(),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              _showNotifications();
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              _showProfile();
            },
          ),
        ],
      ),
      body: _buildDashboardContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _getRoleColor(),
        unselectedItemColor: AppConstants.textSecondaryColor,
        items: _getBottomNavItems(),
      ),
    );
  }

  String _getDashboardTitle() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return 'Dashboard da Clínica';
      case UserRole.anesthesiologist:
        return 'Dashboard do Anestesiologista';
      case UserRole.administrator:
        return 'Dashboard do Administrador';
    }
  }

  Color _getRoleColor() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return AppConstants.primaryColor;
      case UserRole.anesthesiologist:
        return AppConstants.accentColor;
      case UserRole.administrator:
        return AppConstants.secondaryColor;
    }
  }

  List<BottomNavigationBarItem> _getBottomNavItems() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pacientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: 'Estoque',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Relatórios',
          ),
        ];
      case UserRole.anesthesiologist:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Procedimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pacientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Relatórios',
          ),
        ];
      case UserRole.administrator:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Clínicas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Anestesiologistas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Relatórios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ];
    }
  }

  Widget _buildDashboardContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildMainDashboard();
      case 1:
        return _buildSecondTab();
      case 2:
        return _buildThirdTab();
      case 3:
        return _buildFourthTab();
      case 4:
        return _buildFifthTab();
      default:
        return _buildMainDashboard();
    }
  }

  Widget _buildMainDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Boas-vindas
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: _getRoleColor(),
                        child: Icon(
                          _getRoleIcon(),
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingMedium),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bem-vindo, ${widget.userName}!',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _getRoleDisplayName(),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppConstants.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  Text(
                    _getWelcomeMessage(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          // Estatísticas rápidas
          Text(
            'Estatísticas Rápidas',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          
          _buildStatisticsGrid(),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          // Ações rápidas
          Text(
            'Ações Rápidas',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          
          _buildQuickActions(),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          // Alertas e notificações
          _buildAlertsSection(),
        ],
      ),
    );
  }

  Widget _buildStatisticsGrid() {
    final stats = _getStatistics();
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.paddingMedium,
        mainAxisSpacing: AppConstants.paddingMedium,
        childAspectRatio: 1.5,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  stat['icon'],
                  size: 32,
                  color: stat['color'],
                ),
                const SizedBox(height: AppConstants.paddingSmall),
                Text(
                  stat['value'],
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: stat['color'],
                  ),
                ),
                Text(
                  stat['label'],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppConstants.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActions() {
    final actions = _getQuickActions();
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.paddingMedium,
        mainAxisSpacing: AppConstants.paddingMedium,
        childAspectRatio: 2.5,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return Card(
          child: InkWell(
            onTap: action['onTap'],
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                children: [
                  Icon(
                    action['icon'],
                    color: _getRoleColor(),
                  ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  Expanded(
                    child: Text(
                      action['label'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAlertsSection() {
    final alerts = _getAlerts();
    
    if (alerts.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alertas e Notificações',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        ...alerts.map((alert) => Card(
          color: alert['color'].withOpacity(0.1),
          child: ListTile(
            leading: Icon(
              alert['icon'],
              color: alert['color'],
            ),
            title: Text(
              alert['title'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: alert['color'],
              ),
            ),
            subtitle: Text(alert['message']),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // TODO: Implementar remoção de alerta
              },
            ),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildSecondTab() {
    return const Center(
      child: Text('Segunda aba será implementada'),
    );
  }

  Widget _buildThirdTab() {
    return const Center(
      child: Text('Terceira aba será implementada'),
    );
  }

  Widget _buildFourthTab() {
    return const Center(
      child: Text('Quarta aba será implementada'),
    );
  }

  Widget _buildFifthTab() {
    return const Center(
      child: Text('Quinta aba será implementada'),
    );
  }

  String _getRoleDisplayName() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return 'Clínica';
      case UserRole.anesthesiologist:
        return 'Anestesiologista';
      case UserRole.administrator:
        return 'Administrador/RT';
    }
  }

  IconData _getRoleIcon() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return Icons.local_hospital;
      case UserRole.anesthesiologist:
        return Icons.medical_services;
      case UserRole.administrator:
        return Icons.admin_panel_settings;
    }
  }

  String _getWelcomeMessage() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return 'Acompanhe o status dos seus documentos, agenda de procedimentos e controle de estoque.';
      case UserRole.anesthesiologist:
        return 'Gerencie sua agenda, fichas de pacientes e procedimentos de sedação.';
      case UserRole.administrator:
        return 'Monitore todas as clínicas, anestesiologistas e gere relatórios de conformidade.';
    }
  }

  List<Map<String, dynamic>> _getStatistics() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return [
          {
            'icon': Icons.calendar_today,
            'value': '12',
            'label': 'Procedimentos\nHoje',
            'color': AppConstants.primaryColor,
          },
          {
            'icon': Icons.people,
            'value': '45',
            'label': 'Pacientes\nCadastrados',
            'color': AppConstants.accentColor,
          },
          {
            'icon': Icons.medication,
            'value': '8',
            'label': 'Medicamentos\nBaixo Estoque',
            'color': AppConstants.warningColor,
          },
          {
            'icon': Icons.assessment,
            'value': '98%',
            'label': 'Documentação\nAtualizada',
            'color': AppConstants.successColor,
          },
        ];
      case UserRole.anesthesiologist:
        return [
          {
            'icon': Icons.calendar_today,
            'value': '5',
            'label': 'Procedimentos\nHoje',
            'color': AppConstants.accentColor,
          },
          {
            'icon': Icons.medical_services,
            'value': '28',
            'label': 'Procedimentos\nEste Mês',
            'color': AppConstants.primaryColor,
          },
          {
            'icon': Icons.people,
            'value': '12',
            'label': 'Fichas\nPendentes',
            'color': AppConstants.warningColor,
          },
          {
            'icon': Icons.check_circle,
            'value': '156',
            'label': 'Procedimentos\nConcluídos',
            'color': AppConstants.successColor,
          },
        ];
      case UserRole.administrator:
        return [
          {
            'icon': Icons.local_hospital,
            'value': '24',
            'label': 'Clínicas\nAtivas',
            'color': AppConstants.secondaryColor,
          },
          {
            'icon': Icons.medical_services,
            'value': '156',
            'label': 'Anestesiologistas\nCadastrados',
            'color': AppConstants.primaryColor,
          },
          {
            'icon': Icons.assessment,
            'value': '1.2k',
            'label': 'Procedimentos\nEste Mês',
            'color': AppConstants.accentColor,
          },
          {
            'icon': Icons.warning,
            'value': '7',
            'label': 'Alertas\nPendentes',
            'color': AppConstants.warningColor,
          },
        ];
    }
  }

  List<Map<String, dynamic>> _getQuickActions() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return [
          {
            'icon': Icons.add,
            'label': 'Novo Procedimento',
            'onTap': () => _showMessage('Novo procedimento'),
          },
          {
            'icon': Icons.person_add,
            'label': 'Cadastrar Paciente',
            'onTap': () => _showMessage('Cadastrar paciente'),
          },
          {
            'icon': Icons.medication,
            'label': 'Controle de Estoque',
            'onTap': () => _showMessage('Controle de estoque'),
          },
          {
            'icon': Icons.upload_file,
            'label': 'Upload Documentos',
            'onTap': () => _showMessage('Upload de documentos'),
          },
        ];
      case UserRole.anesthesiologist:
        return [
          {
            'icon': Icons.add,
            'label': 'Nova Avaliação',
            'onTap': () => _showMessage('Nova avaliação'),
          },
          {
            'icon': Icons.medical_services,
            'label': 'Iniciar Sedação',
            'onTap': () => _showMessage('Iniciar sedação'),
          },
          {
            'icon': Icons.people,
            'label': 'Meus Pacientes',
            'onTap': () => _showMessage('Meus pacientes'),
          },
          {
            'icon': Icons.assessment,
            'label': 'Minhas Estatísticas',
            'onTap': () => _showMessage('Minhas estatísticas'),
          },
        ];
      case UserRole.administrator:
        return [
          {
            'icon': Icons.local_hospital,
            'label': 'Gerenciar Clínicas',
            'onTap': () => _showMessage('Gerenciar clínicas'),
          },
          {
            'icon': Icons.medical_services,
            'label': 'Gerenciar Anestesiologistas',
            'onTap': () => _showMessage('Gerenciar anestesiologistas'),
          },
          {
            'icon': Icons.assessment,
            'label': 'Relatórios Gerais',
            'onTap': () => _showMessage('Relatórios gerais'),
          },
          {
            'icon': Icons.settings,
            'label': 'Configurações do Sistema',
            'onTap': () => _showMessage('Configurações do sistema'),
          },
        ];
    }
  }

  List<Map<String, dynamic>> _getAlerts() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return [
          {
            'icon': Icons.warning,
            'title': 'Documento Vencendo',
            'message': 'Alvará sanitário vence em 15 dias',
            'color': AppConstants.warningColor,
          },
          {
            'icon': Icons.medication,
            'title': 'Estoque Baixo',
            'message': 'Propofol com estoque crítico',
            'color': AppConstants.errorColor,
          },
        ];
      case UserRole.anesthesiologist:
        return [
          {
            'icon': Icons.medical_services,
            'title': 'Procedimento em 30 min',
            'message': 'Paciente João Silva - Sedação',
            'color': AppConstants.infoColor,
          },
          {
            'icon': Icons.people,
            'title': 'Ficha Pendente',
            'message': 'Avaliação pré-anestésica não concluída',
            'color': AppConstants.warningColor,
          },
        ];
      case UserRole.administrator:
        return [
          {
            'icon': Icons.local_hospital,
            'title': 'Clínica Pendente',
            'message': '3 clínicas aguardando aprovação',
            'color': AppConstants.warningColor,
          },
          {
            'icon': Icons.assessment,
            'title': 'Relatório Mensal',
            'message': 'Relatório de conformidade disponível',
            'color': AppConstants.infoColor,
          },
        ];
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message será implementado em breve!'),
        backgroundColor: AppConstants.infoColor,
      ),
    );
  }

  void _showNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sistema de notificações será implementado'),
        backgroundColor: AppConstants.infoColor,
      ),
    );
  }

  void _showProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil do usuário será implementado'),
        backgroundColor: AppConstants.infoColor,
      ),
    );
  }
} 