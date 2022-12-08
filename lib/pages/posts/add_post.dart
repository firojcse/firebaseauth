import 'package:firebase_database/firebase_database.dart';
import 'package:firojfirebase/pages/posts/post_screen.dart';
import 'package:firojfirebase/pages/widgets/round_button.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  GlobalKey<FormState>formkey=GlobalKey<FormState>();
  TextEditingController TitlePostController=TextEditingController();
  TextEditingController SubTitlePostController=TextEditingController();
  bool loading=true;
  final database=FirebaseDatabase.instance.ref("Firoj");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              key:formkey,
              controller: TitlePostController,
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  hintText: 'Enter Title'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "* Required";
                } else
                  return null;
              },
            ),
            SizedBox(height: 30,),
            RoundButton(
              // loading: loading,
                titele: "add", onTap: (){

                  String id=DateTime.now().millisecondsSinceEpoch.toString();
                database.child(id).set({
                  "id": id,
                  "title": TitlePostController.text.toString(),
                  "SubTitle": TitlePostController.text.toString(),
                }).then((value){
                  Utils().ToeastMassege("Post Added");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
                  setState(() {
                    loading=false;
                  });
                }).onError((error, stackTrace){
                  debugPrint(error.toString());
                  Utils().ToeastMassege(error.toString());
                  setState(() {
                    loading=false;
                  });
                });

            })

          ],
        ),
      ),
    );
  }
}
