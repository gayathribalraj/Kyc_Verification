/*
  @author   : Gayathri
  @created  : 08/11/2025
  @desc     : Refactored ApiClient with improved error handling and dependency injection
*/

import 'package:sysmo_verification/kyc_validation.dart';

/// HttpHeaderConfig holds default headers for API requests
class HttpHeaderConfig {
  static const Map<String, String> defaultHeaders = {
    'clientID': '220',
    'productID': '1',
    'appno': '100050000000004',
    'module': 'MSME',
    'branch': 'Chennai',
    'user': 'user845',
    'cp-client-trans-id': '1763037635616',
    'cbsid': '',
  };
}

/// Refactored ApiClient with better separation of concerns
class ApiClient {
  final Dio dio;
  final bool enableLogging;

  ApiClient({
    Dio? dioInstance,
    this.enableLogging = true,
  }) : dio = dioInstance ?? Dio() {
    _configureClient();
  }

  /// Configure Dio with default headers and interceptors
  void _configureClient() {
    dio.options.headers = HttpHeaderConfig.defaultHeaders;

    if (enableLogging) {
      dio.interceptors.add(
        PrettyDioLogger(
          responseHeader: true,
          responseBody: true,
          requestHeader: true,
          requestBody: true,
          request: true,
          compact: false,
        ),
      );
    }
  }

  /// Perform POST request with optional data
  Future<Response> post(String url, {dynamic data}) async {
    try {
      return await dio.post(url, data: data);
    } catch (e) {
      rethrow;
    }
  }

  /// Perform GET request
  Future<Response> get(String url) async {
    try {
      return await dio.get(url);
    } catch (e) {
      rethrow;
    }
  }

  /// Deprecated methods kept for backward compatibility
  @deprecated
  Future<Response> callPost(String url, {data}) => post(url, data: data);

  @deprecated
  Future<Response> callGet(String url) => get(url);
}
