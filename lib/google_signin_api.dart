import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctor_app_updated/Widgets/BaseHelper.dart';
import 'package:doctor_app_updated/Widgets/alertdialogue.dart';
import 'package:doctor_app_updated/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInApi {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
 // static Future<GoogleSignInAccount?> login() => _googleSignIn.signOut();
  static Future logout() => _googleSignIn.disconnect();
}

class AuthService {
  signIknwithGoogle(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication gAuth = await gUser!.authentication;
    print(gAuth.idToken);
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    BaseHelper.Guserphotourl = gUser.photoUrl;
    print('after google login data here');
    print(gUser.photoUrl);
    print(gUser.toString());
    print(gAuth.accessToken);
    
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => BottomNavigationBarExample()));
    var data = await http
        .post(Uri.parse('https://doclive.info/api/google-login'), body: {
      'access_token': gAuth.accessToken,
    });
    if (data.statusCode == 200) {
      BaseHelper.id = json.decode(data.body);
      BaseHelper.ids = BaseHelper.id['user']['id'];
      BaseHelper.name = BaseHelper.id['user']['name'];
      BaseHelper.email = BaseHelper.id['user']['email'];

      // print('here guserphotourl');
      // print(BaseHelper.Guserphotourl);
      // print(BaseHelper.ids);
      // print(data.body);
      prefs.setInt("userid", BaseHelper.ids ?? -1);
      prefs.setString("name", BaseHelper.name);
      prefs.setString("email", BaseHelper.email);
      String? token = await FirebaseMessaging.instance.getToken();
      print(token);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavigationBarExample()));
    } else {
      context.showerrordialogue(data.body);
    }
  }
}
