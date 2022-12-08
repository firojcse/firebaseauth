
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firojfirebase/pages/auth/login_screen.dart';
import 'package:firojfirebase/pages/firestore/add_firestore_data.dart';
import 'package:firojfirebase/pages/posts/add_post.dart';
import 'package:firojfirebase/pages/utils/utils.dart';
import 'package:flutter/material.dart';

class FireStoreSccreen extends StatefulWidget {
  const FireStoreSccreen({Key? key}) : super(key: key);

  @override
  State<FireStoreSccreen> createState() => _FireStoreSccreenState();
}

class _FireStoreSccreenState extends State<FireStoreSccreen> {
  final auth = FirebaseAuth.instance;
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireStore Database Screen"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().ToeastMassege(error.toString());
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(child: ListView.builder(
              itemCount: 10,
                itemBuilder: (context, index){
                  return Text("Firoj");
                })),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddFireStoreData()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String titel, String id) async {

    editController.text = titel;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(hintText: "Edit"),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    // ref.child(id).update({
                    //   "title": editController.text.toString()
                    // }).then((value){
                    //   Utils().ToeastMassege("Firoj List Update");
                    // }).onError((error, stackTrace){
                    //   Utils().ToeastMassege(error.toString());
                    // });
                  },
                  child: Text("Update")),
            ],
          );
        });
  }
}

