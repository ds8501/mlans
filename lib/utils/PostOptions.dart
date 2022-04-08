import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/Authentication.dart';

class PostOptions with ChangeNotifier {
  Future addUpvote(BuildContext context, String postId, String subDocId) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('upvotes')
        .doc(subDocId)
        .set({
      'upvotes': FieldValue.increment(1),
      'userId':
          Provider.of<Authentication>(context, listen: false).getUser()?.uid,
      'useremail':
          Provider.of<Authentication>(context, listen: false).getUser()?.email,
      'time': Timestamp.now().toString().substring(18, 28),
    });
  }

  Future addDownvote(
      BuildContext context, String postId, String subDocId) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('downvotes')
        .doc(subDocId)
        .set({
      'downvotes': FieldValue.increment(1),
      'userId':
          Provider.of<Authentication>(context, listen: false).getUser()?.uid,
      'useremail':
          Provider.of<Authentication>(context, listen: false).getUser()?.email,
      'time': Timestamp.now().toString().substring(18, 28),
    });
  }

  Future addComment(BuildContext context, String postId, String comment) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(comment)
        .set(
      {
        'comments': comment,
        'userId':
            Provider.of<Authentication>(context, listen: false).getUser()?.uid,
        'useremail': Provider.of<Authentication>(context, listen: false)
            .getUser()
            ?.email,
        'time': Timestamp.now().toString().substring(18, 28),
      },
    );
  }

  Future deletePost(BuildContext context, String postId) async {
    final doc = FirebaseFirestore.instance.collection('posts').doc(postId);
    await doc
        .delete()
        .then((value) => print(postId))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
