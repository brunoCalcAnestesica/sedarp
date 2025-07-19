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
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
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
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo ou ícone
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.medical_services,
                      size: 60,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  // Título
                  Text(
                    AppConstants.appName,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingMedium),
                  
                  // Descrição
                  Text(
                    AppConstants.appDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingXLarge),
                  
                  // Botão de login
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navegar para tela de login
                        _showLoginDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppConstants.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppConstants.paddingLarge,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                        ),
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
                  
                  const SizedBox(height: AppConstants.paddingMedium),
                  
                  // Link para mais informações
                  TextButton(
                    onPressed: () {
                      // TODO: Abrir informações sobre o SEDARP
                    },
                    child: Text(
                      'Saiba mais sobre o SEDARP',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecionar Perfil'),
          content: const Text('Escolha seu perfil para continuar:'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToLogin(context, 'clinic');
              },
              child: const Text('Clínica'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToLogin(context, 'anesthesiologist');
              },
              child: const Text('Anestesiologista'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToLogin(context, 'administrator');
              },
              child: const Text('Administrador/RT'),
            ),
          ],
        );
      },
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
