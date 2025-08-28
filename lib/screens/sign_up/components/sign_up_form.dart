import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../components/custom_surfix_icon.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool isLoading = false;

  Future<void> signUp() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );

      Navigator.pushReplacementNamed(context, "/");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Sign up failed")),
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
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
              ),
            onSaved: (value) => email = value!,
            validator: (value) =>
                value!.isEmpty ? "Please enter email" : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
              ),
            obscureText: true,
            onSaved: (value) => password = value!,
            validator: (value) =>
                value!.length < 6 ? "Password must be 6+ chars" : null,
          ),
          const SizedBox(height: 20),
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: signUp,
                  child: const Text("Sign Up"),
                ),
        ],
      ),
    );
  }
}
