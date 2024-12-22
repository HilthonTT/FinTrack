import 'package:fintrack_app/core/common/widgets/responsive_svg.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/auth/presentation/pages/register_page.dart';
import 'package:fintrack_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:fintrack_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:fintrack_app/features/auth/presentation/widgets/auth_footer.dart';
import 'package:fintrack_app/features/tabs/widgets/main_tab.dart';
import 'package:flutter/material.dart';

final class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLogin() {
    Navigator.pushAndRemoveUntil(context, MainTab.route(), (route) => false);

    //if (_formKey.currentState!.validate()) {}
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.gray,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            // First Column: Illustration and Title
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResponsiveSvg(assetName: 'assets/images/finance.svg'),
                  SizedBox(height: 20),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Log in to continue managing your finances.",
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
                      AuthButton(label: "Login", onPressed: _onLogin),
                      const SizedBox(height: 15),
                      AuthFooter(
                        onPressed: () {
                          Navigator.push(context, RegisterPage.route());
                        },
                        label: "Don't have an account?",
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
