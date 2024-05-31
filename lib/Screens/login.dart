import 'dart:convert';
import 'package:doctor_app_updated/Screens/signup.dart';
import 'package:doctor_app_updated/Widgets/alertdialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Constants/constants.dart';
import '../Widgets/BaseHelper.dart';
import '../google_signin_api.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'forgot_password_screen.dart';

var displayGname;
var GoogleUserImageurl;
var googlelogintoken;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggedIn = false;
  Map _userObj = {};
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future login(String email, String password) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await http.post(
        Uri.parse('https://doclive.info/api/login'), body: {
      'email': email,
      'password': password,
    });

    if (data.statusCode == 200) {
      BaseHelper.id = json.decode(data.body);
      BaseHelper.ids = BaseHelper.id['user']['id'];
      BaseHelper.name = BaseHelper.id['user']['name'];
      BaseHelper.email = BaseHelper.id['user']['email'];
      print(BaseHelper.ids);
   prefs.setInt("userid",BaseHelper.ids ?? -1);
      prefs.setString("name", BaseHelper.name);
      prefs.setString("email",BaseHelper.email);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavigationBarExample()));
    }
    else {
      final Map<String, dynamic> response = json.decode(data.body);
      final String errorMessage = response['message'];
      print(errorMessage);
      context.showerrordialogue(errorMessage);

    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: primarycolor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Doctor Appointment',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Flexible(child: SizedBox(height: 30)),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
              obscureText: true,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                final emailtext = email.text.toString();
                final passtext = password.text.toString();
                login(emailtext, passtext);
              },
              child: Text('LOGIN', style: TextStyle(color: Colors.black)),
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
                print('forgot password pressed');
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
                // Handle forgot password action
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //SignupScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text(
                'SignUp Now',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Flexible(child: SizedBox(height: 20)),
            Text(
              'Or sign in with',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Flexible(child: SizedBox(height: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                IconButton(
                  onPressed: () {
                    print('google pressed');
                    AuthService().signIknwithGoogle(context);
                  },
                  icon: Image.network(
                    'https://img.freepik.com/free-psd/google-icon-isolated-3d-render-illustration_47987-9777.jpg?w=740&t=st=1688647543~exp=1688648143~hmac=8e20cee6e60df1de0983736842b0bd2aca072e8b8aed0a80c5b18c0e6c3008ba',
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                  },
                  icon: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/145/145802.png?w=740&t=st=1688647502~exp=1688648102~hmac=086e478d8cd3074172c0b3983ffa22ecd4450bca26a5e32c3b15ed5f4d6e2621',
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                  },
                  icon: Image.network(
                    //'https://cdn-icons-png.flaticon.com/512/145/145802.png?w=740&t=st=1688647502~exp=1688648102~hmac=086e478d8cd3074172c0b3983ffa22ecd4450bca26a5e32c3b15ed5f4d6e2621',
                    "https://e7.pngegg.com/pngimages/779/788/png-clipart-apple-logo-%E4%BF%83%E9%94%80-heart-logo.png",
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  // Future signIn() async {
  //   // GoogleSignInAuthentication auth = await account.authentication;
  //   // String googleToken = auth.idToken;
  //   final SharedPreferences pref=await SharedPreferences.getInstance();
  //   print(' inside function google pressed');
  //   final user = await GoogleSignInApi.login();
  //   if (user == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Sign in Failed')));
  //   } else {
  //     //BottomNavigationBarExample
  //     displayGname = user.displayName.toString();
  //     GoogleUserImageurl = user.photoUrl.toString();
  //    googlelogintoken = user.id;
  //  BigInt nm=BigInt.parse(googlelogintoken);
  //    print(nm);
  //     print('here is user $user');
  //  BaseHelper.id= pref.setInt("userid", nm.toInt());
  //  BaseHelper.name=pref.setString("name", user.displayName.toString());
  //     BaseHelper.email=pref.setString("email", user.email.toString());
  //   print(BaseHelper.name);
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (context) => BottomNavigationBarExample(),));
  //     print('here is user $user');
  //
  //   }
  // }

  facebookLogin() async {
    try {
      final result =
      await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print('facebook_login_data:-');
        print(userData);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(image: userData['picture']['data']['url'],
        //     name: userData['name'], email: userData['email'])));
      }
    } catch (error) {
      print(error);
    }
  }

  //for api ggl lgn
  Future<void> callGoogleAPIAndLaunchURL() async {
    var Url = Uri.parse('https://doclive.info/api/google');
    final response = await http.get(Uri.parse("https://doclive.info/api/google"));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
       final redirectUrl = responseData['redirect_url'];
      print(redirectUrl);
      final Uri _url = Uri.parse(redirectUrl);
      if (!await launchUrl(_url)) {throw Exception('Could not launch $_url');};
    }
    else {
      throw 'Failed to load URL';
    }
  }
}