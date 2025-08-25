import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../data/repository/auth/forgot_password_email/forgot_password_email_repository.dart';
import '../../../data/repository/auth/forgot_password_email/impl/forgot_password_email_repository_impl.dart';
import '../../../data/repository/auth/forgot_password_otp/forgot_password_otp_repository.dart';
import '../../../data/repository/auth/forgot_password_otp/impl/forgot_password_otp_repository_impl.dart';
import '../../../data/repository/auth/forgot_password_reset/forgot_password_reset_repository.dart';
import '../../../data/repository/auth/forgot_password_reset/impl/forgot_password_reset_repository_impl.dart';
import '../../../data/repository/auth/login/impl/login_repository_impl.dart';
import '../../../data/repository/auth/login/login_repository.dart';
import '../../../data/repository/auth/register_otp/impl/register_otp_repository_impl.dart';
import '../../../data/repository/auth/register_otp/register_otp_repository.dart';
import '../../../data/repository/auth/verify_register/impl/verify_register_repository_impl.dart';
import '../../../data/repository/auth/verify_register/verify_register_repository.dart';
import '../../../data/repository/author/delete_author/delete_author_repository.dart';
import '../../../data/repository/author/delete_author/impl/delete_author_repository_impl.dart';
import '../../../data/repository/author/get_authors/get_authors_repository.dart';
import '../../../data/repository/author/get_authors/impl/get_authors_repository_impl.dart';
import '../../../data/repository/book/get_books/get_books_repository.dart';
import '../../../data/repository/book/get_books/impl/get_books_repository_impl.dart';
import '../../../data/repository/category/get_categories/get_categories_repository.dart';
import '../../../data/repository/category/get_categories/impl/get_categories_repository_impl.dart';
import '../../../data/services/auth/auth_api_client.dart';
import '../../../data/services/author/author_api_client.dart';
import '../../../data/services/book/book_api_client.dart';
import '../../../data/services/category/category_api_client.dart';
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
import '../config/dio_config.dart';
import '../config/jwt_interceptor.dart';
import '../local/secure_service.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  /// Service (memory-based)
  getIt.registerLazySingleton<ISecureService>(() => SecureService());

  /// JwtInterceptor
  getIt.registerLazySingleton<JwtInterceptor>(() => JwtInterceptor(getIt<ISecureService>()));

  /// Dio Configuration
  getIt.registerLazySingleton(() => baseDio);

  /// Retrofit (API Client)
  getIt.registerLazySingleton<AuthApiClient>(() => AuthApiClient(getIt<Dio>()));

  getIt.registerLazySingleton<BookApiClient>(() => BookApiClient(getIt<Dio>()));

  getIt.registerLazySingleton<AuthorApiClient>(() => AuthorApiClient(getIt<Dio>()));

  getIt.registerLazySingleton<CategoryApiClient>(() => CategoryApiClient(getIt<Dio>()));

  /// Repository
  getIt.registerLazySingleton<ILoginRepository>(
    () => LoginRepositoryImpl(getIt<AuthApiClient>(), getIt<ISecureService>()),
  );

  getIt.registerLazySingleton<IRegisterOtpRepository>(() => RegisterOtpRepositoryImpl(getIt<AuthApiClient>()));

  getIt.registerLazySingleton<IVerifyRegisterRepository>(() => VerifyRegisterRepositoryImpl(getIt<AuthApiClient>()));

  getIt.registerLazySingleton<IForgotPasswordEmailRepository>(
    () => ForgotPasswordEmailRepositoryImpl(getIt<AuthApiClient>()),
  );

  getIt.registerLazySingleton<IForgotPasswordOtpRepository>(
    () => ForgotPasswordOtpRepositoryImpl(getIt<AuthApiClient>()),
  );

  getIt.registerLazySingleton<IForgotPasswordResetRepository>(
    () => ForgotPasswordResetRepositoryImpl(getIt<AuthApiClient>()),
  );

  getIt.registerLazySingleton<IGetBooksRepository>(() => GetBooksRepositoryImpl(getIt<BookApiClient>()));

  getIt.registerLazySingleton<IGetAuthorsRepository>(() => GetAuthorsRepositoryImpl(getIt<AuthorApiClient>()));

  getIt.registerLazySingleton<IGetCategoriesRepository>(() => GetCategoriesRepositoryImpl(getIt<CategoryApiClient>()));

  getIt.registerLazySingleton<IDeleteAuthorRepository>(() => DeleteAuthorRepositoryImpl(getIt<AuthorApiClient>()));

  /// Cubit
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<ILoginRepository>()));

  getIt.registerFactory<RegisterOtpCubit>(() => RegisterOtpCubit(getIt<IRegisterOtpRepository>()));

  getIt.registerFactory<VerifyRegisterCubit>(() => VerifyRegisterCubit(getIt<IVerifyRegisterRepository>()));

  getIt.registerFactory<ForgotPasswordEmailCubit>(
    () => ForgotPasswordEmailCubit(getIt<IForgotPasswordEmailRepository>()),
  );

  getIt.registerFactory<ForgotPasswordOtpCubit>(() => ForgotPasswordOtpCubit(getIt<IForgotPasswordOtpRepository>()));

  getIt.registerFactory<ForgotPasswordResetCubit>(
    () => ForgotPasswordResetCubit(getIt<IForgotPasswordResetRepository>()),
  );

  getIt.registerFactory<GetBooksCubit>(() => GetBooksCubit(getIt<IGetBooksRepository>()));

  getIt.registerFactory<GetAuthorsCubit>(() => GetAuthorsCubit(getIt<IGetAuthorsRepository>()));

  getIt.registerFactory<GetCategoriesCubit>(() => GetCategoriesCubit(getIt<IGetCategoriesRepository>()));

  getIt.registerFactory<DeleteAuthorCubit>(() => DeleteAuthorCubit(getIt<IDeleteAuthorRepository>()));
}
