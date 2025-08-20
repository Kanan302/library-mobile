import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../../../../data/entity/auth/forgot_password_email/forgot_password_email_entity.dart';
import '../../../../shared/constants/app_routes.dart';
import '../../../cubit/auth/forgot_password_email/forgot_password_email_cubit.dart';
import '../../../shared/constants/ui_colors.dart';
import '../../../shared/constants/ui_icons.dart';
import '../../../shared/constants/ui_strings.dart';
import '../../../shared/constants/ui_validators.dart';
import '../../../shared/widgets/app_elevated_button.dart';
import '../../../shared/widgets/app_text_form_field.dart';

class ForgotPasswordEmailPage extends StatefulWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  State<ForgotPasswordEmailPage> createState() => _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _forgotPasswordEmail() {
    if (_formKey.currentState?.validate() ?? false) {
      final entity = ForgotPasswordEmailEntity(email: _emailController.text.trim());

      final cubit = context.read<ForgotPasswordEmailCubit>();
      cubit.forgotPasswordEmail(entity);
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
                            UiStrings.emailVerification,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                        ),
                        AppTextFormField(
                          controller: _emailController,
                          obscureText: false,
                          hintText: UiStrings.abc,
                          prefixIcon: Icons.email_outlined,
                          validator: (value) => UiValidators.writeMail(value),
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
                            BlocConsumer<ForgotPasswordEmailCubit, ForgotPasswordEmailState>(
                              listener: (context, state) {
                                if (state is ForgotPasswordEmailSuccess) {
                                  context.push(AppRoutes.forgotPasswordOtp.path);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: UiColors.black,
                                      content: Text(
                                        "OTP kod e-poçt ünvanına göndərildi",
                                        style: TextStyle(color: UiColors.white),
                                      ),
                                    ),
                                  );
                                } else if (state is ForgotPasswordEmailError) {
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
                                      onPressed: () => _forgotPasswordEmail(),
                                      text: UiStrings.login,
                                      textColor: UiColors.white,
                                      fontSize: 17,
                                      isLoading: state is ForgotPasswordEmailLoading,
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Expanded(
                            //   child: SizedBox(
                            //     width: double.infinity,
                            //     height: 50.height(context),
                            //     child: AppElevatedButton(
                            //       buttonColor: UiColors.primaryColor,
                            //       onPressed: () => context.push(AppRoutes.forgotPasswordOtp.path),
                            //       text: UiStrings.login,
                            //       textColor: UiColors.white,
                            //       fontSize: 17,
                            //     ),
                            //   ),
                            // )
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
    super.dispose();
  }
}
