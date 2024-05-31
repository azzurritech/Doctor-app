///////////////////////////////OLD UI with old apis   ///////////////////////////

// import 'package:contacta_pharmacy/providers/auth_provider.dart';
// import 'package:contacta_pharmacy/providers/shedule_call_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../models/availableSlots_model.dart';

// class DoctorTimeAvailibility extends ConsumerStatefulWidget {
//   DoctorTimeAvailibility({Key? key,}) : super(key: key);
//   static const routeName = '/bookedSlots';

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _DoctorTimeAvailibilityState();
// }

// class _DoctorTimeAvailibilityState
//     extends ConsumerState<DoctorTimeAvailibility> {
//   @override
//   void didChangeDependencies() {
//     ref.watch(sheduleCallProvider).initialDaySelected(ref);
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//   }
//   TextEditingController purposeController=TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             body: Container(
//               color: Colors.grey,
//               child: Column(
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(left: 25, right: 15, top: 20),
//                     child: Text(
//                       'DOCTOR IS NOT AVAILABLE right now',
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       width: double.infinity,
//                       margin: const EdgeInsets.only(top: 30),
//                       decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           )),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: const [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(
//                                 Icons.help,
//                                 color: Colors.grey,
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Flexible(
//                                 child: Text(
//                                     "Doctor is Not available right now schedule a meeting"),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Icon(
//                                 Icons.warning,
//                                 size: 55,
//                                 color: Colors.grey,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       circleContainer(Colors.green),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       const Text('Available')
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       circleContainer(Colors.red),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       const Text('Not Available')
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 3, vertical: 10),
//                             child: Wrap(
//                                 runSpacing:
//                                     MediaQuery.of(context).size.width * 0.02,
//                                 children: ref
//                                     .watch(sheduleCallProvider)
//                                     .weekDayList
//                                     .map((e) => Container(
//                                           margin: EdgeInsets.only(
//                                             left: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.01,
//                                           ),
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 12, vertical: 4),
//                                           decoration: BoxDecoration(
//                                               color: ref
//                                                           .watch(
//                                                               sheduleCallProvider)
//                                                           .daySelected ==
//                                                       e
//                                                   ? Colors.green
//                                                   : Colors.grey,
//                                               borderRadius:
//                                                   BorderRadius.circular(20)),
//                                           child: InkWell(
//                                               onTap: () {
//                                                 ref
//                                                     .watch(sheduleCallProvider)
//                                                     .available
//                                                     .clear();
//                                                 ref
//                                                     .read(sheduleCallProvider)
//                                                     .daySelected = e;
//                                                 ref
//                                                     .read(sheduleCallProvider)
//                                                     .available
//                                                     .addAll(ref.watch(sheduleCallProvider).slots
//                                                         .where((element) {
//                                                   return element.day.name ==
//                                                       ref
//                                                           .watch(
//                                                               sheduleCallProvider)
//                                                           .daySelected;
//                                                 }));
//                                                 // print(listSlots
//                                                 //     .map((e) => e.day.name));
//                                                 print({
//                                                   ref
//                                                       .watch(
//                                                           sheduleCallProvider)
//                                                       .available
//                                                       .length
//                                                 });

