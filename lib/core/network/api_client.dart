import 'package:dio/dio.dart';
import 'package:vehicle_calculator/core/error/api_exception.dart';
import 'package:vehicle_calculator/core/storage/token_storage.dart';

class ApiClient {
  ApiClient({
    required this._languageCode,
    required this._tokenStorage,
    required this._dio,
    Interceptor? logInterceptor,
  }) {
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: _onRequest),
    );
    if (logInterceptor != null) {
      _dio.interceptors.add(logInterceptor);
    }
  }

  final String Function() _languageCode;
  final TokenStorage _tokenStorage;
  final Dio _dio;

  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = _languageCode();

    final skipAuth = options.extra['skipAuth'] == true;
    final token = _tokenStorage.accessToken;
    if (!skipAuth && token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  Future<T> post<T>(
    String path, {
    Object? data,
    bool skipAuth = false,
    required T Function(dynamic data) parse,
  }) {
    return _send(
      () => _dio.post<dynamic>(
        path,
        data: data,
        options: Options(extra: {'skipAuth': skipAuth}),
      ),
      parse,
    );
  }

  Future<T> get<T>(
    String path, {
    bool skipAuth = false,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) parse,
  }) {
    return _send(
      () => _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: Options(extra: {'skipAuth': skipAuth}),
      ),
      parse,
    );
  }

  Future<void> delete(
    String path, {
    bool skipAuth = false,
  }) async {
    try {
      final response = await _dio.delete<dynamic>(
        path,
        options: Options(extra: {'skipAuth': skipAuth}),
      );
      if (response.statusCode == 204) return;
      if (response.data is Map<String, dynamic> &&
          response.data['success'] == true) {
        return;
      }
      throw const ApiException(message: 'Respuesta inválida del servidor.');
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  Future<T> _send<T>(
    Future<Response<dynamic>> Function() request,
    T Function(dynamic data) parse,
  ) async {
    try {
      final response = await request();
      return await Future<T>.value(_unwrap(response, parse));
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  T _unwrap<T>(Response<dynamic> response, T Function(dynamic data) parse) {
    final payload = response.data;
    if (payload is! Map<String, dynamic>) {
      throw const ApiException(message: 'Respuesta inválida del servidor.');
    }

    if (payload['success'] == true) {
      return parse(payload['data']);
    }

    throw ApiException(
      message: _normalizeMessage(payload['message']),
      errorCode: payload['errorCode'] as String?,
      statusCode: response.statusCode,
    );
  }

  ApiException _mapDioException(DioException error) {
    final payload = error.response?.data;
    if (payload is Map) {
      return ApiException(
        message: _normalizeMessage(payload['message']),
        errorCode: payload['errorCode'] as String?,
        statusCode: error.response?.statusCode ?? payload['statusCode'] as int?,
      );
    }

    return ApiException(
      message: error.message ?? 'No se pudo conectar con el servidor.',
      statusCode: error.response?.statusCode,
    );
  }

  String _normalizeMessage(dynamic message) {
    if (message is List) {
      return message.map((item) => item.toString()).join('\n');
    }
    if (message is String && message.isNotEmpty) {
      return message.replaceAll('<br>', '\n');
    }
    return 'No se pudo completar la solicitud.';
  }
}
