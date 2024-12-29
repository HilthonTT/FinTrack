import 'package:fintrack_app/core/common/utils/toast_helper.dart';
import 'package:fintrack_app/core/common/widgets/loader.dart';
import 'package:fintrack_app/core/common/widgets/responsive_svg.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fintrack_app/features/auth/presentation/pages/login_page.dart';
import 'package:fintrack_app/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:fintrack_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:fintrack_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:fintrack_app/features/auth/presentation/widgets/auth_footer.dart';
import 'package:fintrack_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class RegisterPage extends StatefulWidget {
  static MaterialPageRoute<RegisterPage> route() => MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      );

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final class _RegisterPageState extends State<RegisterPage> {
  late FToast fToast;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      final event = AuthRegister(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
      );

      context.read<AuthBloc>().add(event);
    }
  }

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.gray,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthRegistered) {
              Navigator.pushAndRemoveUntil(
                context,
                OtpVerificationPage.route(),
                (route) => false,
              );
            } else if (state is AuthFailure) {
              showToast(fToast, state.message, Icons.error);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            return Row(
              children: [
                // First Column: Illustration and Title
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ResponsiveSvg(assetName: 'assets/images/investing.svg'),
                      SizedBox(height: 20),
                      Text(
                        "Register to Fintrack",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Create an account to start managing your finances.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Second Column: Login Form
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AuthField(
                            hintText: "Name",
                            controller: _nameController,
                            icon: Icons.person,
                          ),
                          AuthField(
                            hintText: "Email Address",
                            controller: _emailController,
                            icon: Icons.email,
                            isEmail: true,
                          ),
                          AuthField(
                            hintText: "Password",
                            controller: _passwordController,
                            icon: Icons.password,
                            isPassword: true,
                          ),
                          const SizedBox(height: 10),
                          AuthButton(label: "Register", onPressed: _onRegister),
                          const SizedBox(height: 15),
                          AuthFooter(
                            onPressed: () {
                              Navigator.push(context, LoginPage.route());
                            },
                            label: "Already have an account?",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
