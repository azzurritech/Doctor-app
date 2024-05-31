import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  'https://img.freepik.com/premium-vector/patient-consultation-with-doctor-illustration_677179-56.jpg?w=740'),
            ),
            SizedBox(height: 20),
            Text(
              'Doctor Appointment App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'About the App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'The Doctor Appointment App is designed to help patients easily schedule appointments with doctors. '
              'It provides a user-friendly interface to browse doctors, view their availability, and book appointments '
              'at convenient times. With this app, you can efficiently manage your medical appointments and stay '
              'connected with your healthcare providers.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              'Developed by Azzurri Tech',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // ListTile(
            //   leading: CircleAvatar(
            //     radius: 20,
            //     backgroundImage: NetworkImage(
            //         'https://img.freepik.com/free-vector/web-development-programmer-engineering-coding-website-augmented-reality-interface-screens-developer-project-engineer-programming-software-application-design-cartoon-illustration_107791-3863.jpg?w=740&t=st=1688460000~exp=1688460600~hmac=a82f2ee38828d568546f1ea6e2326069d55322bfe2c9f565a40796e773fe1f85'),
            //   ),
            //   title: Text('John Doe'),
            //   subtitle: Text('App Developer'),
            // ),
            // ListTile(
            //   onTap: () async {
            //
            //   },
            //   leading: const CircleAvatar(
            //     radius: 20,
            //     backgroundImage: NetworkImage(
            //         'https://img.freepik.com/free-vector/mobile-ui-ux-concept-illustration_114360-11697.jpg?w=740&t=st=1688460056~exp=1688460656~hmac=ac5620901c75cae363a6222112f4e53e693d2dfa4b1c09fa04b8254766250ca2'),
            //   ),
            //   title: Text('Jane Smith'),
            //   subtitle: Text('UI/UX Designer'),
            // ),
            // Add more team members if needed
          ],
        ),
      ),
    );
  }
}
