enum AppRoutes {
  splash('/splash'),
  login('/login'),
  register('/register'),
  registerOtp('/registerOtp'),
  forgotPasswordEmail('/forgotPasswordEmail'),
  forgotPasswordOtp('/forgotPasswordOtp'),
  forgotPasswordReset('/forgotPasswordReset'),
  home('/home');

  const AppRoutes(this.path);

  final String path;
}
