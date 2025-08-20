import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_keys.dart';
import '../../constants/app_routes.dart';
import '../local/secure_service.dart';
import '../navigation/app_router.dart';

class JwtInterceptor extends Interceptor {
  final ISecureService _secureService;

  JwtInterceptor(this._secureService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _secureService.getAccessToken;
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers[AppKeys.accessToken] = accessToken;
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      final ctx = navigatorKey.currentContext;
      if (ctx != null) {
        ctx.go(AppRoutes.login.path);
      }
    }
    super.onError(err, handler);
  }
}
