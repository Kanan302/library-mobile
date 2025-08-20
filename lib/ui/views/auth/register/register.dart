import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../../../../data/entity/auth/register_otp/register_otp_entity.dart';
import '../../../../shared/constants/app_routes.dart';
import '../../../cubit/auth/register_otp/register_otp_cubit.dart';
import '../../../shared/constants/ui_colors.dart';
import '../../../shared/constants/ui_icons.dart';
import '../../../shared/constants/ui_strings.dart';
import '../../../shared/constants/ui_validators.dart';
import '../../../shared/widgets/app_elevated_button.dart';
import '../../../shared/widgets/app_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isConfirmPasswordVisible = ValueNotifier<bool>(false);

  void _sendRegisterOtp() {
    if (_formKey.currentState?.validate() ?? false) {
      final entity = RegisterOtpEntity(email: _emailController.text.trim(), password: _passwordController.text.trim());

      final cubit = context.read<RegisterOtpCubit>();
      cubit.sendRegisterOtp(entity);
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
                10.vertical(context),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 13.height(context),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(UiStrings.register, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
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
                        ValueListenableBuilder<bool>(
                          valueListenable: _isConfirmPasswordVisible,
                          builder: (context, isConfirmVisible, child) {
                            return AppTextFormField(
                              controller: _confirmPasswordController,
                              obscureText: !isConfirmVisible,
                              hintText: UiStrings.confirmYourPassword,
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: isConfirmVisible ? Icons.visibility : Icons.visibility_off,
                              onPressed: () {
                                _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;
                              },
                              validator: (value) => UiValidators.confirmPassword(value, _passwordController),
                            );
                          },
                        ),
                        1.vertical(context),
                        BlocConsumer<RegisterOtpCubit, RegisterOtpState>(
                          listener: (context, state) {
                            if (state is RegisterOtpSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: UiColors.black,
                                  content: Text("OTP kod e-poçt ünvanına göndərildi", style: TextStyle(color: UiColors.white)),
                                ),
                              );
                              context.push(AppRoutes.registerOtp.path);
                            } else if (state is RegisterOtpError) {
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
                                onPressed: () => _sendRegisterOtp(),
                                text: UiStrings.register,
                                textColor: UiColors.white,
                                fontSize: 17,
                                isLoading: state is RegisterOtpLoading,
                              ),
                            );
                          },
                        ),
                        5.vertical(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(UiStrings.alreadyHaveAccount, style: TextStyle(fontSize: 17)),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () => context.pop(),
                              child: Text(
                                UiStrings.login,
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
    _confirmPasswordController.dispose();
    _isPasswordVisible.dispose();
    _isConfirmPasswordVisible.dispose();
    super.dispose();
  }
}
