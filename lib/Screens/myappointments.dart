import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/booking_history.dart';
import '../Widgets/BaseHelper.dart';
import '../Widgets/widgets.dart';
import 'package:http/http.dart' as http;

class MyAppiontmentsScreen extends StatefulWidget {
  const MyAppiontmentsScreen({Key? key}) : super(key: key);
  @override
  State<MyAppiontmentsScreen> createState() => _MyAppiontmentsScreenState();
}

class _MyAppiontmentsScreenState extends State<MyAppiontmentsScreen> {
  List<BookingHistory> dataList = [];

  @override
  void initState() {
    //  fetchHistory();
    super.initState();
  }

  fetchHistory() async {
    final response = await http.get(
      Uri.parse('https://doclive.info/api/getbooked?user_id=${BaseHelper.ids}'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      for (Map<String, dynamic> asas in data) {
        dataList.add(BookingHistory.fromJson(asas));
      }
    } else {
      throw Exception('Failed to fetch slots');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Appointments'),
        ),
        body: FutureBuilder(
          future: fetchHistory(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while fetching data
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Display an error message if fetching data fails
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || (snapshot.data as List).isEmpty) {
              // Display a message when the data list is null or empty
              return Center(child: Text('No appointments'));
            } else {
              // Display the list of appointments
              return ListView.builder(
                itemCount: dataList.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                                  BaseHelper.Guserphotourl != null
                                      ? BaseHelper.Guserphotourl.toString()
                                      : 'https://www.freepik.com/icon/man_180656',
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
                                    dataList[index].name.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    dataList[index].subject.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  )
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
                                    target: LatLng(31.5204, 74.3587),
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
                                '  ${dataList[index].createdAt.toString()}',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        )
    );
  }
}
