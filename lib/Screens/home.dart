import 'dart:convert';
import 'package:doctor_app_updated/Models/booking_history.dart';
import 'package:doctor_app_updated/Screens/chat_screen.dart';
import 'package:doctor_app_updated/Screens/notificationscreen.dart';
import 'package:doctor_app_updated/Screens/search_screen.dart';
import 'package:doctor_app_updated/Widgets/BaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../Constants/constants.dart';
import '../Models/doctorsdata.dart';
import '../Riverpod/riverpod.dart';
import 'aboutus.dart';
import 'doctorprofile.dart';
import 'login.dart';
import 'myappointments.dart';
import 'privacypolicy.dart';
import 'setting.dart';
import 'viewappointment.dart';


List<BookingHistory> dataLists = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BookingHistory> list = [];
  Set<DoctorsData> doc = {};
  String baseurl = "https://doclive.info/assets/doctorImages/";
  Future getdata() async {
    var data = await http.get(Uri.parse("https://doclive.info/api/doctors"));
    final datas = json.decode(data.body);
    for (Map<String, dynamic> ass in datas) {
      doc.add(DoctorsData.fromJson(ass));
    }
  }
  fetchHistory() async {
    final response = await http.get(
      Uri.parse('https://doclive.info/api/getbooked?user_id=${BaseHelper.ids}'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      for (Map<String, dynamic> asas in data) {
        list.add(BookingHistory.fromJson(asas));
      }
    } else {
      throw Exception('Failed to fetch slots');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: Drawer(
        backgroundColor: Colors.grey.shade100,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: Container(
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          BaseHelper.Guserphotourl != null && BaseHelper.Guserphotourl.isNotEmpty
                              ? BaseHelper.Guserphotourl.toString()
                              : 'https://w7.pngwing.com/pngs/104/119/png-transparent-orange-and-white-logo-computer-icons-icon-design-person-person-miscellaneous-logo-silhouette.png',
                        )),
                    Text('${displayGname ?? BaseHelper.name}')
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.book_online),
              title: Text('My Appointments'),
              onTap: () {
                // Handle drawer item tap
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyAppiontmentsScreen()));
                //// Close the drawer
                // Add any navigation logic here
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_support_outlined),
              title: Text('Contact Us'),
              onTap: () {
                // Handle drawer item tap
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ChatScreen()));
                //// Close the drawer
                // Add any navigation logic here
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('About Us'),
              onTap: () {
                // Handle drawer item tap
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AboutUsScreen()));
                //Navigator.pop(context); // Close the drawer
                // Add any navigation logic here
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle drawer item tap
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
                // Close the drawer
                // Add any navigation logic here
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text('Privacy Policy'),
              onTap: () {
                // Handle drawer item tap
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen()));
                //// Close the drawer
                // Add any navigation logic here
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text('Home', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationScreen()));
              },
              icon: Icon(Icons.notifications_outlined)),
          SizedBox(
            width: 15,
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text('   Hi, ${displayGname ?? BaseHelper.name}',
                style: MainHeading1),
            const SizedBox(
              height: 5,
            ),
            Text(
              '     Find your suitable doctor',
              style: SubHeading1,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('    Lets Find Your Doctor', style: MainHeading2),
                 InkWell(
                   onTap: (){
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => SearchScreen()),
                     );
                   },
                   child: Text(
                    'See all      ',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                   ),
                 )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: IgnorePointer(
                  ignoring: true,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search...',
                      // Add a clear button to the search bar
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.tune_outlined),
                        onPressed: () {},
                      ),
                      // Add a search icon or button to the search bar
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // Perform the search here
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: FutureBuilder(
                future: getdata(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return ListView.builder(
                    itemCount: doc.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            print(
                                '${baseurl}+${doc.elementAt(index).image.toString()}');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DoctorProfile(
                                    doctorName:
                                        doc.elementAt(index).name.toString(),
                                    doctorProfileURL:
                                        "${baseurl}${doc.elementAt(index).image.toString()}")));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: const SizedBox(
                                  height: 30,
                                )),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(doc.elementAt(index).name.toString(),
                                        style: MainHeading2),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      doc
                                          .elementAt(index)
                                          .speciality
                                          .toString(),
                                      style: SubHeading1,
                                    ),
                                  ],
                                ),
                                Flexible(
                                    child: const SizedBox(
                                  height: 10,
                                )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "${baseurl}${doc.elementAt(index).image.toString()}"),
                                        ),
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    const Icon(
                                      Icons.medical_services_outlined,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                        child: Column(
                                      children: [
                                        Text('Experience',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey)),
                                        Text(
                                          '${doc.elementAt(index).experience.toString()} Years',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        )
                                      ],
                                    )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Container(
                                        child: Column(
                                      children: const [
                                        Text('5.0',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey)),
                                        Text('Rating',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey))
                                      ],
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('    Your Appointment', style: MainHeading2),
                 InkWell(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                         builder: (context) => MyAppiontmentsScreen()));
                   },
                   child: Text(
                    'See all      ',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                   ),
                 )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Consumer(
                builder: (context, watch, child) {
                  // Use watch to access the data provider
                  final dsataState = watch.watch(dsata);

                  // Based on the state of dsata, display appropriate content
                  return dsataState.when(
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Text('Error: $error'),
                    data: (bookingHistoryList) {
                      if (bookingHistoryList.isEmpty) {
                        // Display a message when the list is empty
                        return Padding(
                          padding: const EdgeInsets.only(top: 50,left:  60),
                          child: Text('You have no Upcoming Appointments '),
                        );
                      } else {
                        // Display the list of appointments
                        return Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Container(
                              height: constraints.maxHeight, // Adjust as needed
                              width: constraints.maxWidth,
                              child: ListView(
                                primary: false,
                                children: bookingHistoryList.map((bookingHistory) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: MediaQuery.of(context).size.width / 1.1,
                                    height: MediaQuery.of(context).size.height / 6,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundColor: Colors.grey.shade200,
                                              backgroundImage: NetworkImage(
                                                BaseHelper.Guserphotourl != null && BaseHelper.Guserphotourl.isNotEmpty
                                                    ? BaseHelper.Guserphotourl.toString()
                                                    : 'https://w7.pngwing.com/pngs/104/119/png-transparent-orange-and-white-logo-computer-icons-icon-design-person-person-miscellaneous-logo-silhouette.png',
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: const [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                    ),
                                                    Text('5.0')
                                                  ],
                                                ),
                                                Text(
                                                  bookingHistory.name.toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  bookingHistory.subject.toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              height: MediaQuery.of(context).size.height / 10,
                                              width: MediaQuery.of(context).size.width / 3,
                                              child: GoogleMap(
                                                zoomControlsEnabled: false,
                                                mapType: MapType.hybrid,
                                                initialCameraPosition: CameraPosition(
                                                  target: LatLng(31.5119009, 74.3419418),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          indent: 15,
                                          endIndent: 15,
                                          thickness: 2,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 15),
                                            Icon(Icons.medical_services_outlined, color: Colors.grey),
                                            Text(
                                              bookingHistory.email.toString(),
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                        );
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