//                                                 ref
//                                                     .watch(sheduleCallProvider)
//                                                     .notifyListeners();
//                                               },
//                                               child: Text(
//                                                 e,
//                                                 style: TextStyle(
//                                                     color: ref
//                                                                 .watch(
//                                                                     sheduleCallProvider)
//                                                                 .daySelected ==
//                                                             e
//                                                         ? Colors.white
//                                                         : Colors.black),
//                                               )),
//                                         ))
//                                     .toList()),
//                           ),
//                           ref.watch(sheduleCallProvider).load
//                               ? Expanded(
//                                   child: const Center(
//                                       child:
//                                           CircularProgressIndicator.adaptive()),
//                                 )
//                               : Expanded(
//                                   child: GridView.builder(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 10),
//                                     itemCount: ref
//                                         .watch(sheduleCallProvider)
//                                         .available
//                                         .length,
//                                     gridDelegate:
//                                         const SliverGridDelegateWithMaxCrossAxisExtent(
//                                             maxCrossAxisExtent: 150,
//                                             mainAxisExtent: 40,
//                                             mainAxisSpacing: 20,
//                                             crossAxisSpacing: 30),
//                                     itemBuilder: (context, index) {
//                                       return InkWell(
//                                         onTap: () {
//                                           if (ref
//                                                       .watch(
//                                                           sheduleCallProvider)
//                                                       .available[index]
//                                                       .available ==
//                                                   0 &&
//                                               !ref
//                                                   .watch(sheduleCallProvider)
//                                                   .available
//                                                   .map((e) => e.userId)
//                                                   .contains(ref
//                                                       .watch(authProvider)
//                                                       .user
//                                                       ?.userId
//                                                       .toString())) {
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return CustomDialog(
//                                                   content:
//                                                       'Do you want to Shedule your call on this time${ref.watch(sheduleCallProvider).available[index].starttime.substring(0, 5)} - ${ref.watch(sheduleCallProvider).available[index].endtime.substring(0, 5)}',
//                                                   title: 'Available To Shedule',
//                                                   onPressed: () async {
//                                                     Navigator.pop(context);
//                                                     ref
//                                                             .read(
//                                                                 sheduleCallProvider
//                                                                     )
//                                                             .bookedStartTime =
//                                                         ref
//                                                             .watch(
//                                                                 sheduleCallProvider)
//                                                             .available[index]
//                                                             .starttime;
//                                                     ref
//                                                             .read(
//                                                                 sheduleCallProvider
//                                                                     )
//                                                             .bookedEndTime =
//                                                         ref
//                                                             .watch(
//                                                                 sheduleCallProvider)
//                                                             .available[index]
//                                                             .endtime;
//                                                     await ref
//                                                         .read(
//                                                             sheduleCallProvider)
//                                                         .bookedSlot(context,
//                                                             ref: ref,
//                                                             index: index  ,purpose: purposeController.text);

//                                                     ref
//                                                         .watch(
//                                                             sheduleCallProvider)
//                                                         .notifyListeners();
//                                                   },
//                                                   text: 'Ok',
//                                                   cancelOnPressed: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   showCancel: true,
//                                                 );
//                                               },
//                                             );
//                                           } else if (ref
//                                                       .watch(
//                                                           sheduleCallProvider)
//                                                       .available[index]
//                                                       .available ==
//                                                   1 &&
//                                               ref
//                                                       .read(authProvider)
//                                                       .user
//                                                       ?.userId
//                                                       .toString() !=
//                                                   ref
//                                                       .watch(
//                                                           sheduleCallProvider)
//                                                       .available[index]
//                                                       .userId) {
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return CustomDialog(
//                                                   content:
//                                                       'this is already selected by other user',
//                                                   title: 'Already Shedule',
//                                                   onPressed: () async {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   text: 'Close',
//                                                 );
//                                               },
//                                             );
//                                           } else if (ref
//                                                       .watch(
//                                                           sheduleCallProvider)
//                                                       .available[index]
//                                                       .available ==
//                                                   1 &&
//                                               ref
//                                                       .read(authProvider)
//                                                       .user
//                                                       ?.userId
//                                                       .toString() ==
//                                                   ref
//                                                       .watch(
//                                                           sheduleCallProvider)
//                                                       .available[index]
//                                                       .userId) {
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return CustomDialog(
//                                                   content:
//                                                       'You have already booked this time  ${ref.watch(sheduleCallProvider).available[index].starttime.substring(0, 5)} - ${ref.watch(sheduleCallProvider).available[index].endtime.substring(0, 5)}  are sure want to delete this call',
//                                                   title: 'Already Shedule',
//                                                   onPressed: () async {
//                                                     Navigator.pop(context);
//                                                     ref
//                                                         .read(
//                                                             sheduleCallProvider)
//                                                         .bookedEndTime = '';
//                                                     ref
//                                                         .read(
//                                                             sheduleCallProvider)
//                                                         .bookedStartTime = '';
//                                                     await ref
//                                                         .read(
//                                                             sheduleCallProvider)
//                                                         .cancelSlot(context,
//                                                             ref: ref,
//                                                             index: index);
//                                                     ref
//                                                         .watch(
//                                                             sheduleCallProvider)
//                                                         .notifyListeners();
//                                                   },
//                                                   cancelOnPressed: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   showCancel: true,
//                                                   text: 'Ok',
//                                                 );
//                                               },
//                                             );
//                                           }
//                                         },
//                                         child: customContainer(
//                                             context,
//                                             "${ref.watch(sheduleCallProvider).available[index].starttime.substring(0, 5)} - ${ref.watch(sheduleCallProvider).available[index].endtime.substring(0, 5)} ",
//                                             ref
//                                                     .read(authProvider)
//                                                     .user
//                                                     ?.userId
//                                                     .toString() ==
//                                                 ref
//                                                     .watch(sheduleCallProvider)
//                                                     .available[index]
//                                                     .userId,
//                                             index,
//                                             ref),
//                                         // child: Text(ref
//                                         //     .watch(sheduleCallProvider)
//                                         //     .timeList[index]),
//                                       );
//                                     },
//                                   ),
//                                 )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )));
//   }

//   Container customContainer(BuildContext context, String e,
//       bool currentSelected, index, WidgetRef ref) {
//     return Container(
//       // height: MediaQuery.of(context).size.height * 0.05,
//       // width: MediaQuery.of(context).size.height * 0.1,
//       decoration: currentSelected
//           ? BoxDecoration(
//               color: Colors.blue, borderRadius: BorderRadius.circular(8))
//           : BoxDecoration(
//               color:
//                   ref.watch(sheduleCallProvider).available[index].available == 0
//                       ? Colors.green
//                       : Colors.red,
//               borderRadius: BorderRadius.circular(8)),
//       child: Center(child: Text(e)),
//     );
//   }

//   Widget circleContainer(color) {
//     return Container(
//       height: 15,
//       width: 15,
//       decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//     );
//   }

//   Widget boxContainer(Color color, text, context) {
//     return Container(
//       alignment: Alignment.center,
//       height: MediaQuery.of(context).size.height * 0.05,
//       width: MediaQuery.of(context).size.height * 0.1,
//       decoration:
//           BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
//       child: Text("${text}"),
//     );
//   }
// }

// class CustomDialog extends StatelessWidget {
//   const CustomDialog({
//     Key? key,
//     required this.title,
//     required this.content,
//     required this.text,
//     this.onPressed,
//     this.cancelOnPressed,
//     this.showCancel,
//   }) : super(key: key);
//   final String title;
//   final String content;
//   final Function()? onPressed;
//   final Function()? cancelOnPressed;
//   final bool? showCancel;

//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       insetPadding: const EdgeInsets.all(20),
//       elevation: 70,
//       titlePadding: const EdgeInsets.only(top: 20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       contentPadding:
//           const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 25),
//       actionsPadding:
//           const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
//       // buttonPadding: const EdgeInsets.only(left: 12),
//       title: Center(
//         child: Text(
//           title,
//           style: const TextStyle(fontSize: 20),
//         ),
//       ),

//       content: Text(
//         content,
//         textAlign: TextAlign.center,
//         style: const TextStyle(fontSize: 16),
//       ),
//       backgroundColor: Colors.white,
//       actionsAlignment: MainAxisAlignment.center,
//       actions: [
//         Row(
//           mainAxisAlignment: showCancel == true
//               ? MainAxisAlignment.start
//               : MainAxisAlignment.center,
//           children: [
//             showCancel == true
//                 ? Expanded(
//                     child: SizedBox(
//                         height: 40,
//                         // width: 125,
//                         child: TextButton(
//                             style: TextButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 backgroundColor: Colors.green),
//                             onPressed: cancelOnPressed,
//                             child: const Text('Cancel',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 17,
//                                 )))),
//                   )
//                 : const SizedBox(),
//             const SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               flex: showCancel == true ? 1 : 0,
//               child: SizedBox(
//                   height: 40,
//                   // width: 125,
//                   child: TextButton(
//                       style: TextButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           backgroundColor: Colors.red),
//                       onPressed: onPressed,
//                       child: Text(text,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 17,
//                           )))),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

/////////////// new Ui with local db/////////////

import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../controller/scheduling_provider.dart';

String? date;

class DoctorTimeAvailibility extends ConsumerStatefulWidget {
  DoctorTimeAvailibility({
    Key? key,
  }) : super(key: key);
  static const routeName = '/bookedSlots';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorTimeAvailibilityState();
}

class _DoctorTimeAvailibilityState
    extends ConsumerState<DoctorTimeAvailibility> {
  @override
  void initState() {
    ref.read(sheduleCallProvider).daySelected =
        DateFormat('EEE dd MMM').format(DateTime.now());
    // TODO: implement initState
    super.initState();
  }

  @override
  TextEditingController purposeController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int _selectedOption = 1;
  @override
  Widget build(BuildContext context) {
//         var getApi =<getBookedModel> [
//
// getBookedModel(day: ref.watch(sheduleCallProvider).daySelected, starttime:ref.watch(sheduleCallProvider).timeSelected, name: 'Haroon', user_id: '41011')
//   ];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Time Choice',
            style: const TextStyle(color: Colors.green),
          ),
        ),
        body: ref.watch(sheduleCallProvider).load == true
            ? const Center(
                child: CircularProgressIndicator(
                    // color: ref.watch(flavorProvider).lightPrimary,

                    ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Radio(
                  //       value: 1,
                  //       groupValue: _selectedOption,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           _selectedOption = value!;
                  //         });
                  //       },
                  //     ),
                  //     Text('Clinic Appointment'),
                  //     Radio(
                  //       value: 2,
                  //       groupValue: _selectedOption,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           _selectedOption = value!;
                  //         });
                  //       },
                  //     ),
                  //     Text('Online Appointment'),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Radio(
                  //       value: 2,
                  //       groupValue: _selectedOption,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           _selectedOption = value!;
                  //         });
                  //       },
                  //     ),
                  //     Text('Option 2'),
                  //   ],
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Wrap(
                        runSpacing: MediaQuery.of(context).size.width * 0.04,
                        children: ref
                            .watch(sheduleCallProvider)
                            .newWeekDayList
                            .map((e) => Container(
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 16),
                                  decoration: BoxDecoration(
                                      color: ref
                                                  .watch(sheduleCallProvider)
                                                  .daySelected ==
                                              e
                                          ? Colors.blue
                                          : Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 0.04,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: InkWell(
                                      onTap: () async {
                                        ref
                                            .read(sheduleCallProvider)
                                            .daySelected = e;
                                        ref
                                            .watch(sheduleCallProvider)
                                            .notifyListeners();
                                        await ref
                                            .watch(sheduleCallProvider)
                                            .getAllSlots(context, e, false);
                                      },
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                            color: ref
                                                        .watch(
                                                            sheduleCallProvider)
                                                        .daySelected ==
                                                    e
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                ))
                            .toList()),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      alignment: Alignment.center,
                      child: Text(
                        'Select free Slot',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      itemCount: ref.read(sheduleCallProvider).ssList.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              mainAxisExtent: 40,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 30),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              if (ref.read(sheduleCallProvider).ssList[index]
                                          ['book'] ==
                                      false &&
                                  !ref
                                      .read(sheduleCallProvider)
                                      .ssList
                                      .map((e) => e['currentUser'])
                                      .contains(true)) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      content:
                                          "${"Do you want to shedule your call on this time"} ${ref.watch(sheduleCallProvider).ssList[index]['starttime'].substring(0, 5)} - ${ref.watch(sheduleCallProvider).ssList[index]['endtime'].substring(0, 5)}",
                                      title: 'Available to shedule',
                                      onPressed: () async {
                                        if (purposeController.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content:
                                                      Text('Please enter the purpose of Booking')));
                                        } else {
                                          Navigator.pop(context);
                                          ref
                                              .watch(sheduleCallProvider)
                                              .bookedSlot(
                                                context,
                                                ref: ref,
                                                purpose: purposeController.text,
                                                slotId: ref
                                                    .watch(sheduleCallProvider)
                                                    .ssList[index]['id'],
                                                bookedDate: ref
                                                    .watch(sheduleCallProvider)
                                                    .daySelected,
                                              );

                                          // ref
                                          //     .watch(sheduleCallProvider)
                                          //     .dateTime
                                          //     .add(
                                          //         "date : ${ref.watch(sheduleCallProvider).daySelected} time :  ${ref.watch(sheduleCallProvider).ssList[index]['starttime'].substring(0, 5)} - ${ref.watch(sheduleCallProvider).ssList[index]['endtime'].substring(0, 5)}");
                                          // ref
                                          //     .watch(sheduleCallProvider)
                                          //     .localBookSlot(ref
                                          //         .watch(
                                          //             sheduleCallProvider)
                                          //         .dateTime);
                                          // print(ref
                                          //     .watch(sheduleCallProvider)
                                          //     .dateTime
                                          //     .length);
                                          purposeController.clear();
                                          ref
                                              .watch(sheduleCallProvider)
                                              .notifyListeners();
                                          date = ref
                                              .watch(sheduleCallProvider)
                                              .daySelected;
                                          print(date);
                                        }
                                        await AwesomeNotifications()
                                            .createNotification(
                                                content: NotificationContent(
                                                 // icon: 'https://ibb.co/LkwQDjN',
                                                    id: 13,
                                                    channelKey: 'channelKey',
                                                    title: 'Slot booked',
                                                    body:
                                                        'Successfully booked slot on ${ref.watch(sheduleCallProvider).daySelected}'),
                                                schedule: NotificationCalendar
                                                    .fromDate(
                                                        repeats: true,
                                                        preciseAlarm: true,
                                                        date: DateTime
                                                                .now()
                                                            .add(Duration(
                                                                seconds: 1))));
                                      },
                                      text: 'Booking ok'.tr,
                                      cancelOnPressed: () {
                                        Navigator.pop(context);
                                        purposeController.clear();
                                      },
                                      showCancel: true,
                                      purposeController: purposeController,
                                      scrollController: scrollController,
                                      showPurpose: true,
                                    );
                                  },
                                );
                              } else if (ref
                                          .read(sheduleCallProvider)
                                          .ssList[index]['book'] ==
                                      true &&
                                  ref.read(sheduleCallProvider).ssList[index]
                                          ['currentUser'] ==
                                      false) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      content:
                                          'this_already_selected_by_other_user'
                                              .tr,
                                      title: 'already_shedule'.tr,
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      text: 'booked_Close'.tr,
                                    );
                                  },
                                );
                              } else if (ref
                                          .read(sheduleCallProvider)
                                          .ssList[index]['book'] ==
                                      true &&
                                  ref.read(sheduleCallProvider).ssList[index]
                                          ['currentUser'] ==
                                      true) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      content:
                                          '${"you have already book this slot"} ${ref.watch(sheduleCallProvider).ssList[index]['starttime'].substring(0, 5)} - ${ref.watch(sheduleCallProvider).ssList[index]['endtime'].substring(0, 5)} ',
                                      title: "Already Booked",
                                      cancelText: 'Booked no',
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        ref
                                            .watch(sheduleCallProvider)
                                            .cancelSlot(context,
                                                ref: ref, index: index);
                                        // ref
                                        //     .read(sheduleCallProvider)
                                        //     .localCancelSlot(
                                        //         "date : ${ref.watch(sheduleCallProvider).daySelected} time :  ${ref.watch(sheduleCallProvider).ssList[index]['starttime'].substring(0, 5)} - ${ref.watch(sheduleCallProvider).ssList[index]['endtime'].substring(0, 5)}");
                                        ref
                                            .watch(sheduleCallProvider)
                                            .notifyListeners();
                                      },
                                      cancelOnPressed: () {
                                        Navigator.pop(context);
                                      },
                                      showCancel: true,
                                      text: "Booked cancel",
                                    );
                                  },
                                );
                              }
                            },
                            child: customContainer(
                                context,
                                "${ref.watch(sheduleCallProvider).ssList[index]['starttime'].substring(0, 5)} - ${ref.watch(sheduleCallProvider).ssList[index]['endtime'].substring(0, 5)}",
                                index,
                                ref,
                                ref.watch(sheduleCallProvider).ssList[index]
                                        ['currentUser'] ==
                                    true));
                      },
                    ),
                  )
                ],
              ));
  }

  Container customContainer(
      BuildContext context, String e, index, WidgetRef ref, bool currentUser) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.05,
      // width: MediaQuery.of(context).size.height * 0.1,
      decoration: currentUser
          ? BoxDecoration(
              color: Colors.blue,

              // .contains(ref.watch(sheduleCallProvider).allSlots!.slots[index].id)?Colors.red:Colors.white,
              boxShadow: [
                const BoxShadow(
                  blurRadius: 0.04,
                )
              ],
              borderRadius: BorderRadius.circular(6))
          : BoxDecoration(
              color:
                  ref.watch(sheduleCallProvider).ssList[index]['book'] == true
                      ? Colors.red
                      : Colors.white,

              // .contains(ref.watch(sheduleCallProvider).allSlots!.slots[index].id)?Colors.red:Colors.white,
              boxShadow: [
                const BoxShadow(
                  blurRadius: 0.04,
                )
              ],
              borderRadius: BorderRadius.circular(6)),

      child: Center(child: Text(e)),
    );
  }

  Widget circleContainer(color) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget boxContainer(Color color, text, context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.height * 0.1,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text("${text}"),
    );
  }
}

