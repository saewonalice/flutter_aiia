import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aiia/chat/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;

        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            return ChatBubble(
              chatDocs[index].get('text'),
              chatDocs[index].get('userID').toString() == user!.uid,
              chatDocs[index].get('userName'),
            );
          },
        );
      },
    );
  }
}

Future<void> fetchData() async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('your_collection')
      .doc('your_document')
      .get();

  if (documentSnapshot.exists) {
    Map<String, dynamic> documentData =
        documentSnapshot.data() as Map<String, dynamic>;
    if (documentData.containsKey('your_field')) {
      var fieldValue = documentSnapshot.get('your_field');
      print(fieldValue);
    } else {
      print('Error: Field does not exist.');
    }
  } else {
    print('Error: Document does not exist.');
  }
}
