import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../../../../data/entity/auth/forgot_password_otp/forgot_password_otp_entity.dart';
import '../../../../shared/constants/app_routes.dart';
import '../../../cubit/auth/forgot_password_otp/forgot_password_otp_cubit.dart';
import '../../../shared/constants/ui_colors.dart';
import '../../../shared/constants/ui_icons.dart';
import '../../../shared/constants/ui_strings.dart';
import '../../../shared/constants/ui_validators.dart';
import '../../../shared/widgets/app_elevated_button.dart';
import '../widgets/otp_text_form_field.dart';

class ForgotPasswordOtpPage extends StatefulWidget {
  const ForgotPasswordOtpPage({super.key});

  @override
  State<ForgotPasswordOtpPage> createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();
  final TextEditingController _fifthController = TextEditingController();

  final FocusNode _firstFocus = FocusNode();
  final FocusNode _secondFocus = FocusNode();
  final FocusNode _thirdFocus = FocusNode();
  final FocusNode _fourthFocus = FocusNode();
  final FocusNode _fifthFocus = FocusNode();

  void _forgotPasswordOtp() {
    if (_formKey.currentState?.validate() ?? false) {
      final entity = ForgotPasswordOtpEntity(
        otpCode:
            _firstController.text.trim() +
            _secondController.text.trim() +
            _thirdController.text.trim() +
            _fourthController.text.trim() +
            _fifthController.text.trim(),
      );

      final cubit = context.read<ForgotPasswordOtpCubit>();
      cubit.forgotPasswordOtp(entity);
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
                            UiStrings.writeOtpCode,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(
                          spacing: 7.width(context),
                          children: [
                            Expanded(
                              child: OtpTextFormField(
                                controller: _firstController,
                                nextController: _secondController,
                                focusNode: _firstFocus,
                                nextFocusNode: _secondFocus,
                                validator: (value) => UiValidators.writeOtp(value),
                              ),
                            ),
                            Expanded(
                              child: OtpTextFormField(
                                controller: _secondController,
                                nextController: _thirdController,
                                previousController: _firstController,
                                focusNode: _secondFocus,
                                nextFocusNode: _thirdFocus,
                                previousFocusNode: _firstFocus,
                                validator: (value) => UiValidators.writeOtp(value),
                              ),
                            ),
                            Expanded(
                              child: OtpTextFormField(
                                controller: _thirdController,
                                nextController: _fourthController,
                                previousController: _secondController,
                                focusNode: _thirdFocus,
                                nextFocusNode: _fourthFocus,
                                previousFocusNode: _secondFocus,
                                validator: (value) => UiValidators.writeOtp(value),
                              ),
                            ),
                            Expanded(
                              child: OtpTextFormField(
                                controller: _fourthController,
                                nextController: _fifthController,
                                previousController: _thirdController,
                                focusNode: _fourthFocus,
                                nextFocusNode: _fifthFocus,
                                previousFocusNode: _thirdFocus,
                                validator: (value) => UiValidators.writeOtp(value),
                              ),
                            ),
                            Expanded(
                              child: OtpTextFormField(
                                controller: _fifthController,
                                previousController: _fourthController,
                                focusNode: _fifthFocus,
                                previousFocusNode: _fourthFocus,
                                validator: (value) => UiValidators.writeOtp(value),
                              ),
                            ),
                          ],
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
                            BlocConsumer<ForgotPasswordOtpCubit, ForgotPasswordOtpState>(
                              listener: (context, state) {
                                if (state is ForgotPasswordOtpSuccess) {
                                  context.push(AppRoutes.forgotPasswordReset.path);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: UiColors.black,
                                      content: Text("OTP kod təsdiqləndi", style: TextStyle(color: UiColors.white)),
                                    ),
                                  );
                                } else if (state is ForgotPasswordOtpError) {
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
                                      onPressed: () => _forgotPasswordOtp(),
                                      text: UiStrings.verification,
                                      textColor: UiColors.white,
                                      fontSize: 17,
                                      isLoading: state is ForgotPasswordOtpLoading,
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
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();
    _fifthController.dispose();
    _firstFocus.dispose();
    _secondFocus.dispose();
    _thirdFocus.dispose();
    _fourthFocus.dispose();
    _fifthFocus.dispose();
    super.dispose();
  }
}
