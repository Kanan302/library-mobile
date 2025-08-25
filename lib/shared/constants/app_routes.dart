enum AppRoutes {
  splash('/splash'),
  login('/login'),
  register('/register'),
  registerOtp('/registerOtp'),
  forgotPasswordEmail('/forgotPasswordEmail'),
  forgotPasswordOtp('/forgotPasswordOtp'),
  forgotPasswordReset('/forgotPasswordReset'),
  home('/home'),
  bookDetails('/bookDetails'),
  authorDetails('/authorDetails'),
  categoryDetails('/categoryDetails'),
  createBook('/createBook'),
  createAuthor('/createAuthor'),
  createCategory('/createCategory');

  const AppRoutes(this.path);

  final String path;
}
