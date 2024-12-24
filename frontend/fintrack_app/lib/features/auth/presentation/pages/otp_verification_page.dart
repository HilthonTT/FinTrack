import 'package:fintrack_app/core/common/widgets/loader.dart';
import 'package:fintrack_app/core/common/widgets/responsive_svg.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fintrack_app/features/tabs/widgets/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

final class OtpVerificationPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const OtpVerificationPage(),
      );

  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

final class _OtpVerificationPageState extends State<OtpVerificationPage> {
  void _onVerify(String otpCode) {
    final parsedOtpCode = int.parse(otpCode);

    final event = AuthVerifyEmail(code: parsedOtpCode);

    context.read<AuthBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthEmailVerified) {
            Navigator.pushAndRemoveUntil(
              context,
              MainTab.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveSvg(assetName: 'assets/images/android.svg'),
                const SizedBox(height: 20),
                Text(
                  "Verify Your Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "We’ve sent a code to your email. Enter it below to continue.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildOtpField(),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // TODO: Resend OTP logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("OTP Resent!")),
                    );
                  },
                  child: Text(
                    "Didn't receive the code? Resend OTP",
                    style: TextStyle(
                      color: AppPalette.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOtpField() {
    return OtpTextField(
      numberOfFields: 6,
      fieldWidth: 40,
      borderColor: AppPalette.primary,
      fillColor: AppPalette.gray,
      cursorColor: AppPalette.secondary,
      focusedBorderColor: AppPalette.secondary,
      showFieldAsBox: true,
      keyboardType: TextInputType.number,
      textStyle: TextStyle(
        color: AppPalette.white,
        fontSize: 18,
      ),
      onCodeChanged: (String code) {},
      onSubmit: _onVerify,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
