import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../ui/cubit/auth/forgot_password_email/forgot_password_email_cubit.dart';
import '../../../ui/cubit/auth/forgot_password_otp/forgot_password_otp_cubit.dart';
import '../../../ui/cubit/auth/forgot_password_reset/forgot_password_reset_cubit.dart';
import '../../../ui/cubit/auth/login/login_cubit.dart';
import '../../../ui/cubit/auth/register_otp/register_otp_cubit.dart';
import '../../../ui/cubit/auth/verify_register/verify_register_cubit.dart';
import '../../../ui/views/auth/forgot_password_email/forgot_password_email.dart';
import '../../../ui/views/auth/forgot_password_otp/forgot_password_otp.dart';
import '../../../ui/views/auth/forgot_password_reset/forgot_password_reset.dart';
import '../../../ui/views/auth/login/login.dart';
import '../../../ui/views/auth/register/register.dart';
import '../../../ui/views/auth/register_otp/register_otp.dart';
import '../../../ui/views/home/home.dart';
import '../../../ui/views/splash/splash.dart';
import '../../constants/app_routes.dart';
import '../injection/di.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(path: AppRoutes.splash.path, builder: (context, state) => const SplashPage()),
      GoRoute(
        path: AppRoutes.login.path,
        builder: (context, state) => BlocProvider(create: (context) => getIt<LoginCubit>(), child: LoginPage()),
      ),
      GoRoute(
        path: AppRoutes.register.path,
        builder:
            (context, state) => BlocProvider(create: (context) => getIt<RegisterOtpCubit>(), child: RegisterPage()),
      ),
      GoRoute(
        path: AppRoutes.registerOtp.path,
        builder:
            (context, state) =>
                BlocProvider(create: (context) => getIt<VerifyRegisterCubit>(), child: RegisterOtpPage()),
      ),
      GoRoute(
        path: AppRoutes.forgotPasswordEmail.path,
        builder:
            (context, state) =>
                BlocProvider(create: (context) => getIt<ForgotPasswordEmailCubit>(), child: ForgotPasswordEmailPage()),
      ),
      GoRoute(
        path: AppRoutes.forgotPasswordOtp.path,
        builder:
            (context, state) =>
                BlocProvider(create: (context) => getIt<ForgotPasswordOtpCubit>(), child: ForgotPasswordOtpPage()),
      ),
      GoRoute(
        path: AppRoutes.forgotPasswordReset.path,
        builder:
            (context, state) =>
                BlocProvider(create: (context) => getIt<ForgotPasswordResetCubit>(), child: ForgotPasswordResetPage()),
      ),
      GoRoute(path: AppRoutes.home.path, builder: (context, state) => const HomePage()),
    ],
  );
}
