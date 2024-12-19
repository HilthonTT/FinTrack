import 'package:fintrack_app/core/common/widgets/responsive_svg.dart';
import 'package:fintrack_app/features/auth/presentation/pages/login_page.dart';
import 'package:fintrack_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:fintrack_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:fintrack_app/features/auth/presentation/widgets/auth_footer.dart';
import 'package:fintrack_app/features/expenses/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

final class RegisterPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      );

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onRegister() {
    Navigator.pushAndRemoveUntil(context, HomePage.route(), (route) => false);

    // if (_formKey.currentState!.validate()) {}
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            // First Column: Illustration and Title
            const Expanded(
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
        ),
      ),
    );
  }
}