class CustomDialog extends StatelessWidget {
  CustomDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.text,
      this.onPressed,
      this.cancelOnPressed,
      this.showCancel,
      this.cancelText,
      this.showPurpose,
      this.purposeController,
      this.scrollController})
      : super(key: key);
  final String title;
  final String content;
  final Function()? onPressed;
  final Function()? cancelOnPressed;
  final bool? showCancel;
  final bool? showPurpose;
  String? cancelText;
  final TextEditingController? purposeController;
  final ScrollController? scrollController;

  final String text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      elevation: 70,
      titlePadding: const EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding:
          const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 25),
      actionsPadding:
          const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
      // buttonPadding: const EdgeInsets.only(left: 12),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),

      content: showPurpose == true
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                detailField(context,
                    scrollController: scrollController,
                    controller: purposeController!)
              ],
            )
          : Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          mainAxisAlignment: showCancel == true
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            showCancel == true
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                          height: 40,
                          // width: 125,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  backgroundColor: Colors.green),
                              onPressed: cancelOnPressed,
                              child: Text(cancelText ?? 'Booking cancel',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  )))),
                    ),
                  )
                : const SizedBox(),
            Expanded(
              flex: showCancel == true ? 1 : 0,
              child: SizedBox(
                  height: 40,
                  // width: 125,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          backgroundColor: Colors.red),
                      onPressed: onPressed,
                      child: Text(text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          )))),
            ),
          ],
        ),
      ],
    );
  }

  Widget detailField(context,
      {required scrollController, required TextEditingController controller}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(16)),
      // height: 120,
      child: Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        child: TextFormField(
            scrollController: scrollController,
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: InputDecoration(
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
                hintText: "Write your purpose for sheduling"),
            minLines: 6,
            maxLines: 7,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            controller: controller),
      ),
    );
  }
}


















