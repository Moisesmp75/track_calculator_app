import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @academicPortal.
  ///
  /// In es, this message translates to:
  /// **'PORTAL ACADÉMICO'**
  String get academicPortal;

  /// No description provided for @appName.
  ///
  /// In es, this message translates to:
  /// **'Acarreo U'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In es, this message translates to:
  /// **'Optimización de ciclo, pala y tolvas para minería e ingeniería civil'**
  String get appTagline;

  /// No description provided for @institutionalEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo'**
  String get institutionalEmail;

  /// No description provided for @emailHint.
  ///
  /// In es, this message translates to:
  /// **'alumno@uni.edu.pe'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu correo'**
  String get emailRequired;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In es, this message translates to:
  /// **'********'**
  String get passwordHint;

  /// No description provided for @passwordRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu contraseña'**
  String get passwordRequired;

  /// No description provided for @signIn.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Sesión'**
  String get signIn;

  /// No description provided for @noAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Aún no tienes una cuenta?'**
  String get noAccount;

  /// No description provided for @registerHere.
  ///
  /// In es, this message translates to:
  /// **'Regístrate aquí'**
  String get registerHere;

  /// No description provided for @toggleTheme.
  ///
  /// In es, this message translates to:
  /// **'Cambiar tema'**
  String get toggleTheme;

  /// No description provided for @toggleLanguage.
  ///
  /// In es, this message translates to:
  /// **'Cambiar idioma'**
  String get toggleLanguage;

  /// No description provided for @newAccount.
  ///
  /// In es, this message translates to:
  /// **'NUEVA CUENTA'**
  String get newAccount;

  /// No description provided for @createAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear Cuenta'**
  String get createAccount;

  /// No description provided for @registerTagline.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tus datos personales para acceder a la calculadora y simulaciones de transporte minero.'**
  String get registerTagline;

  /// No description provided for @firstNames.
  ///
  /// In es, this message translates to:
  /// **'Nombres'**
  String get firstNames;

  /// No description provided for @firstNamesHint.
  ///
  /// In es, this message translates to:
  /// **'Ej. Juan Carlos'**
  String get firstNamesHint;

  /// No description provided for @lastNames.
  ///
  /// In es, this message translates to:
  /// **'Apellidos'**
  String get lastNames;

  /// No description provided for @lastNamesHint.
  ///
  /// In es, this message translates to:
  /// **'Ej. Pérez Mendoza'**
  String get lastNamesHint;

  /// No description provided for @birthDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de Nacimiento'**
  String get birthDate;

  /// No description provided for @birthDateHint.
  ///
  /// In es, this message translates to:
  /// **'dd/mm/aaaa'**
  String get birthDateHint;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Correo Electrónico'**
  String get email;

  /// No description provided for @emailPersonalHint.
  ///
  /// In es, this message translates to:
  /// **'juan.perez@email.com'**
  String get emailPersonalHint;

  /// No description provided for @confirmPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirmar Contraseña'**
  String get confirmPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes una cuenta?'**
  String get alreadyHaveAccount;

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settings;

  /// No description provided for @configuration.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get configuration;

  /// No description provided for @settingsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Preferencias de la aplicación e información de la cuenta'**
  String get settingsSubtitle;

  /// No description provided for @editPersonalData.
  ///
  /// In es, this message translates to:
  /// **'Editar datos personales'**
  String get editPersonalData;

  /// No description provided for @editPersonalDataSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Editar datos personales, correo electrónico y contraseña'**
  String get editPersonalDataSubtitle;

  /// No description provided for @interfacePreferences.
  ///
  /// In es, this message translates to:
  /// **'PREFERENCIAS DE INTERFAZ'**
  String get interfacePreferences;

  /// No description provided for @systemLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma del Sistema'**
  String get systemLanguage;

  /// No description provided for @spanishActive.
  ///
  /// In es, this message translates to:
  /// **'Español activo'**
  String get spanishActive;

  /// No description provided for @englishActive.
  ///
  /// In es, this message translates to:
  /// **'English activo'**
  String get englishActive;

  /// No description provided for @spanishPe.
  ///
  /// In es, this message translates to:
  /// **'Español (PE)'**
  String get spanishPe;

  /// No description provided for @englishUs.
  ///
  /// In es, this message translates to:
  /// **'English (US)'**
  String get englishUs;

  /// No description provided for @visualAppearance.
  ///
  /// In es, this message translates to:
  /// **'Apariencia Visual'**
  String get visualAppearance;

  /// No description provided for @lightMode.
  ///
  /// In es, this message translates to:
  /// **'Modo Claro'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In es, this message translates to:
  /// **'Modo Oscuro'**
  String get darkMode;

  /// No description provided for @accountAndSecurity.
  ///
  /// In es, this message translates to:
  /// **'CUENTA Y SEGURIDAD'**
  String get accountAndSecurity;

  /// No description provided for @changePassword.
  ///
  /// In es, this message translates to:
  /// **'Cambiar contraseña'**
  String get changePassword;

  /// No description provided for @passwordLastModified.
  ///
  /// In es, this message translates to:
  /// **'Última modificación hace 3 meses'**
  String get passwordLastModified;

  /// No description provided for @signOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar Sesión'**
  String get signOut;

  /// No description provided for @dangerZone.
  ///
  /// In es, this message translates to:
  /// **'Zona de Riesgo'**
  String get dangerZone;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In es, this message translates to:
  /// **'Al borrar tu cuenta se borrarán todos tus datos, incluyendo el historial de resultados guardados. Esta acción no puede ser revertida.'**
  String get deleteAccountWarning;

  /// No description provided for @deleteAccountTwoSteps.
  ///
  /// In es, this message translates to:
  /// **'Eliminar cuenta (proceso de 2 pasos)'**
  String get deleteAccountTwoSteps;

  /// No description provided for @calculate.
  ///
  /// In es, this message translates to:
  /// **'Calcular'**
  String get calculate;

  /// No description provided for @haulageSimulation.
  ///
  /// In es, this message translates to:
  /// **'SIMULACIÓN DE ACARREO'**
  String get haulageSimulation;

  /// No description provided for @newCalculation.
  ///
  /// In es, this message translates to:
  /// **'Nuevo Cálculo'**
  String get newCalculation;

  /// No description provided for @calculateFleetAndCycle.
  ///
  /// In es, this message translates to:
  /// **'Calcular Flota y Ciclo'**
  String get calculateFleetAndCycle;

  /// No description provided for @generalData.
  ///
  /// In es, this message translates to:
  /// **'Datos Generales'**
  String get generalData;

  /// No description provided for @optional.
  ///
  /// In es, this message translates to:
  /// **'Opcional'**
  String get optional;

  /// No description provided for @miningProject.
  ///
  /// In es, this message translates to:
  /// **'Proyecto Minero / Obra'**
  String get miningProject;

  /// No description provided for @transportRoute.
  ///
  /// In es, this message translates to:
  /// **'Ruta de Transporte'**
  String get transportRoute;

  /// No description provided for @operationParameters.
  ///
  /// In es, this message translates to:
  /// **'Parámetros de Operación'**
  String get operationParameters;

  /// No description provided for @inSituMaterial.
  ///
  /// In es, this message translates to:
  /// **'Material In Situ / Esponjado'**
  String get inSituMaterial;

  /// No description provided for @selectMaterial.
  ///
  /// In es, this message translates to:
  /// **'Selecciona un material'**
  String get selectMaterial;

  /// No description provided for @haulageUnit.
  ///
  /// In es, this message translates to:
  /// **'Unidad de Acarreo (Volquete)'**
  String get haulageUnit;

  /// No description provided for @selectUnit.
  ///
  /// In es, this message translates to:
  /// **'Selecciona una unidad'**
  String get selectUnit;

  /// No description provided for @outboundDistance.
  ///
  /// In es, this message translates to:
  /// **'Distancia ida'**
  String get outboundDistance;

  /// No description provided for @loadingYield.
  ///
  /// In es, this message translates to:
  /// **'Rend. Carguío'**
  String get loadingYield;

  /// No description provided for @loadedSpeed.
  ///
  /// In es, this message translates to:
  /// **'Vel. Cargado'**
  String get loadedSpeed;

  /// No description provided for @returnSpeed.
  ///
  /// In es, this message translates to:
  /// **'Vel. Retorno'**
  String get returnSpeed;

  /// No description provided for @shiftHours.
  ///
  /// In es, this message translates to:
  /// **'Jornada Turno'**
  String get shiftHours;

  /// No description provided for @efficiency.
  ///
  /// In es, this message translates to:
  /// **'Eficiencia'**
  String get efficiency;

  /// No description provided for @costAnalysis.
  ///
  /// In es, this message translates to:
  /// **'Análisis de Costos'**
  String get costAnalysis;

  /// No description provided for @estimateUnitRatios.
  ///
  /// In es, this message translates to:
  /// **'Estimar ratios unitarios'**
  String get estimateUnitRatios;

  /// No description provided for @history.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get history;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
