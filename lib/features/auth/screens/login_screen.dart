import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/user_model.dart';
import '../../dashboard/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  final UserRole userRole;

  const LoginScreen({
    super.key,
    required this.userRole,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _twoFactorController = TextEditingController();
  
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _lgpdAccepted = false;
  bool _showTwoFactor = false;
  int _loginAttempts = 0;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = _getDemoEmail();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _twoFactorController.dispose();
    super.dispose();
  }

  String _getDemoEmail() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return 'clinica@exemplo.com';
      case UserRole.anesthesiologist:
        return 'anestesista@exemplo.com';
      case UserRole.administrator:
        return 'admin@sedarp.com.br';
    }
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

  Future<void> _handleLogin() async {
    if (!_lgpdAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Você deve aceitar os termos de uso e política de privacidade'),
          backgroundColor: AppConstants.errorColor,
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular delay de login
      await Future.delayed(const Duration(seconds: 2));

      // Simular validação de credenciais
      if (_emailController.text.contains('demo') || _passwordController.text == '123456') {
        _loginAttempts = 0;
        
        // Simular autenticação de dois fatores
        if (_showTwoFactor) {
          if (_twoFactorController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Digite o código de autenticação de dois fatores'),
                backgroundColor: AppConstants.errorColor,
              ),
            );
            setState(() {
              _isLoading = false;
            });
            return;
          }
        }

        // Login bem-sucedido
        _navigateToDashboard();
      } else {
        _loginAttempts++;
        
        if (_loginAttempts >= 3) {
          setState(() {
            _isLocked = true;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Conta bloqueada por 15 minutos devido a múltiplas tentativas'),
              backgroundColor: AppConstants.errorColor,
            ),
          );
          
          // Desbloquear após 15 minutos
          Future.delayed(const Duration(minutes: 15), () {
            if (mounted) {
              setState(() {
                _isLocked = false;
                _loginAttempts = 0;
              });
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Credenciais inválidas. Tentativas restantes: ${3 - _loginAttempts}'),
              backgroundColor: AppConstants.warningColor,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao fazer login. Tente novamente.'),
          backgroundColor: AppConstants.errorColor,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToDashboard() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login realizado com sucesso! Bem-vindo ao SEDARP'),
        backgroundColor: AppConstants.successColor,
      ),
    );
    
    // Navegar para o dashboard específico
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => DashboardScreen(
              userRole: widget.userRole,
              userName: _getDemoUserName(),
            ),
          ),
          (route) => false, // Remove todas as telas anteriores
        );
      }
    });
  }

  String _getDemoUserName() {
    switch (widget.userRole) {
      case UserRole.clinic:
        return 'Clínica Exemplo';
      case UserRole.anesthesiologist:
        return 'Dr. João Silva';
      case UserRole.administrator:
        return 'Administrador SEDARP';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login - ${_getRoleDisplayName()}'),
        backgroundColor: _getRoleColor(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _getRoleColor().withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  // Ícone do perfil
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _getRoleColor(),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: _getRoleColor().withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      _getRoleIcon(),
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  // Título
                  Text(
                    'Bem-vindo ao SEDARP',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: _getRoleColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingSmall),
                  
                  // Subtítulo
                  Text(
                    'Acesse sua conta de ${_getRoleDisplayName().toLowerCase()}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppConstants.textSecondaryColor,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingXLarge),
                  
                  // Campo de e-mail
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: !_isLocked,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Digite seu e-mail',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.requiredFieldMessage;
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return AppConstants.invalidEmailMessage;
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: AppConstants.paddingMedium),
                  
                  // Campo de senha
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    enabled: !_isLocked,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      hintText: 'Digite sua senha',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.requiredFieldMessage;
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: AppConstants.paddingMedium),
                  
                  // Campo de autenticação de dois fatores
                  if (_showTwoFactor) ...[
                    TextFormField(
                      controller: _twoFactorController,
                      keyboardType: TextInputType.number,
                      enabled: !_isLocked,
                      decoration: const InputDecoration(
                        labelText: 'Código de Autenticação',
                        prefixIcon: Icon(Icons.security),
                        hintText: 'Digite o código de 6 dígitos',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite o código de autenticação';
                        }
                        if (value.length != 6) {
                          return 'O código deve ter 6 dígitos';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),
                  ],
                  
                  // Checkbox LGPD
                  Row(
                    children: [
                      Checkbox(
                        value: _lgpdAccepted,
                        onChanged: _isLocked ? null : (value) {
                          setState(() {
                            _lgpdAccepted = value ?? false;
                          });
                        },
                        activeColor: _getRoleColor(),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: _isLocked ? null : () {
                            setState(() {
                              _lgpdAccepted = !_lgpdAccepted;
                            });
                          },
                          child: Text(
                            'Aceito os termos de uso e política de privacidade',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  // Botão de login
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLocked || _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getRoleColor(),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  // Links de ajuda
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: _isLocked ? null : () {
                          // TODO: Implementar recuperação de senha
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Recuperação de senha será implementada'),
                              backgroundColor: AppConstants.infoColor,
                            ),
                          );
                        },
                        child: const Text('Esqueci minha senha'),
                      ),
                      TextButton(
                        onPressed: _isLocked ? null : () {
                          // TODO: Implementar suporte
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Suporte será implementado'),
                              backgroundColor: AppConstants.infoColor,
                            ),
                          );
                        },
                        child: const Text('Preciso de ajuda'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  // Informações de demo
                  Container(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    decoration: BoxDecoration(
                      color: AppConstants.infoColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                      border: Border.all(
                        color: AppConstants.infoColor.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Dados de Demonstração',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppConstants.infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppConstants.paddingSmall),
                        Text(
                          'E-mail: ${_getDemoEmail()}\nSenha: 123456',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppConstants.textSecondaryColor,
                          ),
                        ),
                      ],
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
} 