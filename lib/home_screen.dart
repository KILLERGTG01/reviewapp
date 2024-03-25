import 'package:flutter/material.dart';
import 'package:ratesavvy/login_page.dart';
import 'package:ratesavvy/registration_page.dart';
class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context)=>const LoginPage(),
        '/registration':(context)=> const RegistrationPage()
      },
      home: Scaffold(
        appBar: AppBar(
      title: const Text('RateSavvy'),
      backgroundColor: Colors.white,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.blue,
        fontSize: 30.0 ,
      ),
    ),
      body:  Center(
        child: Column(
          children: [
            const SizedBox(width: 1000),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(
                  context, 
                  '/login');
              }, 
              //icon: const Icon(Icons.arrow_forward_ios_sharp),
              child: const Text('Login'),
            ),
            const SizedBox(
              width: 20,
            ),
            OutlinedButton(
              onPressed: (){
                Navigator.pushNamed(
                  context, 
                  '/registration');
              } , 
              //icon: const Icon(Icons.arrow_forward_ios_sharp),
              child: const Text('Register'),
            )  
          ],
        ),
      )

      )
    );
  }
}  
