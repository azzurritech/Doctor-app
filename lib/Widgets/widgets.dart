
import 'package:doctor_app_updated/Screens/doctorprofile.dart';
import 'package:flutter/material.dart';
import '../Constants/constants.dart';
import '../Screens/details.dart';
import '../Screens/myappointments.dart';


class BottomSheetInsideCW extends StatefulWidget {
  final String doctorName;
  final String doctorProfileURL;
  BottomSheetInsideCW({required this.doctorName,required this.doctorProfileURL});
  @override
  State<BottomSheetInsideCW> createState() => _BottomSheetInsideCWState();
}
class _BottomSheetInsideCWState extends State<BottomSheetInsideCW> {
  //listview day date
  int selectedListViewContainerIndex = 0;
  void selectListViewContainer(int index) {
    setState(() {
      selectedListViewContainerIndex = index;
    });
  }
  Widget buildListViewContainer(int index) {
    final isSelected = index == selectedListViewContainerIndex;
    final color = isSelected ? Colors.blue : Colors.grey.shade200;
    return GestureDetector(
      onTap: () => selectListViewContainer(index),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            //Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Mon', style: TextStyle(color: Colors.grey)),
            Text(
              '20',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      )
    );
  }



  //Morning Slots
  late int selectedSlotContainerIndex = 0;
  List<String> slotsList =['Morning','AfterNoon','Evening'];
  void selectContainer(int index) {
    setState(() {
      selectedSlotContainerIndex = index;
    });
  }
  Widget buildSlotsContainer(int index) {
    final isSelected = index == selectedSlotContainerIndex;
    final color = isSelected ? Colors.blue : Colors.grey.shade200;

    return GestureDetector(
      onTap: () => selectContainer(index),
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(15)),
          height: 50,
          width: MediaQuery.of(context).size.width / 3.5,
          child: Center(child: Text(appointments.elementAt(index).starttime ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)),
        ),
      )
    );
  }

  //Time slot
  int selectedTimeContainerIndex = 2;
  List<String> timeList =['Nine','Ten','Six','Five'];
  void selectTimeContainer(int index) {
    setState(() {
      selectedTimeContainerIndex = index;
    });
  }
  Widget buildTimeContainer(int index, String text) {
    final isSelected = index == selectedTimeContainerIndex;
    final color = isSelected ? Colors.blue : Colors.grey.shade200;

    return GestureDetector(
      onTap: () => selectTimeContainer(index),
      child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(15)),
          height: 50,
          width: MediaQuery.of(context).size.width / 5,
          child: Center(child: Text(text,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)),
        ),
      ),

    );
  }


  //Appointment online offline
  int selectedAppointmentTypeIndex = 0;
  List<String> appointmentTypeList =['Online','Offline'];
  void selectAppointment(int index){
    setState(() {
      selectedAppointmentTypeIndex = index;
    });
  }
  Widget buildAppointmentContainer(int index, String text) {
    final isSelected = index == selectedAppointmentTypeIndex;
    final color = isSelected ? Colors.blue : Colors.grey.shade200;
    return GestureDetector(
      onTap: () =>selectAppointment(index),
      child:
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(15)),
          height: 45,
          width: MediaQuery.of(context).size.width / 2.5,
          child: Center(child: Text(text,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(50),
              topRight: Radius.circular(50))),
      child: Column(
        children: <Widget>[
          Flexible(
            child: SizedBox(
              height: 15,
            ),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: SizedBox(
                  width: 20,
                ),
              ),
              Text(
                'Schedule',
                style: MainHeading2,
              ),
              Flexible(child: SizedBox(width: MediaQuery.of(context).size.width / 2)),
              const Text('Oct 2022'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          //listviewbuilder date day
          Container(
            height: MediaQuery.of(context).size.height / 8,
            child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: buildListViewContainer(index),
                  );
                }),
          ),
          const Flexible(
            child: SizedBox(
              height: 5,
            ),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                'Slots',
                style: MainHeading2,
              ),
            ],
          ),
          Flexible(
            child: SizedBox(
              height: 5,
            ),
          ),
          //slots morning etc
          Container(
            height: MediaQuery.of(context).size.height/14,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: appointments.length,
                itemBuilder: (BuildContext context, int index){
                  final isSelected = index == selectedSlotContainerIndex;
                  final color = isSelected ? Colors.blue : Colors.grey.shade200;
                  return GestureDetector(
                  onTap: () => selectContainer(index),
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: Center(child: Text(appointments.elementAt(index).starttime ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)),
                        ),
                      )
                  );
                  // return Text(appointments.elementAt(index).starttime.toString());
              // return buildSlotsContainer(appointments.elementAt(index) );
            }),
          ),
          const Flexible(
            child: SizedBox(
              height: 10,
            ),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                'Time',
                style: MainHeading2,
              ),
            ],
          ),
          const Flexible(
            child: SizedBox(
              height: 10,
            ),
          ),
          //time slot
          Container(
            height: MediaQuery.of(context).size.height/14,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: timeList.length,
                itemBuilder: (BuildContext context, int index){
                  return buildTimeContainer(index, timeList[index]);
                }),
          ),
          const Flexible(
            child: SizedBox(
              height: 10,
            ),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                'Appointment Type',
                style: MainHeading2,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          //appointment type online offline
          Container(
            height: MediaQuery.of(context).size.height/14,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: appointmentTypeList.length,
                itemBuilder: (BuildContext context, int index){
                  return buildAppointmentContainer(index, appointmentTypeList[index]);
                }),
          ),
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       buildAppointmentContainer('Online', isOnlineSelected),
          //       buildAppointmentContainer('Offline', !isOnlineSelected)
          //     ]),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                width: MediaQuery.of(context).size.width / 1.2,
                height: 55,
                child: const Center(child: Text('Confirm Appointment'))),
            onPressed: (){

              String selectedSlotis = slotsList[selectedSlotContainerIndex].toString();
              String selectedTimeis = timeList[selectedTimeContainerIndex].toString();
              String selectedAppointmentis = appointmentTypeList[selectedAppointmentTypeIndex].toString();

              //print(_selectedAppointmentis);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsScreenC(
                doctorName: widget.doctorName,
                doctorProfileURL: widget.doctorProfileURL,
                slotName: selectedSlotis,
                slotTime: selectedTimeis,
                AppointmentType: selectedAppointmentis,
              )));
              },
          ),
        ],
      ),
    );
  }
}
