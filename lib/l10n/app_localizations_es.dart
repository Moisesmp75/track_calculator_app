// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get academicPortal => 'PORTAL ACADÉMICO';

  @override
  String get appName => 'SmartHaul';

  @override
  String get appBrandSubtitle => 'Transporte inteligente';

  @override
  String get appTagline =>
      'Optimización de ciclo, pala y tolvas para minería e ingeniería civil';

  @override
  String appVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get institutionalEmail => 'Correo';

  @override
  String get emailHint => 'alumno@uni.edu.pe';

  @override
  String get emailRequired => 'Ingresa tu correo';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordHint => '********';

  @override
  String get passwordRequired => 'Ingresa tu contraseña';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get noAccount => '¿Aún no tienes una cuenta?';

  @override
  String get registerHere => 'Regístrate aquí';

  @override
  String get toggleTheme => 'Cambiar tema';

  @override
  String get toggleLanguage => 'Cambiar idioma';

  @override
  String get newAccount => 'NUEVA CUENTA';

  @override
  String get createAccount => 'Crear Cuenta';

  @override
  String get registerTagline =>
      'Ingresa tus datos personales para acceder a la calculadora y simulaciones de transporte minero.';

  @override
  String get firstNames => 'Nombres';

  @override
  String get firstNamesHint => 'Ej. Juan';

  @override
  String get lastNames => 'Apellidos';

  @override
  String get lastNamesHint => 'Ej. Pérez';

  @override
  String get birthDate => 'Fecha de Nacimiento';

  @override
  String get birthDateHint => 'dd/mm/aaaa';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get emailPersonalHint => 'juan.perez@email.com';

  @override
  String get confirmPassword => 'Confirmar Contraseña';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get settings => 'Ajustes';

  @override
  String get configuration => 'Configuración';

  @override
  String get settingsSubtitle =>
      'Preferencias de la aplicación e información de la cuenta';

  @override
  String get editPersonalData => 'Editar datos personales';

  @override
  String get editPersonalDataSubtitle =>
      'Editar datos personales, correo electrónico y contraseña';

  @override
  String get interfacePreferences => 'PREFERENCIAS DE INTERFAZ';

  @override
  String get systemLanguage => 'Idioma del Sistema';

  @override
  String get spanishActive => 'Español activo';

  @override
  String get englishActive => 'English activo';

  @override
  String get spanishPe => 'Español (PE)';

  @override
  String get englishUs => 'English (US)';

  @override
  String get visualAppearance => 'Apariencia Visual';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get accountAndSecurity => 'CUENTA Y SEGURIDAD';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get passwordLastModified => 'Última modificación hace 3 meses';

  @override
  String get signOut => 'Cerrar Sesión';

  @override
  String get dangerZone => 'Zona de Riesgo';

  @override
  String get deleteAccountWarning =>
      'Al borrar tu cuenta se borrarán todos tus datos, incluyendo el historial de resultados guardados. Esta acción no puede ser revertida.';

  @override
  String get deleteAccountTwoSteps => 'Eliminar cuenta';

  @override
  String get calculate => 'Calcular';

  @override
  String get haulageSimulation => 'SIMULACIÓN DE ACARREO';

  @override
  String get newCalculation => 'Nuevo Cálculo';

  @override
  String get calculateFleetAndCycle => 'Calcular Flota y Ciclo';

  @override
  String get generalData => 'Datos Generales';

  @override
  String get optional => 'Opcional';

  @override
  String get miningProject => 'Proyecto Minero / Obra';

  @override
  String get miningProjectHint => 'Ej. Tajo Norte';

  @override
  String get transportRoute => 'Ruta de Transporte';

  @override
  String get transportRouteHint => 'Ej. Tramo A-B';

  @override
  String get operationParameters => 'Parámetros de Operación';

  @override
  String get inSituMaterial => 'Material In Situ / Esponjado';

  @override
  String get selectMaterial => 'Selecciona un material';

  @override
  String get haulageUnit => 'Unidad de Acarreo (Volquete)';

  @override
  String get selectUnit => 'Selecciona una unidad';

  @override
  String get outboundDistance => 'Distancia ida';

  @override
  String get loadingYield => 'Rend. Carguío';

  @override
  String get loadedSpeed => 'Vel. Cargado';

  @override
  String get returnSpeed => 'Vel. Retorno';

  @override
  String get shiftHours => 'Jornada Turno';

  @override
  String get efficiency => 'Eficiencia';

  @override
  String get costAnalysis => 'Análisis de Costos';

  @override
  String get estimateUnitRatios => 'Estimar ratios unitarios';

  @override
  String get dumpTruckHourlyRate => 'Costo volquete';

  @override
  String get loaderHourlyRate => 'Costo pala';

  @override
  String get staffHourlyRate => 'Costo personal';

  @override
  String get unitKm => 'km';

  @override
  String get unitKmh => 'km/h';

  @override
  String get unitM3h => 'm³/h';

  @override
  String get unitHours => 'h';

  @override
  String get unitRatio => '0–1';

  @override
  String get unitPerHour => '/h';

  @override
  String get history => 'Historial';

  @override
  String get calculationHistoryTitle => 'Historial de cálculos';

  @override
  String get historySubtitle =>
      'Tus simulaciones y reportes guardados para campo y laboratorio';

  @override
  String get historySynced => 'Sincronizado';

  @override
  String get historyEmpty => 'Aún no tienes cálculos guardados.';

  @override
  String get untitledCalculation => 'Cálculo';

  @override
  String get fieldRequired => 'Este campo es obligatorio';

  @override
  String get networkError =>
      'No se pudo conectar con el servidor. Inténtalo de nuevo.';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get invalidBirthDateFormat => 'Usa el formato dd/mm/aaaa';

  @override
  String get registerSuccess => 'Cuenta creada. Inicia sesión para continuar.';

  @override
  String get invalidEmailFormat => 'Ingresa un correo con formato válido';

  @override
  String get invalidNameFormat => 'Solo letras, sin espacios ni números';

  @override
  String get invalidPasswordFormat =>
      'Mínimo 10 caracteres, con mayúscula, minúscula y número';

  @override
  String get resultDetail => 'Detalle de ciclo';

  @override
  String get missingCalculationResult => 'No hay un resultado para mostrar.';

  @override
  String get suggestedTrucks => 'Volquetes sugeridos';

  @override
  String get cycleTime => 'Tiempo de ciclo';

  @override
  String get tripsPerShift => 'Viajes por turno';

  @override
  String get totalVolume => 'Volumen total';

  @override
  String get hourlyOutput => 'Productividad';

  @override
  String get swellFactor => 'Esponjamiento';

  @override
  String get effectiveCapacity => 'Capacidad efectiva';

  @override
  String get unitCost => 'Costo unitario';

  @override
  String get unitMinutes => 'min';

  @override
  String get unitM3 => 'm³';

  @override
  String get unitPerM3 => '/m³';

  @override
  String get simulationCompleted => 'Simulación completada';

  @override
  String get requiredFleet => 'Flota requerida';

  @override
  String get dumpTrucks => 'Volquetes';

  @override
  String get fleetBalanceHint =>
      'Flota sugerida para equilibrar pala y acarreo';

  @override
  String get totalProduction => 'Producción total';

  @override
  String perShiftHours(String hours) {
    return 'por turno ($hours h)';
  }

  @override
  String get yieldLabel => 'Rendimiento';

  @override
  String get hourlyCapacity => 'capacidad horaria';

  @override
  String get cycleTimeCaption => 'ida, vuelta y descarga';

  @override
  String get perM3Hauled => 'por m³ transportado';

  @override
  String get operationalBreakdown => 'Desglose operativo y factores';

  @override
  String get swellFactorLabel => 'Factor de esponjamiento';

  @override
  String get effectiveHopperCapacity => 'Capacidad tolva efectiva';

  @override
  String get tripsPerUnit => 'Viajes / turno por unidad';

  @override
  String get tripsUnit => 'viajes';

  @override
  String get modifyParameters => 'Modificar parámetros';

  @override
  String swellFactorValue(String factor, String percent) {
    return '$factor (+$percent%)';
  }

  @override
  String get invalidPositiveNumber => 'Ingresa un número mayor a 0';

  @override
  String get invalidSpeedRange =>
      'La velocidad debe ser mayor a 0 y hasta 120 km/h';

  @override
  String get invalidEfficiencyRange =>
      'La eficiencia debe ser mayor a 0 y hasta 1';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteCalculationTitle => 'Eliminar cálculo';

  @override
  String get deleteCalculationMessage =>
      'Este cálculo se eliminará de tu historial. Esta acción no se puede deshacer.';

  @override
  String get deleteAccountTitle => 'Eliminar cuenta';
}
