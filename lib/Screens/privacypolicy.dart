import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'We take your privacy seriously. This Privacy Policy outlines the types of personal information we receive and collect when you use our app, as well as some of the steps we take to safeguard your information. We hope this will help you make an informed decision about sharing personal information with us.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              'Information Collection and Use',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We may collect and use the following types of personal information for the purposes of providing and improving our services:',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              '• Name, email address, and other contact information',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '• Medical history and other health-related information',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            // Include more information types if needed
            SizedBox(height: 20),
            Text(
              'Security',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We are committed to ensuring that your personal information is secure. We have implemented various security measures to prevent unauthorized access or disclosure of your information.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            // Include additional sections as needed
          ],
        ),
      ),
    );
  }
}
