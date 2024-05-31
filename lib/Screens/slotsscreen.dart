import 'package:doctor_app_updated/Widgets/alertdialogue.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/allslots.dart';
import 'package:intl/intl.dart';
import '../Widgets/BaseHelper.dart';

Set<AllSlots> AllslotsList={};

class SlotsScreen extends StatefulWidget {
  const SlotsScreen({Key? key}) : super(key: key);

  @override
  State<SlotsScreen> createState() => _SlotsScreenState();
}

class _SlotsScreenState extends State<SlotsScreen> {
  late List<DateTime> dateList;
  final TextEditingController password=TextEditingController();
  @override
  void initState() {
    super.initState();
    generateDateList(); // Generate the list of dates
  }
  var date;
  DateTime? currentDate;
  void generateDateList() {
    dateList = [];   
     currentDate = DateTime.now();
    for (int i = 0; i < 7; i++) {
      dateList.add(currentDate!.add(Duration(days: i)));
    }
  }
 //  Widget buildDateContainer(DateTime date) {
 //    return GestureDetector(
 //      onTap: () {
 //       setState(() {
 //         currentDate=date;
 //       });
 //      },
 //      child: Container(
 //        decoration: BoxDecoration(
 // color:  currentDate != null ?  Colors.green: Colors.black,
 //          borderRadius: BorderRadius.circular(15),
 //        ),
 //        child: Center(
 //          child: Column(
 //            mainAxisAlignment: MainAxisAlignment.center,
 //            children: [
 //              Text(
 //                DateFormat('EEE').format(date), // Format to display day (e.g., "Mon")
 //                style: TextStyle(
 //                  color: Colors.black,
 //                  fontWeight: FontWeight.bold,
 //                ),
 //              ),
 //              SizedBox(height: 8),
 //              Text(
 //                DateFormat('dd').format(date), // Format to display date (e.g., "16")
 //                style: TextStyle(
 //                  color: Colors.white,
 //                  fontWeight: FontWeight.bold,
 //                ),
 //              ),
 //            ],
 //          ),
 //        ),
 //      ),
 //    );
 //  }
  @override
  void dispose() {
    AllslotsList.clear();
    super.dispose();
  }
  int selected= 0;
  int slotselected= 0;
  void selct(int index){
    setState(() {
      selected=index;
    });
  }
  void selctslot(int index){
    setState(() {
      slotselected=index;
    });
  }

   fetchSlots() async {
    final response = await http.get(Uri.parse('https://doclive.info/api/allslots'));
    //https://doclive.info/api/allslots
    //https://api-v2.appoltrepo.it/api/museum/it/
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      for(Map<String,dynamic> asas in data){
        AllslotsList.add(AllSlots.fromJson(asas));
      }
    } else {
      throw Exception('Failed to fetch slots');
    }
  }
  bookappointment(String name,String email, int slotid, int? userid,String subject,String date) async {
    var data=await http.post(Uri.parse('https://doclive.info/api/booked'), body: {
      'name':name,
      'email':email,
      'slot_id':slotid.toString(),
     'subject':subject,
      'user_id':userid.toString(),
      'date':date,
    });
    if(data.statusCode==200){
     final datas=json.decode(data.body);
     final asss=datas['message'];
     context.showerrordialogue(asss.toString());
     print('ok');
      print( BaseHelper.ids);
      print(data.body);
      // context.showerrordialogue(data.body);

    }
    else{
      context.showerrordialogue(data.body);

    }
  }

  int selectedContainerIndex = 1;
  void selectContainer(int index) {
    setState(() {
      selectedContainerIndex = index;
    });
  }

  Color getContainerColor(int index) {
    return index == selectedContainerIndex ? Colors.blue : Colors.lightBlueAccent;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Select Any Time Slot",style: TextStyle(color: Colors.black)),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined,color: Colors.black,))],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: password,
              //onChanged: _updateSubject,
              decoration: const InputDecoration(
                labelText: 'Subject for appointment',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            height: 50,
            //color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectContainer(0);
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      color: getContainerColor(0),
                      child: Center(
                        child: Text(
                          'Online',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectContainer(1);
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      color: getContainerColor(1),
                      child: Center(
                        child: Text(
                          'Offline',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
                // children: [
                //   Container(
                //     decoration: BoxDecoration(
                //       color: Colors.blue,
                //       //color:selected==index ? Colors.blue:Colors.lightBlueAccent  ,
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     width: 100,
                //     child: Center(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'Online',
                //             style: TextStyle(
                //               color: Colors.black,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //
                //         ],
                //       ),
                //     ),
                //   ),
                //   Container(
                //     decoration: BoxDecoration(
                //       color: Colors.blue,
                //       //color:selected==index ? Colors.blue:Colors.lightBlueAccent  ,
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     width: 100,
                //     child: Center(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'Offline',
                //             // DateFormat('EEE').format(dateList[index]),
                //             // Format to display day (e.g., "Mon")
                //             style: TextStyle(
                //               color: Colors.black,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //
                //         ],
                //       ),
                //     ),
                //   ),
                // ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 180,
              child: GridView.builder(
                // ... Your existing GridView.builder properties
                itemCount: dateList.length,
                itemBuilder: (context, index) {
                  // return buildDateContainer(dateList[index]);
                    return GestureDetector(
                    onTap: () {
                     selct(index);
                      date=  DateFormat('dd MMM yyyy').format(dateList[index]);
                      print(date);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:selected==index ? Colors.blue:Colors.lightBlueAccent  ,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
    DateFormat('EEE').format(dateList[index]),
     // Format to display day (e.g., "Mon")
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              DateFormat('dd').format(dateList[index]), // Format to display date (e.g., "16")
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2.5,
                crossAxisCount: 3, // Number of columns in the grid
                mainAxisSpacing: 10, // Spacing between rows
                crossAxisSpacing: 15, // Spacing between columns
              ),
              ),
            ),
          ),
          Container(
            height: 500,
            child: FutureBuilder(
              future: fetchSlots(),
                //itemCount: AllslotsList.length,
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                  //final color = index % 2 == 0 ? Colors.blue : Colors.green;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2,
                        crossAxisCount: 3, // Number of columns in the grid
                        mainAxisSpacing: 10, // Spacing between rows
                        crossAxisSpacing: 15, // Spacing between columns
                      ),
                      itemCount: AllslotsList.length,
                      itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: () {
                          selctslot(index);
                       // selct(index);
                      },
                        child: Container(
                          // width: 100, // Width of the container
                          // height: 100, //
                          decoration: BoxDecoration(
                            // color: color,
                            color:slotselected==index ? Colors.blue:Colors.lightBlueAccent  ,
                            //color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // height: 20,
                          // width: 40,
                          child: Center(
                            child: Text(
                              AllslotsList.elementAt(index).starttime.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },

            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Text('Book',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
          onPressed: () async{
            final subject=password.text.toString();
      if(subject.isNotEmpty){
        bookappointment(BaseHelper.name ,BaseHelper.email, slotselected , BaseHelper.ids, subject, date);
      }
      else{
        context.showerrordialogue("Enter subject");
      }
      }),
    );
  }
}