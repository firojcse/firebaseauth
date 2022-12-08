
import 'dart:async';

import 'package:firojfirebase/pages/auth/login_screen.dart';
import 'package:flutter/material.dart';
class SplashServices{

  void isLogin(BuildContext context){
    Timer.periodic(const Duration(seconds: 3), (timer) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    });

}

}


