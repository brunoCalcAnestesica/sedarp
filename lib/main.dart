import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_theme.dart';
import 'features/auth/screens/login_screen.dart';
import 'shared/models/user_model.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SedarpApp(),
    ),
  );
}

class SedarpApp extends StatelessWidget {
  const SedarpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.primaryColor,
              AppConstants.secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/Ícone
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.medical_services,
                    size: 60,
                    color: AppConstants.primaryColor,
                  ),
                ),
                
                const SizedBox(height: AppConstants.paddingXLarge),
                
                // Título
                const Text(
                  'SEDARP',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                
                const SizedBox(height: AppConstants.paddingSmall),
                
                // Subtítulo
                const Text(
                  'Serviço de Sedação Ambulatorial\nem Regime de Pequena Cirurgia',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: AppConstants.paddingXLarge),
                
                // Botão de entrada
                SizedBox(
                  width: 280,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _showProfileSelector(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppConstants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                      ),
                      elevation: 8,
                    ),
                    child: const Text(
                      'Entrar no SEDARP',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: AppConstants.paddingXLarge),
                
                // Versão
                const Text(
                  'Versão 1.0.0',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showProfileSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Selecione seu Perfil',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppConstants.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProfileOption(
              context,
              'Clínica',
              Icons.local_hospital,
              AppConstants.primaryColor,
              'clinic',
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            _buildProfileOption(
              context,
              'Anestesiologista',
              Icons.medical_services,
              AppConstants.accentColor,
              'anesthesiologist',
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            _buildProfileOption(
              context,
              'Administrador/RT',
              Icons.admin_panel_settings,
              AppConstants.secondaryColor,
              'administrator',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String profile,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        _navigateToLogin(context, profile);
      },
      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: AppConstants.paddingMedium),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLogin(BuildContext context, String profile) {
    UserRole userRole;
    
    switch (profile) {
      case 'clinic':
        userRole = UserRole.clinic;
        break;
      case 'anesthesiologist':
        userRole = UserRole.anesthesiologist;
        break;
      case 'administrator':
        userRole = UserRole.administrator;
        break;
      default:
        userRole = UserRole.clinic;
    }
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(userRole: userRole),
      ),
    );
  }
} 