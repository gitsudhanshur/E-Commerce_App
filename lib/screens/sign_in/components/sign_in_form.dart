import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../constants.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool isLoading = false;
  bool? remember = false;

  Future<void> signIn() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to Home after successful login
      Navigator.pushReplacementNamed(context, "/");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
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
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),),
            onSaved: (value) => email = value!,
            validator: (value) =>
                value!.isEmpty ? "Please enter email" : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Password",
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),),
            obscureText: true,
            onSaved: (value) => password = value!,
            validator: (value) =>
                value!.isEmpty ? "Please enter password" : null,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: signIn,
                  child: const Text("Sign In"),
                ),
        ],
      ),
    );
  }
}
