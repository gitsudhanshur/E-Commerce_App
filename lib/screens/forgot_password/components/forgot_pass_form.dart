import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../components/custom_surfix_icon.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  bool isLoading = false;

  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset link sent! Check your email."),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context); // Go back to sign-in screen
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Error sending reset email"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
            onSaved: (value) => email = value!.trim(),
            validator: (value) =>
                value!.isEmpty ? "Please enter your email" : null,
          ),
          const SizedBox(height: 20),
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: resetPassword,
                  child: const Text("Send Reset Link"),
                ),
        ],
      ),
    );
  }
}