/////////////////////////////new///////////////////////
// import 'package:contacta_pharmacy/providers/auth_provider.dart';
// import 'package:contacta_pharmacy/providers/shedule_call_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../models/availableSlots_model.dart';
// import '../../../models/newGetAllSlotModel.dart';

// class DoctorTimeAvailibility extends ConsumerStatefulWidget {
//   DoctorTimeAvailibility({Key? key,}) : super(key: key);
//   static const routeName = '/bookedSlots';


//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _DoctorTimeAvailibilityState();
// }

// class _DoctorTimeAvailibilityState
//     extends ConsumerState<DoctorTimeAvailibility> {
//   @override
//   void didChangeDependencies() {

//     ref.watch(sheduleCallProvider).initialDaySelected(ref);
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//   }
//   TextEditingController purposeController=TextEditingController();

//   @override
//   Widget build(BuildContext context) {

// //         var getApi =<getBookedModel> [

// // getBookedModel(day: ref.watch(sheduleCallProvider).daySelected, starttime:ref.watch(sheduleCallProvider).timeSelected, name: 'Haroon', user_id: '41011')
// //   ];
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(centerTitle: true,title: Text('Time Choice',style: TextStyle(color: Colors.green),),),
//             body: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [


//                 Padding(

//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 5, vertical: 10),
//                   child: Wrap(
//                       runSpacing:
//                           MediaQuery.of(context).size.width * 0.04,
//                       children: ref
//                           .watch(sheduleCallProvider)
//                           .weekDayList
//                           .map((e) => Container(
//                                 margin: EdgeInsets.only(
//                                   left: MediaQuery.of(context)
//                                           .size
//                                           .width *
//                                       0.03,
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 16),
//                                 decoration: BoxDecoration(
//                                     color: ref
//                                                 .watch(
//                                                     sheduleCallProvider)
//                                                 .daySelected ==
//                                             e
//                                         ? Colors.blue
//                                         : Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(blurRadius: 0.04,)
//                                         ],
//                                     borderRadius:
//                                         BorderRadius.circular(8)),


