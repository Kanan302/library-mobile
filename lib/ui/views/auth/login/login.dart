import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../../../../data/entity/auth/login/login_entity.dart';
import '../../../../shared/constants/app_routes.dart';
import '../../../cubit/auth/login/login_cubit.dart';
import '../../../shared/constants/ui_colors.dart';
import '../../../shared/constants/ui_icons.dart';
import '../../../shared/constants/ui_strings.dart';
import '../../../shared/constants/ui_validators.dart';
import '../../../shared/widgets/app_elevated_button.dart';
import '../../../shared/widgets/app_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      final entity = LoginEntity(email: _emailController.text.trim(), password: _passwordController.text.trim());

      final cubit = context.read<LoginCubit>();
      cubit.login(entity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                70.vertical(context),
                SvgPicture.asset(UiIcons.logo),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 13.height(context),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(UiStrings.login, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                        ),
                        AppTextFormField(
                          controller: _emailController,
                          obscureText: false,
                          hintText: UiStrings.abc,
                          prefixIcon: Icons.email_outlined,
                          validator: (value) => UiValidators.writeMail(value),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isPasswordVisible,
                          builder: (context, isVisible, child) {
                            return AppTextFormField(
                              controller: _passwordController,
                              obscureText: !isVisible,
                              hintText: UiStrings.yourPassword,
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: isVisible ? Icons.visibility : Icons.visibility_off,
                              onPressed: () {
                                _isPasswordVisible.value = !_isPasswordVisible.value;
                              },
                              validator: (value) => UiValidators.writePassword(value),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => context.push(AppRoutes.forgotPasswordEmail.path),
                            child: Text(UiStrings.forgotPassword),
                          ),
                        ),
                        1.vertical(context),
                        BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              context.go(AppRoutes.home.path);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: UiColors.black,
                                  content: Text("Hesab yaradıldı", style: TextStyle(color: UiColors.white)),
                                ),
                              );
                            } else if (state is LoginError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: UiColors.error,
                                  content: Text(state.errorMessage, style: TextStyle(color: UiColors.white)),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 50.height(context),
                              child: AppElevatedButton(
                                buttonColor: UiColors.primaryColor,
                                onPressed: () => _login(),
                                text: UiStrings.login,
                                textColor: UiColors.white,
                                fontSize: 17,
                                isLoading: state is LoginLoading,
                              ),
                            );
                          },
                        ),
                        5.vertical(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(UiStrings.noAccount, style: TextStyle(fontSize: 17)),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () => context.push(AppRoutes.register.path),
                              child: Text(
                                UiStrings.register,
                                style: TextStyle(color: UiColors.primaryColor, fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }
}
