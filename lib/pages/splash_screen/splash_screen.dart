import 'package:firojfirebase/pages/splash_screen/splash_servicess.dart';
import 'package:flutter/material.dart';


class
SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices=SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("SplashScreen",style: TextStyle(fontSize:
          50),),
        ),
      ),
    );
  }
}