//                                 child: InkWell(
//                                     onTap: () {
//                                       ref
//                                           .watch(sheduleCallProvider)
//                                           .available
//                                           .clear();
//                                       ref
//                                           .read(sheduleCallProvider)
//                                           .daySelected = e;
//                                       ref
//                                           .read(sheduleCallProvider)
//                                           .available
//                                           .addAll(ref.watch(sheduleCallProvider).slots
//                                               .where((element) {
//                                         return element.date==
//                                             ref
//                                                 .watch(
//                                                     sheduleCallProvider)
//                                                 .daySelected;
//                                       }));
//                                       // print(listSlots
//                                       //     .map((e) => e.day.name));
//                                       print({
//                                         ref
//                                             .watch(
//                                                 sheduleCallProvider)
//                                             .available
//                                             .length
//                                       });

//                                       ref
//                                           .watch(sheduleCallProvider)
//                                           .notifyListeners();
//                                     },
//                                     child: Text(
//                                       e,
//                                       style: TextStyle(
//                                           color: ref
//                                                       .watch(
//                                                           sheduleCallProvider)
//                                                       .daySelected ==
//                                                   e
//                                               ? Colors.white
//                                               : Colors.black),
//                                     )),
//                               ))
//                           .toList()),
//                 ),

//                 Container(
//                   margin: EdgeInsets.only(top: 10,bottom: 10),
//                   alignment: Alignment.center,
//                   child: Text('Select the free slot',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),
//                 ref.watch(sheduleCallProvider).load
//                     ? Expanded(
//                         child: const Center(
//                             child:
//                                 CircularProgressIndicator.adaptive()),
//                       )
//                     :
//                     Expanded(
//                         child: GridView.builder(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 10),
//                           itemCount: ref.read(sheduleCallProvider).timeList.length,

