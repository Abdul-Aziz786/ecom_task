import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Simplified API client with retry logic and error handling
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal() {
    _initDio();
  }

  late final Dio _dio;
  final Logger _logger = Logger();

  // Expose Dio instance for Retrofit
  Dio get dio => _dio;

  static const String baseUrl = 'https://api.stryce.com';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.addAll([
      _loggingInterceptor(),
      _authInterceptor(),
      _retryInterceptor(),
      _errorInterceptor(),
    ]);

    _logger.i('API Client initialized with base URL: $baseUrl');
  }

  /// Logging interceptor for debugging
  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        _logger.d('''
📤 REQUEST [${options.method}] ${options.uri}
Headers: ${options.headers}
Data: ${options.data}
        ''');
        handler.next(options);
      },
      onResponse: (response, handler) {
        _logger.d('''
📥 RESPONSE [${response.statusCode}] ${response.requestOptions.uri}
Data: ${response.data}
        ''');
        handler.next(response);
      },
      onError: (error, handler) {
        _logger.e('''
❌ ERROR [${error.response?.statusCode}] ${error.requestOptions.uri}
Message: ${error.message}
Data: ${error.response?.data}
        ''');
        handler.next(error);
      },
    );
  }

  /// Auth interceptor for adding tokens
  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token if available (mocked for now)
        // final token = StorageService().getToken();
        // if (token != null) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }
        handler.next(options);
      },
    );
  }

  /// Retry interceptor with exponential backoff
  Interceptor _retryInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        final requestOptions = error.requestOptions;
        final retryCount = requestOptions.extra['retryCount'] ?? 0;

        // Only retry on network errors or 5xx errors
        final shouldRetry =
            (error.type == DioExceptionType.connectionTimeout ||
                error.type == DioExceptionType.receiveTimeout ||
                error.type == DioExceptionType.sendTimeout ||
                (error.response?.statusCode ?? 0) >= 500) &&
            retryCount < maxRetries;

        if (shouldRetry) {
          requestOptions.extra['retryCount'] = retryCount + 1;

          // Exponential backoff
          final delay = Duration(
            milliseconds: (1000 * (retryCount + 1)).toInt(),
          );
          _logger.w(
            'Retrying request (${retryCount + 1}/$maxRetries) after ${delay.inMilliseconds}ms...',
          );

          await Future.delayed(delay);

          try {
            final response = await _dio.fetch(requestOptions);
            handler.resolve(response);
          } catch (e) {
            handler.next(error);
          }
        } else {
          handler.next(error);
        }
      },
    );
  }

  /// Error interceptor for handling common errors
  Interceptor _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        String errorMessage;

        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            errorMessage = 'Connection timeout. Please try again.';
            break;
          case DioExceptionType.badResponse:
            errorMessage = _handleHttpError(error.response?.statusCode);
            break;
          case DioExceptionType.cancel:
            errorMessage = 'Request cancelled';
            break;
          default:
            errorMessage = 'Network error. Please check your connection.';
        }

        error = error.copyWith(error: errorMessage);

        handler.next(error);
      },
    );
  }

  String _handleHttpError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Access forbidden.';
      case 404:
        return 'Resource not found.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
      case 502:
      case 503:
        return 'Server error. Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
