import 'package:firebase_auth/firebase_auth.dart';
import 'package:firojfirebase/pages/auth/phonelogin/varify_code.dart';
import 'package:firojfirebase/pages/utils/utils.dart';
import 'package:firojfirebase/pages/widgets/round_button.dart';
import 'package:flutter/material.dart';
class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
 bool loading=false;
 final auth=FirebaseAuth.instance;
  TextEditingController phoneNumberController=TextEditingController();
 GlobalKey<FormState> formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone"),
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              key: formkey,
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText:"+880 1725 171 605"

              ),
            ),
          ),
          SizedBox(height: 50,),
          RoundButton(titele: "Login",loading: loading, onTap: (){
            setState(() {
              loading=true;
            });
            auth.verifyPhoneNumber(
              phoneNumber: phoneNumberController.text.toString(),
                verificationCompleted: (_){
                  setState(() {
                    loading=false;
                  });
                },
                verificationFailed: (e){
                Utils().ToeastMassege(e.toString());
                setState(() {
                  loading=false;
                });

                },
                codeSent: (String verificationId, int? token){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VarifyCodeScreen(verificationId: verificationId,)));
                },
                codeAutoRetrievalTimeout: (e){
                  Utils().ToeastMassege(e.toString());
                });

          })
        ],
      ),
    );
  }
}