//                           gridDelegate:
//                               const SliverGridDelegateWithMaxCrossAxisExtent(
//                                   maxCrossAxisExtent: 150,
//                                   mainAxisExtent: 40,
//                                   mainAxisSpacing: 20,
//                                   crossAxisSpacing: 30),
//                           itemBuilder: (context, index) {


//                             return InkWell(
//                               onTap: (){
//     showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return CustomDialog(
//                                         content:
//                                             'Do you want to Shedule your call on this time ${ref.watch(sheduleCallProvider).timeList[index]}',
//                                         title: 'Available To Shedule',
//                                         onPressed: () async {
//                                           Navigator.pop(context);
//                            ref.watch(sheduleCallProvider).newBookedSlot(context, purpose: 'yes purpose', ref: ref);

//                                         },
//                                         text: 'Ok',
//                                         cancelOnPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         showCancel: true,
//                                       );
//                                     },
//                                   );

//                               },
//                               // onTap: () {
//                               //   if (ref
//                               //               .watch(
//                               //                   sheduleCallProvider)
//                               //               .available[index]
//                               //               .available ==
//                               //           0 &&
//                               //       !ref
//                               //           .watch(sheduleCallProvider)
//                               //           .available
//                               //           .map((e) => e.userId)
//                               //           .contains(ref
//                               //               .watch(authProvider)
//                               //               .user
//                               //               ?.userId
//                               //               .toString())) {
//                               //     showDialog(
//                               //       context: context,
//                               //       builder: (context) {
//                               //         return CustomDialog(
//                               //           content:
//                               //               'Do you want to Shedule your call on this time${ref.watch(sheduleCallProvider).available[index].starttime.substring(0, 5)} - ${ref.watch(sheduleCallProvider).available[index].endtime.substring(0, 5)}',
//                               //           title: 'Available To Shedule',
//                               //           onPressed: () async {
//                               //             Navigator.pop(context);
//                               //             ref
//                               //                     .read(
//                               //                         sheduleCallProvider
//                               //                             )
//                               //                     .bookedStartTime =
//                               //                 ref
//                               //                     .watch(
//                               //                         sheduleCallProvider)
//                               //                     .available[index]
//                               //                     .starttime;
//                               //             ref
//                               //                     .read(
//                               //                         sheduleCallProvider
//                               //                             )
//                               //                     .bookedEndTime =
//                               //                 ref
//                               //                     .watch(
//                               //                         sheduleCallProvider)
//                               //                     .available[index]
//                               //                     .endtime;
//                               //             await ref
//                               //                 .read(
//                               //                     sheduleCallProvider)
//                               //                 .bookedSlot(context,
//                               //                     ref: ref,
//                               //                     index: index  ,purpose: purposeController.text);

