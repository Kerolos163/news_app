import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/string_extensions.dart';
import 'package:news_app/core/serves/preference_manager.dart';

class SigninProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  String? errorMessage;
  bool loading = false;

  Future<void> signIn() async {
    errorMessage = null;
    loading = true;
    notifyListeners();

    /// TODO : Task - Use Preference Manager And don't use hard coded values like [onboardingcomplete]
    final savedEmail = PreferencesManager.getString(GetKey.userEmail);
    final savedPassword = PreferencesManager.getString(GetKey.userPassword);
    final email = emailController.text.trim();
    final password = passwordController.text;

    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      errorMessage = 'Please enter email and password.';
      loading = false;
      notifyListeners();
      return;
    }
    if (!email.emailValid) {
      errorMessage = 'Please enter a valid email address.';
      loading = false;
      notifyListeners();
      return;
    }
    if (savedEmail == null || savedPassword == null) {
      errorMessage = 'No account found. Please sign up first.';
      loading = false;
      notifyListeners();
      return;
    }
    if (email != savedEmail || password != savedPassword) {
      errorMessage = 'Incorrect email or password.';
      loading = false;
      notifyListeners();
      return;
    }
    await PreferencesManager.setBool(GetKey.isLoggedIn, true);
    // if (!mounted) return;
    // Navigator.of(context).pushReplacementNamed('/main');
  }

  void changePasswordVisiability() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}
