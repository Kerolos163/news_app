import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/state/sign_up_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignupProvider>(
      create: (context) => SignupProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Consumer<SignupProvider>(
          builder: (context, signupProvider, child) {
            return Container(
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
                      Image.asset('assets/images/logo.png', height: 60),
                      const SizedBox(height: 32),
                      const Text(
                        'Welcome to Newst',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Form(
                        key: signupProvider.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              title: 'Email',
                              controller: signupProvider.emailController,
                              hint: 'usama@usamaelgendy.com',
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              title: 'Password',
                              controller: signupProvider.passwordController,
                              obscureText: signupProvider.obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  signupProvider.obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed:
                                    () => signupProvider.changePasswordVisiability(),
                              ),
                              hint: '*************',
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              title: 'Confirm Password',
                              controller: signupProvider.confirmPasswordController,
                              obscureText: signupProvider.obscureConfirmPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  signupProvider.obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed:
                                    () =>
                                        signupProvider.changeConfirmPasswordVisiability(),
                              ),
                              hint: '*************',
                            ),

                            if (signupProvider.errorMessage != null) ...[
                              const SizedBox(height: 12),
                              Text(
                                signupProvider.errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD32F2F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                onPressed:
                                    signupProvider.loading
                                        ? null
                                        : () {
                                          signupProvider.signUp();
                                          Navigator.of(
                                            context,
                                          ).pushReplacementNamed('/main');
                                        },
                                child:
                                    signupProvider.loading
                                        ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : const Text(
                                          'Sign Up',
                                          style: TextStyle(fontSize: 22),
                                        ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Have an account ? ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Sign In',
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
            );
          },
        ),
      ),
    );
  }
}
