import 'package:book_tracker/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'input_decoration.dart';

class UpdateUserProfile extends StatelessWidget {
  const UpdateUserProfile({
    Key? key,
    required TextEditingController displayNameTextController,
    required TextEditingController professionTextController,
    required TextEditingController quoteTextController,
    required TextEditingController avatarTextController,
    required this.user,
  })  : _displayNameTextController = displayNameTextController,
        _professionTextController = professionTextController,
        _quoteTextController = quoteTextController,
        _avatarTextController = avatarTextController,
        super(key: key);

  final MUser user;
  final TextEditingController _displayNameTextController;
  final TextEditingController _professionTextController;
  final TextEditingController _quoteTextController;
  final TextEditingController _avatarTextController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Edit ${user.displayName}'),
      ),
      content: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(user.avatarUrl != null
                      ? user.avatarUrl
                      : 'https://picsum.photos/id/1/200/300'),
                  radius: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // initialValue: curUser.displayName,
                  controller: _displayNameTextController,
                  decoration:
                      buildInputDecoration(label: 'Your Name', hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // initialValue: curUser.profession,
                  controller: _professionTextController,
                  decoration:
                      buildInputDecoration(label: 'Profession', hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // initialValue: curUser.quote,
                  controller: _quoteTextController,
                  decoration: buildInputDecoration(
                      label: 'Favorite quote', hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // initialValue: curUser.avatarUrl,
                  controller: _avatarTextController,
                  decoration:
                      buildInputDecoration(label: 'Avatar url', hintText: ''),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                final userChangedName =
                    user.displayName != _displayNameTextController.text;
                final userChangedAvatar =
                    user.avatarUrl != _avatarTextController.text;
                final userChangedProfession =
                    user.profession != _professionTextController.text;
                final userChangedQuote =
                    user.quote != _quoteTextController.text;

                final userNeedUpdate = userChangedName ||
                    userChangedAvatar ||
                    userChangedProfession ||
                    userChangedQuote;

                if (userNeedUpdate) {
                  print('Updating...');
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.id)
                      .update(MUser(
                              uid: user.uid,
                              displayName: _displayNameTextController.text,
                              avatarUrl: _avatarTextController.text,
                              profession: _professionTextController.text,
                              quote: _quoteTextController.text,
                              id: '')
                          .toMap());
                }
                Navigator.of(context).pop();
              },
              child: Text('Update')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Caccel')),
        ),
      ],
    );
  }
}
