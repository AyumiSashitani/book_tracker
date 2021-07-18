import 'package:book_tracker/model/user.dart';
import 'package:book_tracker/screens/login_page.dart';
import 'package:book_tracker/widgets/create_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MainScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0.0,
        toolbarHeight: 77,
        centerTitle: false,
        title: Row(
          children: [
            Text(
              'A.Reader',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: usersCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final userListStream = snapshot.data!.docs.map((user) {
                return MUser.fromDocument(user);
              }).where((user) {
                return (user.uid == FirebaseAuth.instance.currentUser!.uid);
              }).toList(); // [user]

              MUser curUser = userListStream[0];

              return Column(
                children: [
                  Expanded(
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(curUser.avatarUrl != null
                            ? curUser.avatarUrl
                            : 'https://picsum.photos/id/1/200/300'),
                        backgroundColor: Colors.white,
                        child: Text(''),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CreateProfileDialog(context, curUser);
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    curUser.displayName.toUpperCase(),
                    style: TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              );
              // final bookListStream = snapshot.data!.docs.map((book) {
              //   return Book.fromDocument(book);
              // }).toList();
              // for (var item in bookListStream) {
              //   print(item.author);
              // }
              // return Expanded(
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: bookListStream.length,
              //     itemBuilder: (context, index) {
              //       return Text(
              //         bookListStream[index].author,
              //         style: TextStyle(color: Colors.black),
              //       );
              //     },
              //   ),
              // );
            },
          ),
          TextButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  return Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
              icon: Icon(Icons.logout),
              label: Text(""))
        ],
      ),
    );
  }
}
