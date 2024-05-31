import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewAppointmentScreen extends StatelessWidget {
  const ViewAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    String doctorName = 'Dr. John Doe';
    String imagePath =
        'https://img.freepik.com/premium-photo/portrait-beautiful-mature-woman-doctor-lab-coat-hospital-shooting-studio_114579-92666.jpg?w=740';
    LatLng doctorLocation = const LatLng(37.7749, -122.4194);
    double rating = 4.5;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Appointment'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          CircleAvatar(
            backgroundImage: NetworkImage(imagePath),
            radius: 50.0,
          ),
          SizedBox(height: 16.0),
          Text(
            doctorName,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Rating: $rating',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width/1,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: doctorLocation,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('doctor_location'),
                  position: doctorLocation,
                ),
              },
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/2.3,
                height: MediaQuery.of(context).size.height/20,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Date',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                      Text('Sat, 15 Oct 2022',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ],
                  ),
                ),
              ),
              //slot time
              Container(
                width: MediaQuery.of(context).size.width/2.3,
                height: MediaQuery.of(context).size.height/20,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Slot',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                      Text('Morning',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ],
                  ),
                ),
              )
            ],),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/2.3,
                height: MediaQuery.of(context).size.height/20,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Appointment Type',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                      Text('Online',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/2.3,
                height: MediaQuery.of(context).size.height/20,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Time',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                      Text('Nine',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ],
                  ),
                ),
              )
            ],),
          SizedBox(height: 50,),
        ],
      ),
    );
  }
}