//                               //             ref
//                               //                 .watch(
//                               //                     sheduleCallProvider)
//                               //                 .notifyListeners();
//                               //           },
//                               //           text: 'Ok',
//                               //           cancelOnPressed: () {
//                               //             Navigator.pop(context);
//                               //           },
//                               //           showCancel: true,
//                               //         );
//                               //       },
//                               //     );
//                               //   } else if (ref
//                               //               .watch(
//                               //                   sheduleCallProvider)
//                               //               .available[index]
//                               //               .available ==
//                               //           1 &&
//                               //       ref
//                               //               .read(authProvider)
//                               //               .user
//                               //               ?.userId
//                               //               .toString() !=
//                               //           ref
//                               //               .watch(
//                               //                   sheduleCallProvider)
//                               //               .available[index]
//                               //               .userId) {
//                               //     showDialog(
//                               //       context: context,
//                               //       builder: (context) {
//                               //         return CustomDialog(
//                               //           content:
//                               //               'this is already selected by other user',
//                               //           title: 'Already Shedule',
//                               //           onPressed: () async {
//                               //             Navigator.pop(context);
//                               //           },
//                               //           text: 'Close',
//                               //         );
//                               //       },
//                               //     );
//                               //   } else if (ref
//                               //               .watch(
//                               //                   sheduleCallProvider)
//                               //               .available[index]
//                               //               .available ==
//                               //           1 &&
//                               //       ref
//                               //               .read(authProvider)
//                               //               .user
//                               //               ?.userId
//                               //               .toString() ==
//                               //           ref
//                               //               .watch(
//                               //                   sheduleCallProvider)
//                               //               .available[index]
//                               //               .userId) {
//                               //     showDialog(
//                               //       context: context,
//                               //       builder: (context) {
//                               //         return CustomDialog(
//                               //           content:
//                               //               'You have already booked this time  ${ref.watch(sheduleCallProvider).available[index].starttime.substring(0, 5)} - ${ref.watch(sheduleCallProvider).available[index].endtime.substring(0, 5)}  are sure want to delete this call',
//                               //           title: 'Already Shedule',
//                               //           onPressed: () async {
//                               //             Navigator.pop(context);
//                               //             ref
//                               //                 .read(
//                               //                     sheduleCallProvider)
//                               //                 .bookedEndTime = '';
//                               //             ref
//                               //                 .read(
//                               //                     sheduleCallProvider)
//                               //                 .bookedStartTime = '';
//                               //             await ref
//                               //                 .read(
//                               //                     sheduleCallProvider)
//                               //                 .cancelSlot(context,
//                               //                     ref: ref,
//                               //                     index: index);
//                               //             ref
//                               //                 .watch(
//                               //                     sheduleCallProvider)
//                               //                 .notifyListeners();
//                               //           },
//                               //           cancelOnPressed: () {
//                               //             Navigator.pop(context);
//                               //           },
//                               //           showCancel: true,
//                               //           text: 'Ok',
//                               //         );
//                               //       },
//                               //     );
//                               //   }
//                               // },


