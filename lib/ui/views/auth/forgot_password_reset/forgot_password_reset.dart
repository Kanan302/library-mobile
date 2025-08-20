import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../../../../data/entity/auth/forgot_password_reset/forgot_password_reset_entity.dart';
import '../../../../shared/constants/app_routes.dart';
import '../../../cubit/auth/forgot_password_reset/forgot_password_reset_cubit.dart';
import '../../../shared/constants/ui_colors.dart';
import '../../../shared/constants/ui_icons.dart';
import '../../../shared/constants/ui_strings.dart';
import '../../../shared/constants/ui_validators.dart';
import '../../../shared/widgets/app_elevated_button.dart';
import '../../../shared/widgets/app_text_form_field.dart';

class ForgotPasswordResetPage extends StatefulWidget {
  const ForgotPasswordResetPage({super.key});

  @override
  State<ForgotPasswordResetPage> createState() => _ForgotPasswordResetPageState();
}

class _ForgotPasswordResetPageState extends State<ForgotPasswordResetPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();
  final ValueNotifier<bool> _isNewPasswordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isConfirmNewPasswordVisible = ValueNotifier<bool>(false);

  void _forgotPasswordReset() {
    if (_formKey.currentState?.validate() ?? false) {
      final entity = ForgotPasswordResetEntity(newPassword: _newPasswordController.text.trim());

      final cubit = context.read<ForgotPasswordResetCubit>();
      cubit.forgotPasswordReset(entity);
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
                40.vertical(context),
                SvgPicture.asset(UiIcons.logo),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 17.height(context),
                      children: [
                        30.vertical(context),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            UiStrings.writeYourNewPassword,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isNewPasswordVisible,
                          builder: (context, isVisible, child) {
                            return AppTextFormField(
                              controller: _newPasswordController,
                              obscureText: !isVisible,
                              hintText: UiStrings.yourNewPassword,
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: isVisible ? Icons.visibility : Icons.visibility_off,
                              onPressed: () {
                                _isNewPasswordVisible.value = !_isNewPasswordVisible.value;
                              },
                              validator: (value) => UiValidators.writePassword(value),
                            );
                          },
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isConfirmNewPasswordVisible,
                          builder: (context, isConfirmVisible, child) {
                            return AppTextFormField(
                              controller: _confirmNewPasswordController,
                              obscureText: !isConfirmVisible,
                              hintText: UiStrings.confirmYourNewPassword,
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: isConfirmVisible ? Icons.visibility : Icons.visibility_off,
                              onPressed: () {
                                _isConfirmNewPasswordVisible.value = !_isConfirmNewPasswordVisible.value;
                              },
                              validator: (value) => UiValidators.confirmPassword(value, _newPasswordController),
                            );
                          },
                        ),
                        1.vertical(context),
                        Row(
                          spacing: 20,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.height(context),
                                child: AppElevatedButton(
                                  buttonColor: UiColors.white,
                                  onPressed: () => context.pop(),
                                  text: UiStrings.back,
                                  textColor: UiColors.primaryColor,
                                  sideColor: UiColors.primaryColor,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            BlocConsumer<ForgotPasswordResetCubit, ForgotPasswordResetState>(
                              listener: (context, state) {
                                if (state is ForgotPasswordResetSuccess) {
                                  context.go(AppRoutes.login.path);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: UiColors.black,
                                      content: Text("Şifrə uğurla yeniləndi", style: TextStyle(color: UiColors.white)),
                                    ),
                                  );
                                } else if (state is ForgotPasswordResetError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: UiColors.error,
                                      content: Text(state.errorMessage, style: TextStyle(color: UiColors.white)),
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50.height(context),
                                    child: AppElevatedButton(
                                      buttonColor: UiColors.primaryColor,
                                      onPressed: () => _forgotPasswordReset(),
                                      text: UiStrings.verification,
                                      textColor: UiColors.white,
                                      fontSize: 17,
                                      isLoading: state is ForgotPasswordResetLoading,
                                    ),
                                  ),
                                );
                              },
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
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _isNewPasswordVisible.dispose();
    _isConfirmNewPasswordVisible.dispose();
    super.dispose();
  }
}
