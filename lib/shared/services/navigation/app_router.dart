import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/entity/author/get_authors/get_authors_entity.dart';
import '../../../data/entity/book/get_books/get_books_entity.dart';
import '../../../data/entity/category/get_categories/get_categories_entity.dart';
import '../../../ui/cubit/auth/forgot_password_email/forgot_password_email_cubit.dart';
import '../../../ui/cubit/auth/forgot_password_otp/forgot_password_otp_cubit.dart';
import '../../../ui/cubit/auth/forgot_password_reset/forgot_password_reset_cubit.dart';
import '../../../ui/cubit/auth/login/login_cubit.dart';
import '../../../ui/cubit/auth/register_otp/register_otp_cubit.dart';
import '../../../ui/cubit/auth/verify_register/verify_register_cubit.dart';
import '../../../ui/cubit/author/delete_author/delete_author_cubit.dart';
import '../../../ui/cubit/author/get_authors/get_authors_cubit.dart';
import '../../../ui/cubit/book/get_books/get_books_cubit.dart';
import '../../../ui/cubit/category/get_categories/get_categories_cubit.dart';
import '../../../ui/shared/constants/ui_strings.dart';
import '../../../ui/views/auth/forgot_password_email/forgot_password_email.dart';
import '../../../ui/views/auth/forgot_password_otp/forgot_password_otp.dart';
import '../../../ui/views/auth/forgot_password_reset/forgot_password_reset.dart';
import '../../../ui/views/auth/login/login.dart';
import '../../../ui/views/auth/register/register.dart';
import '../../../ui/views/auth/register_otp/register_otp.dart';
import '../../../ui/views/home/home.dart';
import '../../../ui/views/home/pages/authors/pages/author_details_page.dart';
import '../../../ui/views/home/pages/authors/pages/create_author_page.dart';
import '../../../ui/views/home/pages/books/pages/book_details_page.dart';
import '../../../ui/views/home/pages/books/pages/create_book_page.dart';
import '../../../ui/views/home/pages/categories/pages/category_details_page.dart';
import '../../../ui/views/home/pages/categories/pages/create_category_page.dart';
import '../../../ui/views/splash/splash.dart';
import '../../constants/app_routes.dart';
import '../injection/di.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home.path,
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
      GoRoute(
        path: AppRoutes.home.path,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<GetBooksCubit>()),
                BlocProvider(create: (context) => getIt<GetAuthorsCubit>()),
                BlocProvider(create: (context) => getIt<GetCategoriesCubit>()),
                BlocProvider(create: (context) => getIt<DeleteAuthorCubit>()),
              ],
              child: HomePage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.bookDetails.path,
        builder: (context, state) {
          final book = state.extra as GetBookEntity?;
          if (book == null) {
            return const Scaffold(body: Center(child: Text(UiStrings.dataNotFound)));
          }
          return BookDetailsPage(book: book);
        },
      ),
      GoRoute(
        path: AppRoutes.authorDetails.path,
        builder: (context, state) {
          final author = state.extra as GetAuthorsEntity?;
          if (author == null) {
            return const Scaffold(body: Center(child: Text(UiStrings.dataNotFound)));
          }
          return AuthorDetailsPage(author: author);
        },
      ),
      GoRoute(
        path: AppRoutes.categoryDetails.path,
        builder: (context, state) {
          final category = state.extra as GetCategoryEntity?;
          if (category == null) {
            return const Scaffold(body: Center(child: Text(UiStrings.dataNotFound)));
          }
          return CategoryDetailsPage(category: category);
        },
      ),
      GoRoute(path: AppRoutes.createBook.path, builder: (context, state) => const CreateBookPage()),
      GoRoute(path: AppRoutes.createAuthor.path, builder: (context, state) => const CreateAuthorPage()),
      GoRoute(
        path: AppRoutes.createCategory.path,
        builder:
            (context, state) => BlocProvider(create: (context) => getIt<GetBooksCubit>(), child: CreateCategoryPage()),
      ),
    ],
  );
}
