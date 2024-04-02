import 'package:flutter/material.dart';

class Tutorial4Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double fem = 1.0;
    const double ffem = 1.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tutorial',
          style: TextStyle(
            fontFamily: 'Heebo',
            fontSize: 34 * ffem,
            fontWeight: FontWeight.w800,
            color: Color(0xff091f5b),
          ),
        ),
        backgroundColor: Color(0xfffafafb),
        elevation: 0, // No shadow for consistency with the design
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(40 * fem, 35 * fem, 40 * fem, 0 * fem),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your tutorial content goes here.
              // For example, using images and text to describe the tutorial steps.
              SizedBox(height: 5 * ffem),
              Text(
                'Setting Page',
                style: TextStyle(
                  fontSize: 24 * ffem, // Adjust the font size as per design
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10 * ffem),
              Image.asset('assets/tutorials/Activity_page.png'),
              SizedBox(height: 10 * ffem),
              Text(
                '     The “Setting” page allows user to navigate to “Tutorial” page, “About us” page, and log out from the system.',
                style: TextStyle(fontSize: 16 * ffem),
              ),
              // ... Add more tutorial content if needed.
              SizedBox(height: 30 * ffem),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20 * ffem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous Button
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/Tutorial3');
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
                          Icon(Icons.arrow_back_ios, color: Color(0xff000000)),
                          Text(
                            'Prev',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Next Button
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/UserSetting');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xffBAD6EB),
                        minimumSize: Size(150.0 * fem, 60.0 * ffem), // Adjust the size as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50 * fem),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Finish',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
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
