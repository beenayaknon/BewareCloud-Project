import 'package:flutter/material.dart';

class AboutusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud, size: 24.0),
                  SizedBox(width: 10),
                  Text("BewareCloud", style: TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
            Text(
              "Designed by:\nDuang Duean Team\nChanikarn, Sushawapak, Tanawat, Ittikorn",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/UserSetting');
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
