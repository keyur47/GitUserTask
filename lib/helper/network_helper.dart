import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:task/utils/app_config.dart';
import 'exception_handler.dart';

class NetworkAPICall {
  static final NetworkAPICall _networkAPICall = NetworkAPICall._internal();

  factory NetworkAPICall() {
    return _networkAPICall;
  }

  static Client get httpClient => InterceptedClient.build(
        interceptors: [
          LoggerInterceptor(),
        ],
        retryPolicy: ExpiredTokenRetryPolicy(),
      );

  NetworkAPICall._internal();

  static String BASE_URL = AppConfig.BASE_URL;

  Future<dynamic> get(String url, {Map<String, String>? header, bool isToken = true}) async {
    try {
      final String fullURL = BASE_URL + url;
      log('API Url: $fullURL');
      log('API header: $header');
      final response = await httpClient
          .get(
        Uri.parse(fullURL),
        headers: header,
      )
          .timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  dynamic checkResponse(http.Response response) {
    try {
      if (response.body.isEmpty) {
        throw AppException(message: 'Response body is empty', errorCode: 0);
      }
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      bool isSuccess = true;
      try {
        isSuccess = json['success'] ?? false;
      } catch (e) {
        log(e.toString());
      }
      if (response.statusCode == 200) {
        isSuccess = true;
      }
      if (response.statusCode == 500) {}
      if (response.statusCode == 400) {}
      if (response.statusCode == 401) {}

      return json;
    } catch (e) {
      rethrow;
    }
  }
}

class LoggerInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401) {
    }
    return data;
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    return false;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      ///token expire to call
      return true;
    }
    return false;
  }
}
