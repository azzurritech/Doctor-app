
import 'package:doctor_app_updated/Screens/login.dart';
import 'package:doctor_app_updated/Widgets/BaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getid();
    super.initState();
  }
  getid()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
         BaseHelper.ids=prefs.getInt("userid") ;
         BaseHelper.name=prefs.getString("name");
         BaseHelper.email=prefs.getString("email");
         if(BaseHelper.ids != null   &&  BaseHelper.ids != -1 ){
           return    Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (context) => BottomNavigationBarExample()));
         }
         else{
           Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (context) => LoginScreen()));
         }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}