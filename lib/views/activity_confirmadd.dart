import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivityConfirmPage extends StatelessWidget {
  final String activityName;
  final String description;
  final String location;
  final DateTime selectedDate;

  const ActivityConfirmPage({
    Key? key,
    required this.activityName,
    required this.description,
    required this.location,
    required this.selectedDate,
  }) : super(key: key);

  void _addActivityToFirestore(BuildContext context) async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var firestore = FirebaseFirestore.instance;

    await firestore
        .collection('users')
        .doc(userId)
        .collection('activities')
        .add({
      'activityName': activityName,
      'description': description,
      'location': location,
      'selectedDate': selectedDate.toIso8601String(),
    }).then((value) {
      // Navigate to a different page or show a success message
      Navigator.pushReplacementNamed(
          context, '/Activity'); // Adjust this route as necessary
    }).catchError((error) {
      // Show an error message or handle the error
      print("Error adding document: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Activity'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Activity Name'),
              subtitle: Text(activityName),
            ),
            ListTile(
              title: Text('Description'),
              subtitle: Text(description),
            ),
            ListTile(
              title: Text('Location'),
              subtitle: Text(location),
            ),
            ListTile(
              title: Text('Date'),
              subtitle: Text('${selectedDate.toLocal()}'.split(' ')[0]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Confirm"),
              onPressed: () => _addActivityToFirestore(context),
            ),
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
