import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../google_signin_api.dart';
import 'forgot_password_screen.dart';
import 'login.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: _toggleNotifications,
              ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Handle language settings navigation
              },
            ),
            SizedBox(height: 40),
            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Edit Profile'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
                // Navigator.popUntil(context, ModalRoute.withName('/bottomNavigationBar'));
                // Navigator.pushNamed(context, '/profile');
                // Handle edit profile navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
                // Handle change password navigation
              },
            ),
            SizedBox(height: 40),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3),
              child: ElevatedButton(
                onPressed: () async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.remove('userid');
                  await prefs.clear();
                  if (displayGname != null) {
                    await GoogleSignInApi.logout();
                    //displayGname = 'Victor';
                   // GoogleUserImageurl = 'https://img.freepik.com/free-photo/front-view-smiley-nurse_23-2148501062.jpg?w=740&t=st=1688458789~exp=1688459389~hmac=5e9ceaa08ca9f298a32b1059274bb06ce9fa81d49afd543e361981170fc48fe5';
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                  //await GoogleSignInApi.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                  // Handle logout action
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
