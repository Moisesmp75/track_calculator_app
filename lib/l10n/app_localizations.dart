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
  /// **'SmartHaul'**
  String get appName;

  /// No description provided for @appBrandSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Transporte inteligente'**
  String get appBrandSubtitle;

  /// No description provided for @appTagline.
  ///
  /// In es, this message translates to:
  /// **'Optimización de ciclo, pala y tolvas para minería e ingeniería civil'**
  String get appTagline;

  /// No description provided for @appVersion.
  ///
  /// In es, this message translates to:
  /// **'Versión {version}'**
  String appVersion(String version);

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
  /// **'Nombre'**
  String get firstNames;

  /// No description provided for @firstNamesHint.
  ///
  /// In es, this message translates to:
  /// **'Ej. Juan'**
  String get firstNamesHint;

  /// No description provided for @lastNames.
  ///
  /// In es, this message translates to:
  /// **'Apellido'**
  String get lastNames;

  /// No description provided for @lastNamesHint.
  ///
  /// In es, this message translates to:
  /// **'Ej. Pérez'**
  String get lastNamesHint;

  /// No description provided for @forgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get forgotPassword;

  /// No description provided for @recoverPassword.
  ///
  /// In es, this message translates to:
  /// **'RECUPERAR CUENTA'**
  String get recoverPassword;

  /// No description provided for @recoverPasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'Recuperar contraseña'**
  String get recoverPasswordTitle;

  /// No description provided for @recoverPasswordTagline.
  ///
  /// In es, this message translates to:
  /// **'Ingresa los datos de tu cuenta para verificar tu identidad.'**
  String get recoverPasswordTagline;

  /// No description provided for @verifyIdentity.
  ///
  /// In es, this message translates to:
  /// **'Verificar identidad'**
  String get verifyIdentity;

  /// No description provided for @newPasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva contraseña'**
  String get newPasswordTitle;

  /// No description provided for @newPasswordTagline.
  ///
  /// In es, this message translates to:
  /// **'Elige una contraseña nueva para tu cuenta.'**
  String get newPasswordTagline;

  /// No description provided for @newPassword.
  ///
  /// In es, this message translates to:
  /// **'Nueva contraseña'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirmar nueva contraseña'**
  String get confirmNewPassword;

  /// No description provided for @saveNewPassword.
  ///
  /// In es, this message translates to:
  /// **'Guardar contraseña'**
  String get saveNewPassword;

  /// No description provided for @passwordUpdated.
  ///
  /// In es, this message translates to:
  /// **'Contraseña actualizada. Inicia sesión para continuar.'**
  String get passwordUpdated;

  /// No description provided for @birthDateRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu fecha de nacimiento'**
  String get birthDateRequired;

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
  /// **'Eliminar cuenta'**
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

  /// No description provided for @miningProjectHint.
  ///
  /// In es, this message translates to:
  /// **'Ej. Tajo Norte'**
  String get miningProjectHint;

  /// No description provided for @transportRoute.
  ///
  /// In es, this message translates to:
  /// **'Ruta de Transporte'**
  String get transportRoute;

  /// No description provided for @transportRouteHint.
  ///
  /// In es, this message translates to:
  /// **'Ej. Tramo A-B'**
  String get transportRouteHint;

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

  /// No description provided for @dumpTruckHourlyRate.
  ///
  /// In es, this message translates to:
  /// **'Costo volquete'**
  String get dumpTruckHourlyRate;

  /// No description provided for @loaderHourlyRate.
  ///
  /// In es, this message translates to:
  /// **'Costo pala'**
  String get loaderHourlyRate;

  /// No description provided for @staffHourlyRate.
  ///
  /// In es, this message translates to:
  /// **'Costo personal'**
  String get staffHourlyRate;

  /// No description provided for @unitKm.
  ///
  /// In es, this message translates to:
  /// **'km'**
  String get unitKm;

  /// No description provided for @unitKmh.
  ///
  /// In es, this message translates to:
  /// **'km/h'**
  String get unitKmh;

  /// No description provided for @unitM3h.
  ///
  /// In es, this message translates to:
  /// **'m³/h'**
  String get unitM3h;

  /// No description provided for @unitHours.
  ///
  /// In es, this message translates to:
  /// **'h'**
  String get unitHours;

  /// No description provided for @unitRatio.
  ///
  /// In es, this message translates to:
  /// **'0–1'**
  String get unitRatio;

  /// No description provided for @unitPerHour.
  ///
  /// In es, this message translates to:
  /// **'/h'**
  String get unitPerHour;

  /// No description provided for @history.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get history;

  /// No description provided for @calculationHistoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial de cálculos'**
  String get calculationHistoryTitle;

  /// No description provided for @historySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Tus simulaciones y reportes guardados para campo y laboratorio'**
  String get historySubtitle;

  /// No description provided for @historySynced.
  ///
  /// In es, this message translates to:
  /// **'Sincronizado'**
  String get historySynced;

  /// No description provided for @historyEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no tienes cálculos guardados.'**
  String get historyEmpty;

  /// No description provided for @untitledCalculation.
  ///
  /// In es, this message translates to:
  /// **'Cálculo'**
  String get untitledCalculation;

  /// No description provided for @fieldRequired.
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio'**
  String get fieldRequired;

  /// No description provided for @networkError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo conectar con el servidor. Inténtalo de nuevo.'**
  String get networkError;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get passwordsDoNotMatch;

  /// No description provided for @invalidBirthDateFormat.
  ///
  /// In es, this message translates to:
  /// **'Usa el formato dd/mm/aaaa'**
  String get invalidBirthDateFormat;

  /// No description provided for @registerSuccess.
  ///
  /// In es, this message translates to:
  /// **'Cuenta creada. Inicia sesión para continuar.'**
  String get registerSuccess;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un correo con formato válido'**
  String get invalidEmailFormat;

  /// No description provided for @invalidNameFormat.
  ///
  /// In es, this message translates to:
  /// **'Solo letras, sin espacios ni números'**
  String get invalidNameFormat;

  /// No description provided for @invalidPasswordFormat.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 10 caracteres, con mayúscula, minúscula y número'**
  String get invalidPasswordFormat;

  /// No description provided for @resultDetail.
  ///
  /// In es, this message translates to:
  /// **'Detalle de ciclo'**
  String get resultDetail;

  /// No description provided for @missingCalculationResult.
  ///
  /// In es, this message translates to:
  /// **'No hay un resultado para mostrar.'**
  String get missingCalculationResult;

  /// No description provided for @suggestedTrucks.
  ///
  /// In es, this message translates to:
  /// **'Volquetes sugeridos'**
  String get suggestedTrucks;

  /// No description provided for @cycleTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo de ciclo'**
  String get cycleTime;

  /// No description provided for @tripsPerShift.
  ///
  /// In es, this message translates to:
  /// **'Viajes por turno'**
  String get tripsPerShift;

  /// No description provided for @totalVolume.
  ///
  /// In es, this message translates to:
  /// **'Volumen total'**
  String get totalVolume;

  /// No description provided for @hourlyOutput.
  ///
  /// In es, this message translates to:
  /// **'Productividad'**
  String get hourlyOutput;

  /// No description provided for @swellFactor.
  ///
  /// In es, this message translates to:
  /// **'Esponjamiento'**
  String get swellFactor;

  /// No description provided for @effectiveCapacity.
  ///
  /// In es, this message translates to:
  /// **'Capacidad efectiva'**
  String get effectiveCapacity;

  /// No description provided for @unitCost.
  ///
  /// In es, this message translates to:
  /// **'Costo unitario'**
  String get unitCost;

  /// No description provided for @unitMinutes.
  ///
  /// In es, this message translates to:
  /// **'min'**
  String get unitMinutes;

  /// No description provided for @unitM3.
  ///
  /// In es, this message translates to:
  /// **'m³'**
  String get unitM3;

  /// No description provided for @unitPerM3.
  ///
  /// In es, this message translates to:
  /// **'/m³'**
  String get unitPerM3;

  /// No description provided for @simulationCompleted.
  ///
  /// In es, this message translates to:
  /// **'Simulación completada'**
  String get simulationCompleted;

  /// No description provided for @requiredFleet.
  ///
  /// In es, this message translates to:
  /// **'Flota requerida'**
  String get requiredFleet;

  /// No description provided for @dumpTrucks.
  ///
  /// In es, this message translates to:
  /// **'Volquetes'**
  String get dumpTrucks;

  /// No description provided for @fleetBalanceHint.
  ///
  /// In es, this message translates to:
  /// **'Flota sugerida para equilibrar pala y acarreo'**
  String get fleetBalanceHint;

  /// No description provided for @totalProduction.
  ///
  /// In es, this message translates to:
  /// **'Producción total'**
  String get totalProduction;

  /// No description provided for @perShiftHours.
  ///
  /// In es, this message translates to:
  /// **'por turno ({hours} h)'**
  String perShiftHours(String hours);

  /// No description provided for @yieldLabel.
  ///
  /// In es, this message translates to:
  /// **'Rendimiento'**
  String get yieldLabel;

  /// No description provided for @hourlyCapacity.
  ///
  /// In es, this message translates to:
  /// **'capacidad horaria'**
  String get hourlyCapacity;

  /// No description provided for @cycleTimeCaption.
  ///
  /// In es, this message translates to:
  /// **'ida, vuelta y descarga'**
  String get cycleTimeCaption;

  /// No description provided for @perM3Hauled.
  ///
  /// In es, this message translates to:
  /// **'por m³ transportado'**
  String get perM3Hauled;

  /// No description provided for @operationalBreakdown.
  ///
  /// In es, this message translates to:
  /// **'Desglose operativo y factores'**
  String get operationalBreakdown;

  /// No description provided for @swellFactorLabel.
  ///
  /// In es, this message translates to:
  /// **'Factor de esponjamiento'**
  String get swellFactorLabel;

  /// No description provided for @effectiveHopperCapacity.
  ///
  /// In es, this message translates to:
  /// **'Capacidad tolva efectiva'**
  String get effectiveHopperCapacity;

  /// No description provided for @tripsPerUnit.
  ///
  /// In es, this message translates to:
  /// **'Viajes / turno por unidad'**
  String get tripsPerUnit;

  /// No description provided for @tripsUnit.
  ///
  /// In es, this message translates to:
  /// **'viajes'**
  String get tripsUnit;

  /// No description provided for @modifyParameters.
  ///
  /// In es, this message translates to:
  /// **'Modificar parámetros'**
  String get modifyParameters;

  /// No description provided for @swellFactorValue.
  ///
  /// In es, this message translates to:
  /// **'{factor} (+{percent}%)'**
  String swellFactorValue(String factor, String percent);

  /// No description provided for @invalidPositiveNumber.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un número mayor a 0'**
  String get invalidPositiveNumber;

  /// No description provided for @invalidSpeedRange.
  ///
  /// In es, this message translates to:
  /// **'La velocidad debe ser mayor a 0 y hasta 120 km/h'**
  String get invalidSpeedRange;

  /// No description provided for @invalidEfficiencyRange.
  ///
  /// In es, this message translates to:
  /// **'La eficiencia debe ser mayor a 0 y hasta 1'**
  String get invalidEfficiencyRange;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @deleteCalculationTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar cálculo'**
  String get deleteCalculationTitle;

  /// No description provided for @deleteCalculationMessage.
  ///
  /// In es, this message translates to:
  /// **'Este cálculo se eliminará de tu historial. Esta acción no se puede deshacer.'**
  String get deleteCalculationMessage;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar cuenta'**
  String get deleteAccountTitle;

  /// No description provided for @signOutTitle.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get signOutTitle;

  /// No description provided for @signOutMessage.
  ///
  /// In es, this message translates to:
  /// **'Se cerrará tu sesión en este dispositivo. Podrás volver a entrar cuando quieras.'**
  String get signOutMessage;
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