//                               child: customContainer(
//                                   context,
//                                       ref.watch(sheduleCallProvider).timeList[index],


//                                   // ref
//                                   //         .read(authProvider)
//                                   //         .user
//                                   //         ?.userId
//                                   //         .toString() ==
//                                   //     ref
//                                   //         .watch(sheduleCallProvider)
//                                   //         .available[index]
//                                   //         .userId,
//                                   index,
//                                   ref),
//                               // child: Text(ref
//                               //     .watch(sheduleCallProvider)
//                               //     .timeList[index]),
//                             );
//                           },
//                         ),
//                       )

//               ],
//             )));
//   }

//   Container customContainer(BuildContext context, String e,
//      index, WidgetRef ref) {

//    var time=ref.watch(sheduleCallProvider).available.map((x) => x.date==) ;
//     return Container(
//       // height: MediaQuery.of(context).size.height * 0.05,
//       // width: MediaQuery.of(context).size.height * 0.1,
//       // decoration: currentSelected
//       //     ? BoxDecoration(
//       //         color: Colors.blue, borderRadius: BorderRadius.circular(8))
//       //     : BoxDecoration(
//       //         // color:
//       //         //     ref.watch(sheduleCallProvider).available[index].available == 0
//       //         //         ? Colors.green
//       //         //         : Colors.red,

//       //         borderRadius: BorderRadius.circular(8)),
//        decoration: BoxDecoration(
//                                     color:ref.watch(sheduleCallProvider).available.map((e) => ) ?Colors.red:Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(blurRadius: 0.04,)
//                                         ],
//                                     borderRadius:
//                                         BorderRadius.circular(6)),


//       child: Center(child: Text(e)),
//     );
//   }

//   Widget circleContainer(color) {
//     return Container(
//       height: 15,
//       width: 15,
//       decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//     );
//   }

//   Widget boxContainer(Color color, text, context) {
//     return Container(
//       alignment: Alignment.center,
//       height: MediaQuery.of(context).size.height * 0.05,
//       width: MediaQuery.of(context).size.height * 0.1,
//       decoration:
//           BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
//       child: Text("${text}"),
//     );
//   }
// }

// class CustomDialog extends StatelessWidget {
//   const CustomDialog({
//     Key? key,
//     required this.title,
//     required this.content,
//     required this.text,
//     this.onPressed,
//     this.cancelOnPressed,
//     this.showCancel,
//   }) : super(key: key);
//   final String title;
//   final String content;
//   final Function()? onPressed;
//   final Function()? cancelOnPressed;
//   final bool? showCancel;

//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       insetPadding: const EdgeInsets.all(20),
//       elevation: 70,
//       titlePadding: const EdgeInsets.only(top: 20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       contentPadding:
//           const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 25),
//       actionsPadding:
//           const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
//       // buttonPadding: const EdgeInsets.only(left: 12),
//       title: Center(
//         child: Text(
//           title,
//           style: const TextStyle(fontSize: 20),
//         ),
//       ),

//       content: Text(
//         content,
//         textAlign: TextAlign.center,
//         style: const TextStyle(fontSize: 16),
//       ),
//       backgroundColor: Colors.white,
//       actionsAlignment: MainAxisAlignment.center,
//       actions: [
//         Row(
//           mainAxisAlignment: showCancel == true
//               ? MainAxisAlignment.start
//               : MainAxisAlignment.center,
//           children: [
//             showCancel == true
//                 ? Expanded(
//                     child: SizedBox(
//                         height: 40,
//                         // width: 125,
//                         child: TextButton(
//                             style: TextButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 backgroundColor: Colors.green),
//                             onPressed: cancelOnPressed,
//                             child: const Text('Cancel',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 17,
//                                 )))),
//                   )
//                 : const SizedBox(),
//             const SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               flex: showCancel == true ? 1 : 0,
//               child: SizedBox(
//                   height: 40,
//                   // width: 125,
//                   child: TextButton(
//                       style: TextButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           backgroundColor: Colors.red),
//                       onPressed: onPressed,
//                       child: Text(text,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 17,
//                           )))),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

