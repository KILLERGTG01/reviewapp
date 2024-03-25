import 'package:ratesavvy/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState(){
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [Color.fromARGB(255, 38, 147, 224),Color.fromARGB(255, 226, 234, 226)],
          radius: 1.1,
        )
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
            'assets/images/rating.png',
            width: 200,
            ),
          ],
        ),
      ),
    )
    ),          
      );
  }
}