import 'package:flutter/material.dart';

class AppConstants {
  // Cores do tema
  static const Color primaryColor = Color(0xFF1976D2); // Azul médico
  static const Color secondaryColor = Color(0xFF42A5F5);
  static const Color accentColor = Color(0xFF26A69A); // Verde médico
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color infoColor = Color(0xFF2196F3);
  
  // Cores de fundo
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);
  
  // Cores de texto
  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);
  static const Color textLightColor = Color(0xFFBDBDBD);
  
  // Cores de status
  static const Color statusActiveColor = Color(0xFF4CAF50);
  static const Color statusInactiveColor = Color(0xFF9E9E9E);
  static const Color statusPendingColor = Color(0xFFFF9800);
  static const Color statusSuspendedColor = Color(0xFFD32F2F);
  static const Color statusExpiredColor = Color(0xFFF44336);
  
  // Cores de ASA
  static const Color asa1Color = Color(0xFF4CAF50);
  static const Color asa2Color = Color(0xFF8BC34A);
  static const Color asa3Color = Color(0xFFFF9800);
  static const Color asa4Color = Color(0xFFFF5722);
  static const Color asa5Color = Color(0xFFD32F2F);
  static const Color asa6Color = Color(0xFF9C27B0);
  
  // Cores de Mallampati
  static const Color mallampati1Color = Color(0xFF4CAF50);
  static const Color mallampati2Color = Color(0xFF8BC34A);
  static const Color mallampati3Color = Color(0xFFFF9800);
  static const Color mallampati4Color = Color(0xFFD32F2F);
  
  // Tamanhos
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;
  
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  
  // Textos
  static const String appName = 'SEDARP';
  static const String appDescription = 'Serviço de Sedação Ambulatorial em Regime de Pequena Cirurgia';
  static const String appVersion = '1.0.0';
  
  // Mensagens
  static const String welcomeMessage = 'Bem-vindo ao SEDARP';
  static const String loginMessage = 'Faça login para continuar';
  static const String loadingMessage = 'Carregando...';
  static const String errorMessage = 'Ocorreu um erro';
  static const String successMessage = 'Operação realizada com sucesso';
  static const String confirmMessage = 'Tem certeza?';
  static const String cancelMessage = 'Cancelar';
  static const String confirmButtonText = 'Confirmar';
  static const String saveButtonText = 'Salvar';
  static const String editButtonText = 'Editar';
  static const String deleteButtonText = 'Excluir';
  static const String addButtonText = 'Adicionar';
  static const String searchButtonText = 'Buscar';
  static const String filterButtonText = 'Filtrar';
  static const String exportButtonText = 'Exportar';
  static const String printButtonText = 'Imprimir';
  static const String shareButtonText = 'Compartilhar';
  
  // Validações
  static const String requiredFieldMessage = 'Este campo é obrigatório';
  static const String invalidEmailMessage = 'E-mail inválido';
  static const String invalidCpfMessage = 'CPF inválido';
  static const String invalidCnpjMessage = 'CNPJ inválido';
  static const String invalidCrmMessage = 'CRM inválido';
  static const String invalidPhoneMessage = 'Telefone inválido';
  static const String invalidDateMessage = 'Data inválida';
  static const String invalidTimeMessage = 'Horário inválido';
  static const String invalidNumberMessage = 'Número inválido';
  static const String invalidWeightMessage = 'Peso inválido';
  static const String invalidHeightMessage = 'Altura inválida';
  static const String invalidAgeMessage = 'Idade inválida';
  
  // Perfis
  static const String clinicProfile = 'Clínica';
  static const String anesthesiologistProfile = 'Anestesiologista';
  static const String administratorProfile = 'Administrador/RT';
  
  // Status
  static const String statusActive = 'Ativo';
  static const String statusInactive = 'Inativo';
  static const String statusPending = 'Pendente';
  static const String statusSuspended = 'Suspenso';
  static const String statusExpired = 'Expirado';
  
  // Procedimentos
  static const String procedureScheduled = 'Agendado';
  static const String procedureInProgress = 'Em Andamento';
  static const String procedureCompleted = 'Concluído';
  static const String procedureCancelled = 'Cancelado';
  static const String procedureNoShow = 'Não Compareceu';
  
  // Tipos de procedimento
  static const String procedureTypeSedation = 'Sedação';
  static const String procedureTypeAnesthesia = 'Anestesia';
  static const String procedureTypeConsultation = 'Consulta';
  static const String procedureTypeEvaluation = 'Avaliação';
  
  // Tipos de medicamento
  static const String medicationTypeControlled = 'Controlado';
  static const String medicationTypeRegular = 'Regular';
  static const String medicationTypeEmergency = 'Emergência';
  
  // Unidades de medicamento
  static const String medicationUnitMg = 'mg';
  static const String medicationUnitMcg = 'mcg';
  static const String medicationUnitMl = 'ml';
  static const String medicationUnitUnits = 'unidades';
  static const String medicationUnitAmpoules = 'ampolas';
  static const String medicationUnitVials = 'frascos';
  static const String medicationUnitTablets = 'comprimidos';
  static const String medicationUnitCapsules = 'cápsulas';
  
  // ASA Classes
  static const String asa1 = 'ASA I';
  static const String asa2 = 'ASA II';
  static const String asa3 = 'ASA III';
  static const String asa4 = 'ASA IV';
  static const String asa5 = 'ASA V';
  static const String asa6 = 'ASA VI';
  
  // Mallampati Classes
  static const String mallampati1 = 'Classe I';
  static const String mallampati2 = 'Classe II';
  static const String mallampati3 = 'Classe III';
  static const String mallampati4 = 'Classe IV';
  
  // Gêneros
  static const String genderMale = 'Masculino';
  static const String genderFemale = 'Feminino';
  static const String genderOther = 'Outro';
  
  // Limites
  static const int maxNameLength = 100;
  static const int maxDescriptionLength = 500;
  static const int maxNotesLength = 1000;
  static const int maxPhoneLength = 15;
  static const int maxCpfLength = 14;
  static const int maxCnpjLength = 18;
  static const int maxCrmLength = 20;
  static const int maxRqeLength = 20;
  static const int maxAddressLength = 200;
  static const int maxEmailLength = 100;
  
  // Valores padrão
  static const double defaultWeight = 70.0;
  static const double defaultHeight = 170.0;
  static const int defaultFastingHours = 8;
  static const int defaultEstimatedDuration = 60; // minutos
  static const double defaultMinimumStock = 10.0;
  static const double defaultMaximumStock = 100.0;
  
  // Formatação de data
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String isoDateFormat = 'yyyy-MM-dd';
  static const String isoDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  
  // Formatação de números
  static const String currencyFormat = 'R\$ #,##0.00';
  static const String weightFormat = '#,##0.0 kg';
  static const String heightFormat = '#,##0 cm';
  static const String percentageFormat = '#,##0.0%';
  
  // URLs e endpoints
  static const String privacyPolicyUrl = 'https://sedarp.com.br/privacy';
  static const String termsOfServiceUrl = 'https://sedarp.com.br/terms';
  static const String supportEmail = 'suporte@sedarp.com.br';
  static const String supportPhone = '(11) 99999-9999';
  
  // Configurações
  static const int sessionTimeoutMinutes = 30;
  static const int maxLoginAttempts = 3;
  static const int lockoutDurationMinutes = 15;
  static const int maxFileSizeMB = 10;
  static const List<String> allowedFileTypes = ['pdf', 'jpg', 'jpeg', 'png'];
  
  // Chaves de armazenamento
  static const String userKey = 'user';
  static const String tokenKey = 'token';
  static const String refreshTokenKey = 'refresh_token';
  static const String settingsKey = 'settings';
  static const String themeKey = 'theme';
  static const String languageKey = 'language';
  
  // IDs de notificação
  static const int notificationIdLowStock = 1;
  static const int notificationIdExpiredMedication = 2;
  static const int notificationIdUpcomingProcedure = 3;
  static const int notificationIdDocumentExpiry = 4;
  static const int notificationIdSystemAlert = 5;
  
  // Canais de notificação
  static const String notificationChannelGeneral = 'general';
  static const String notificationChannelAlerts = 'alerts';
  static const String notificationChannelProcedures = 'procedures';
  static const String notificationChannelMedications = 'medications';
  
  // Categorias de notificação
  static const String notificationCategoryAlert = 'alert';
  static const String notificationCategoryInfo = 'info';
  static const String notificationCategoryWarning = 'warning';
  static const String notificationCategoryError = 'error';
  static const String notificationCategorySuccess = 'success';
} 