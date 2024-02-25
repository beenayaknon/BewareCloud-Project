import 'package:flutter/material.dart';

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
            Text('Confirm add activity?',
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Confirm"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Activity');
              },
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
