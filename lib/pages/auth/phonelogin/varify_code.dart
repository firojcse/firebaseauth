import 'package:firebase_auth/firebase_auth.dart';
import 'package:firojfirebase/pages/posts/post_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';
class VarifyCodeScreen extends StatefulWidget {
  String verificationId;
  VarifyCodeScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VarifyCodeScreen> createState() => _VarifyCodeScreenState();
}

class _VarifyCodeScreenState extends State<VarifyCodeScreen> {
  bool loading=false;
  final auth=FirebaseAuth.instance;
  TextEditingController verifyPhoneCodeController=TextEditingController();
  GlobalKey<FormState> formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              key: formkey,
              controller: verifyPhoneCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText:"6 Digit code"

              ),
            ),
          ),
          SizedBox(height: 50,),
          RoundButton(titele: "Verify",loading: loading, onTap: ()async{
            setState(() {
              loading=true;
            });
          final credential= PhoneAuthProvider.credential(
              verificationId: widget.verificationId,
              smsCode: verifyPhoneCodeController.text.toString());
          try{
            await auth.signInWithCredential(credential);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
          }catch(e){

            setState(() {
              loading=false;
            });
            Utils().ToeastMassege(e.toString());
          }

         /*   setState(() {
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
                });*/

          })
        ],
      ),
    );
  }
}
