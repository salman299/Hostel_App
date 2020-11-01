import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hostel_app/screens/main_screen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  Timer timer;
  void startTimer() {
    // Start the periodic timer which prints something every 1 seconds
    timer=  Timer.periodic(new Duration(seconds: 2), (time) {
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    });
  }
  @override
  void initState() {
    startTimer();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final dSize=MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: SizedBox(
                  height: dSize.height*0.25,
                  child: Image.asset('assets/logo.png')
              ),
            ),
            SizedBox(
              height: dSize.height*0.01,
            ),
            Text(
              'Eazzy Account',style: TextStyle(fontSize: dSize.height*0.04,fontWeight: FontWeight.w500),
            ),

          ],
        ),
      ),
    );
  }
}
