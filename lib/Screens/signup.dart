import 'dart:convert';
import 'package:doctor_app_updated/Screens/api_service.dart';
import 'package:doctor_app_updated/Widgets/alertdialogue.dart';
import 'package:doctor_app_updated/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/constants.dart';
import '../Widgets/BaseHelper.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController name=TextEditingController();
  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  Future register(String name,String email,String password)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var data=await http.post(Uri.parse('https://doclive.info/api/register'), body: {
     'name':name,
      'email':email,
      'password':password,
    });
    if(data.statusCode==201){
      BaseHelper.id=json.decode(data.body);
      BaseHelper.ids=BaseHelper.id['user']['id'];
      BaseHelper.name=BaseHelper.id['user']['name'];
      BaseHelper.email=BaseHelper.id['user']['email'];
      print( BaseHelper.ids);
      print(data.body);
      prefs.setInt("userid",BaseHelper.ids ?? -1);
      prefs.setString("name", BaseHelper.name);
      prefs.setString("email",BaseHelper.email);
      String? token=await FirebaseMessaging.instance.getToken();
      print(token);
      //ApiService.saveToken('device_token_value', 'user_id_value');
      
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarExample()));
    }
    else{
      context.showerrordialogue(data.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Doctor Appointment',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Full Name',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: password,
              decoration: const InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                final nametext=name.text.toString();
                final emailtext= email.text.toString();
                final passtext=password.text.toString();
                register(nametext,emailtext,passtext);

                // Handle signup action
              },
              child: const Text('SIGN UP',style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                textStyle: TextStyle(

                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Handle login instead action
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Already have an account? Login instead',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
