import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firojfirebase/pages/auth/login_screen.dart';
import 'package:firojfirebase/pages/posts/add_post.dart';
import 'package:firojfirebase/pages/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("Firoj");
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Screen"),
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
            TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                hintText: 'Enter the phone number',
              ),
              onChanged: (String value) {
                setState(() {});
              },
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return "* Required";
              //   } else
              //     return null;
              // },
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  defaultChild: Center(child: CircularProgressIndicator()),
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child("title").value.toString();
                    if (searchFilter.text.isEmpty) {
                      return ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(snapshot.child("id").value.toString()),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title,
                                        snapshot.child("id").value.toString());
                                  },
                                  title: Text("Edit"),
                                  trailing: Icon(Icons.edit),
                                )),
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  title: Text("delete"),
                                  trailing: Icon(Icons.delete),
                                  onTap: (){
                                    Navigator.pop(context);
                                    ref.child( snapshot.child("id").value.toString()).remove();
                                  },
                                )),
                          ],
                        ),
                      );
                    } else if (title
                        .toLowerCase()
                        .contains(searchFilter.text.toLowerCase().toString())) {
                      return ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(snapshot.child("id").value.toString()),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
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
                    Navigator.pop(context);
                   ref.child(id).update({
                     "title": editController.text.toString()
                   }).then((value){
                     Utils().ToeastMassege("Firoj List Update");
                   }).onError((error, stackTrace){
                     Utils().ToeastMassege(error.toString());
                   });
                  },
                  child: Text("Update")),
            ],
          );
        });
  }
}

/*   Expanded(child: StreamBuilder(
            stream: ref.onValue,
            builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
             if(!snapshot.hasData){
              return CircularProgressIndicator();
             }else{
               Map<dynamic, dynamic> map=snapshot.data!.snapshot.value as dynamic;
               List<dynamic>list=[];
               list.clear();
               list= map.values.toList();
               return ListView.builder(

                   itemCount: snapshot.data!.snapshot.children.length,
                   itemBuilder: (context, index){
                     return ListTile(
                       title: Text(list[index]["title"]),
                       subtitle:Text(list[index]["id"]),
                     );
                   });
             }
            },
          )),*/
