import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../../constants/app_keys.dart';
import '../injection/di.dart';
import 'jwt_interceptor.dart';

final baseDio =
    Dio()
      ..options = BaseOptions(
        baseUrl: AppKeys.baseUrl,
        contentType: 'application/json',
        // connectTimeout: const Duration(seconds: 6),
        // receiveTimeout: const Duration(seconds: 12),
        validateStatus: (status) {
          return status != null && status >= 200 && status < 300;
          // return status != null && status >= 200 && status < 600;
        },
      )
      ..interceptors.add(getIt<JwtInterceptor>())
      ..interceptors.add(AwesomeDioInterceptor())
      ..transformer = BackgroundTransformer();
