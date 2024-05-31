import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';


class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _sendPasswordResetEmail() async {
    String email = _emailController.text.trim();
    if (email.isNotEmpty && _isValidEmail(email)) {
      String Url = "https://doclive.info/api/password/email?email=$email";
      var response = await http.post(Uri.parse(Url));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String message = responseData['message'];
        _showSnackbar(message);
      } else if(response.statusCode == 422){
        Map<String, dynamic> responseData = json.decode(response.body);
        //String message = responseData['message'];
        String errorMessage = responseData['errors']['email'];
        _showSnackbar(errorMessage);
      }
      else {
        _showSnackbar('Error: Failed to send password reset email');
      }
    } else {
      _showSnackbar('Please enter a valid email address');
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _showSnackbar(String message) {
    _scaffoldKey.currentState != null?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message))):"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Reset Password'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/1.5,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  hintText: 'Enter your email',
                  filled: true,
                  fillColor: Color(0xffFFFFFF),
                ),
                // decoration: InputDecoration(
                //   labelText: 'Enter Your Email',
                //   hintText: 'Enter your email',
                // ),
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF))),
                  onPressed: _sendPasswordResetEmail,
                  // color: Colors.blue,
                  // textColor: Colors.white,
                  child: Text('Send Password Reset Email',style: TextStyle(color: Color(0xFF2196F3))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
