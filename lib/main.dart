import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:doctor_app_updated/Screens/wallet.dart';
import 'package:doctor_app_updated/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Constants/constants.dart';
import 'Screens/home.dart';
import 'Screens/profile.dart';
import 'Screens/search_screen.dart';
import 'Screens/splashscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(onbackground);
  if (Platform.isAndroid) {
    HttpOverrides.global = MyHttpOverrides();
  }
  AwesomeNotifications().initialize('resource://drawable/bgremovedlogo', [
    NotificationChannel(
        channelKey: "channelKey",
        channelName: "Calls Channel",
        channelDescription: "Channel with ringtone",
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Notification),
    NotificationChannel(
      enableLights: true,
      //icon:'Assets/LogoPlus.png',
      channelKey: 'message_channel',
      channelName: 'Message Notifications',
      channelDescription: 'Channel for message notifications',
      defaultColor: Colors.blue,
      ledColor: Colors.white,
      importance: NotificationImportance.High,
      channelShowBadge: true,
      defaultRingtoneType: DefaultRingtoneType.Notification,
    ),
  ]);
  runApp(ProviderScope(child: const BottomNavigationBarExampleApp()));
}

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/profile': (context) => ProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
      //home: SlotsScreen(),
      home: SplashScreen(),
      // home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});
  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  final _screens = [
    const HomeScreen(),
    const WalletScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets_outlined, color: primarycolor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment, color: primarycolor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: primarycolor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: primarycolor),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> onbackground(RemoteMessage message) async {}
