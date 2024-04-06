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
    const double fem = 1.0;
    const double ffem = 1.0;
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFB),
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
              'assets/icon/back.png',
              width:25 * fem,
              height: 25 * fem,
              fit: BoxFit.cover
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/ActivityAdd');
          },
        ),
        title: Text('Confirm Activity'),
        titleTextStyle: TextStyle(
          fontFamily: 'Heebo',
          fontSize: 32 * ffem,
          fontWeight: FontWeight.w700,
          color: Color(0xff000000),
        ),
        elevation: 0,
      ),
      body: Padding(
      padding: EdgeInsets.fromLTRB(20 * fem, 20 * fem, 20 * fem, 0 * fem),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Activity Name'),
                titleTextStyle: TextStyle(fontFamily: 'Nunito', fontSize: 16 * ffem, fontWeight: FontWeight.w500, color: Color(0xff000000),
                ),
                subtitle: Text(activityName),
                subtitleTextStyle: TextStyle(fontFamily: 'Nunito', fontSize: 14 * ffem, fontWeight: FontWeight.w400, color: Color(0xff000000),
                ),
              ),
              ListTile(
                title: Text('Description'),
                titleTextStyle: TextStyle(fontFamily: 'Nunito', fontSize: 16 * ffem, fontWeight: FontWeight.w500, color: Color(0xff000000),
                ),
                subtitle: Text(description),
                subtitleTextStyle: TextStyle(fontFamily: 'Nunito', fontSize: 14 * ffem, fontWeight: FontWeight.w400, color: Color(0xff000000),
                ),
              ),
              ListTile(
                title: Text('Location'),
                titleTextStyle: TextStyle(fontFamily: 'Nunito', fontSize: 16 * ffem, fontWeight: FontWeight.w500, color: Color(0xff000000),
                ),
                subtitle: Text(location),
                subtitleTextStyle: TextStyle(fontFamily: 'Nunito', fontSize: 14 * ffem, fontWeight: FontWeight.w400, color: Color(0xff000000),
                ),
              ),
              ListTile(
                title: Text('Date'),
                titleTextStyle: TextStyle(fontFamily: 'Nunito', fontSize: 16 * ffem, fontWeight: FontWeight.w500, color: Color(0xff000000),
                ),
                subtitle: Text('${selectedDate.toLocal()}'.split(' ')[0]),
                subtitleTextStyle: TextStyle(fontFamily: 'Nunito', fontSize: 14 * ffem, fontWeight: FontWeight.w400, color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 20),
              /*
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
            */
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20 * ffem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xffE8E8E8),
                        minimumSize: Size(150.0 * fem, 60.0 * ffem), // Adjust the size as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50 * fem),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.close, color: Color(0xff000000)),
                          SizedBox(width: 10.0),
                          Text(
                            'cancel',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Next Button
                    TextButton(
                      onPressed: () => _addActivityToFirestore(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xffBAD6EB),
                        minimumSize: Size(150.0 * fem, 60.0 * ffem), // Adjust the size as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50 * fem),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.done, color: Color(0xff000000)),
                          SizedBox(width: 10.0),
                          Text(
                            'confirm',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
