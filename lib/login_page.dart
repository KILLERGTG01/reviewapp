import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ratesavvy/review_page.dart';
class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  @override
  State<LoginPage> createState(){
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _analytics = FirebaseAnalytics.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    
    if (_formKey.currentState!.validate()) {
      try {
        // Use Firebase Authentication to perform login
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        
        // Log the login event to Firebase Analytics
        await _analytics.logLogin(loginMethod: 'email_password');
        if (!mounted) return; 
        // If successful, navigate to the HomeScreen (make sure to define the route)
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context)=> const ReviewPage()));
        
      } on FirebaseAuthException catch (e) {
        // Log the error to Firebase Analytics
        await _analytics.logEvent(
          name: 'login_failure',
          parameters: {'error': e.code},
        );

        // Show an error message
        _showError(e.message ?? 'An unknown error occurred');
      }
    }
  }

  void _showError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your password' : null,
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}