import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityDetailsPage extends StatelessWidget {
  final Map<String, dynamic> activityData;

  ActivityDetailsPage({Key? key, required this.activityData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date as dd/mm/yy
    String formattedDate = DateFormat('dd/MM/yy')
        .format(DateTime.parse(activityData['selectedDate']));
    return Scaffold(
      appBar: AppBar(
        title: Text(activityData['activityName'] ?? 'Activity Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Activity: ${activityData['activityName']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Location: ${activityData['location']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Date: $formattedDate',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
