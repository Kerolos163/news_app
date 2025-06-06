import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/state/sign_in_provider.dart';
import 'package:provider/provider.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SigninProvider>(
      create: (context) => SigninProvider(),
      child: Consumer<SigninProvider>(
        builder: (context, signinProvider, child) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/auth_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Center(child: Image.asset('assets/images/logo.png', height: 60)),
                      const SizedBox(height: 32),
                      const Text(
                        'Welcome to Newst',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF363636),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Form(
                        key: signinProvider.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              title: 'Email',
                              controller: signinProvider.emailController,
                              hint: 'usama@usamaelgendy.com',
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              title: 'Password',
                              controller: signinProvider.passwordController,
                              obscureText: signinProvider.obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  signinProvider.obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed:
                                    () => signinProvider.changePasswordVisiability(),
                              ),
                              hint: '*************',
                            ),
                            const SizedBox(height: 8),
                            if (signinProvider.errorMessage != null) ...[
                              const SizedBox(height: 12),
                              Text(
                                signinProvider.errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    signinProvider.errorMessage =
                                        'Password reset is not implemented in demo.';
                                  });
                                },
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                    color: Color(0xFFD32F2F),
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed:
                                    signinProvider.loading
                                        ? null
                                        : () {
                                          signinProvider.signIn();
                                          Navigator.of(
                                            context,
                                          ).pushReplacementNamed('/main');
                                        },
                                child:
                                    signinProvider.loading
                                        ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : const Text(
                                          'Sign In',
                                          style: TextStyle(fontSize: 22),
                                        ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account ? ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Color(0xFFD32F2F),
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
