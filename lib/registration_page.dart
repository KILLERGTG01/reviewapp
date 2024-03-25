import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ratesavvy/review_page.dart';
class RegistrationPage extends StatefulWidget{
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState(){
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _analytics = FirebaseAnalytics.instance;

  Future<void> _registerAccount() async {
    // Implement your registration logic with Firebase Auth
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential.user != null) {
        // On successful registration, log the event with Firebase Analytics
        await _analytics.logSignUp(signUpMethod: 'email_password');
        // Navigate to the home screen
        if(!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=> const ReviewPage()));
      }
    } on FirebaseAuthException catch (e) {
      await _analytics.logEvent(name: 'register_failure',parameters: {'error':e.code});  // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30.0
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter your email';
                }
                else if(!value.contains('@')){
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),// Add TextFormFields for email and password
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator:(value) {
                if(value==null || value.isEmpty){
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  _registerAccount();
                }
              }, 
              child: const Text('Register')
              )// Add a button that calls _registerAccount when pressed
          ],
        ),
      ),
    );
  }
}