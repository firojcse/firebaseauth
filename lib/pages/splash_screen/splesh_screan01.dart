import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firojfirebase/pages/auth/login_screen.dart';
import 'package:firojfirebase/pages/firestore/firestore_list_screen.dart';
import 'package:firojfirebase/pages/posts/post_screen.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';
class Splesh_Screan extends StatefulWidget {
  const Splesh_Screan({Key? key}) : super(key: key);

  @override
  _Splesh_ScreanState createState() => _Splesh_ScreanState();
}

class _Splesh_ScreanState extends State<Splesh_Screan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final auth=FirebaseAuth.instance;
    final  user = auth.currentUser;
    if(user!=null){
      Timer(
          Duration(seconds: 3), ()=>Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>
              // PostScreen()
              // FireStoreSccreen()
          HomeScreen()
          ))
      );
    }else{
      Timer(
          Duration(seconds: 3), ()=>Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>LoginScreen()))
      );
    }




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdfeefa),
      body: Center(
        child: Container(
          child: Container(
            height: 200,
            width: 200,
            child: Text("Splash\nScreen",style: TextStyle(fontSize:
            50,color: Colors.purple),),
            decoration: BoxDecoration(

                // image: DecorationImage(
                //     // image: AssetImage("images/Logo/app icon.png"),
                //     // fit: BoxFit.fill
                // )
            ),
          ),
        ),
      ),
    );
  }
}


