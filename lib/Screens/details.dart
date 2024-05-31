
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Constants/constants.dart';

class DetailsScreenC extends StatefulWidget {
  final String doctorName;
  final String doctorProfileURL;
  final String slotName;
  final String slotTime;
  final String AppointmentType;
  const DetailsScreenC({required this.slotName,required this.slotTime,required this.AppointmentType,required this.doctorName,required this.doctorProfileURL});

  @override
  State<DetailsScreenC> createState() => _DetailsScreenCState();
}

class _DetailsScreenCState extends State<DetailsScreenC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Details',style: TextStyle(color: Colors.black)),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined,color: Colors.black,))],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 50,backgroundColor: primarycolor,
                child: Center(child: Icon(Icons.done,color: Colors.white,size: 46,)),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,children: [Text('Appointment Confirmed!',style: MainHeading1,)],),
          SizedBox(height: 50,),
          Container(
            decoration:
            BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width/1.1,height: MediaQuery.of(context).size.height/6,
            child: Column(
              children: [
                //SizedBox(height: MediaQuery.of(context).size.height/55),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(radius: 40,backgroundColor: Colors.grey.shade200,backgroundImage: NetworkImage(
                      widget.doctorProfileURL
                    )),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(Icons.star,color: Colors.yellow,),Text('5.0')],),
                           Text(widget.doctorName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                          const Text('General Surgery',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey),)
                        ]),
                    Container(decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height/10,
                      width: MediaQuery.of(context).size.width/3,
                      child:
                      GoogleMap(
                        zoomControlsEnabled: false,
                        mapType: MapType.hybrid,
                        initialCameraPosition:
                        CameraPosition(target: LatLng(31.5204, 74.3587),),
                      )
                    )
                  ],
                ),
                Divider(
                  indent: 15,endIndent: 15,
                  thickness: 2,
                ),
                Row(children: [SizedBox(width: 15,),Icon(Icons.medical_services_outlined,color: Colors.grey),Text(' 15 October 2022, 01:30 PM',style: TextStyle(color: Colors.grey),)],)
              ],
            ),
          ),
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
                      Text(widget.slotName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
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
                      Text(widget.AppointmentType,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
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
                      Text(widget.slotTime,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ],
                  ),
                ),
              )
            ],),
          SizedBox(height: 50,),
          Row(
            children: [
              Text('     Approximate Waiting Time',style: MainHeading2,),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width/1.1,
            height: MediaQuery.of(context).size.height/15,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Text('08 : 23',style: MainHeading1),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: (){},
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: primarycolor
          ),
          height: 50,width: MediaQuery.of(context).size.width/1.1,
          child: Center(child: Text('SET REMINDER',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }
}
