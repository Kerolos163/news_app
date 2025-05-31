import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/string_extensions.dart';
import 'package:news_app/core/serves/constant_key.dart';
import 'package:news_app/core/serves/preference_manager.dart';

class SignupProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? errorMessage;
  bool loading = false;

  Future<void> signUp() async {
    errorMessage = null;
    loading = true;
    notifyListeners();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    await Future.delayed(const Duration(milliseconds: 500));

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      errorMessage = 'Please fill in all fields.';
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
    if (password.length < 6) {
      errorMessage = 'Password must be at least 6 characters.';
      loading = false;
      notifyListeners();
      return;
    }
    if (password != confirmPassword) {
      errorMessage = 'Passwords do not match.';
      loading = false;
      notifyListeners();
      return;
    }
    // Check if user already exists
    final savedEmail = PreferencesManager.getString(GetKey.userEmail);
    if (savedEmail != null && savedEmail == email) {
      errorMessage = 'An account with this email already exists.';
      loading = false;
      notifyListeners();
      return;
    }
    await PreferencesManager.setString(GetKey.userEmail, email);
    await PreferencesManager.setString(GetKey.userPassword, password);
    await PreferencesManager.setBool(GetKey.isLoggedIn, true);
  }

  void changePasswordVisiability() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void changeConfirmPasswordVisiability() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }
}
