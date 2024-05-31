import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:doctor_app_updated/Constants/constants.dart';
import 'package:doctor_app_updated/Screens/schedulig/booked_slots.dart';
import 'package:doctor_app_updated/Screens/schedulig/videocall_page.dart';
import 'package:doctor_app_updated/Widgets/BaseHelper.dart';

// import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sheduleCallProvider = ChangeNotifierProvider(
  (ref) => SheduleCallProvider(),
);
final videoCamCheckProvider = StateProvider((ref) {
  return false;
});
final micheckProvider = StateProvider((ref) {
  return false;
});

// extension dateFormating on DateFormat{
//  englishToItalian(date){
// DateFormat("EEE dd MMM", 'en').parse(date);
//  }
// }
class SheduleCallProvider extends ChangeNotifier {
  Dio dio = Dio(BaseOptions(headers: {"ontent-Type": "application/json"}));
  // List weekDayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List newWeekDayList = [
    '${DateFormat('EEE dd MMM').format(DateTime.now())}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 1)))}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 2)))}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 3)))}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 4)))}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 5)))}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 6)))}'
  ];
  var daySelected = "";
  var bookedEndTime = '';
  var bookedStartTime = '';
  var adminStatus;
  bool? isPurposeText;

  // List<Slot> getSlot = [];
  var load = false;

  // NewGetSlotModel? allSlots;
  bool isApiLoading = false;
  // List<AvailableSlots> available = [];
  // List<AvailableSlots>slots = [];

  getCall(context, {required WidgetRef ref}) async {
    isApiLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await dio.post(
        "${AppConstants.BASE_URL_NEW}get_call/${BaseHelper.ids}",
      );
      print(response);
      if (response.statusCode == 200) {
        var message = response.data;
        if (message['message'] == "Call joined successfully") {
          isApiLoading = false;
          notifyListeners();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoView(
                  token: message['token'],
                ),
              ));
        } else {
          isApiLoading = false;
          notifyListeners();
          await getAllSlots(context,
              '${DateFormat('EEE dd MMM').format(DateTime.now())}', true);
        }
      } else {
        return;
      }
    } on DioException catch (e) {
      print(e);
    }
    isApiLoading = false;
    notifyListeners();
  }

  getAdminStatus(context) async {
    try {
      final response = await dio.get(
        "${AppConstants.BASE_URL_NEW}status",
      );
      if (response.statusCode == 200) {
        print(response.data["data"]["value"]);
        adminStatus = response.data["data"]["value"];
        notifyListeners();
        //Navigator.pushNamed(context, DoctorAvailability.routeName);

        print(adminStatus);
      } else {
        print("error");
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  List<dynamic> listBookSlot = [];
  List<dynamic> responseSlots = [];
  List<dynamic> ssList = [];
  List<dynamic> responseBooked = [];
  String lang = '';
  getAllSlots(context, String daySelected, bool isRoute) async {
    print(daySelected);

    load = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();

    ssList.clear();
    responseSlots.clear();
    responseBooked.clear();

    final response = await dio.get(
      "${AppConstants.BASE_URL_NEW}slots/${daySelected}",
    );

    try {
      if (response.statusCode == 200) {
        responseSlots = response.data['slots'];
        responseBooked = response.data['booked'];
        ssList.addAll(responseSlots);
        for (Map i in ssList) {
          for (Map j in responseBooked) {
            if (i['id'] == j['slot_id']) {
              i['book'] = true;
              i['currentUser'] = false;
              if (j["user_id"] == '${BaseHelper.ids}') {
                i['book'] = true;
                i['currentUser'] = true;
              }
            } else if (!i.containsKey('book')) {
              i['book'] = false;
              i['currentUser'] = false;
            }
          }
          if (!i.containsKey('book')) {
            i['book'] = false;
            i['currentUser'] = false;
          }
        }
        log("$ssList");
        load = false;
        notifyListeners();
        isRoute == true
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorTimeAvailibility(),
                ))
            : null;
      } else {
        load = false;

        notifyListeners();
        //showInSnackBar('got some error', context);
      }
    } on DioError catch (e) {
      load = false;
      notifyListeners();
      // showInSnackBar('got some error', context);
    }
  }

  // localBookSlot(List<String>? dateTime) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('dateTime', dateTime!);
  // }

  // localCancelSlot(String value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   dateTime = prefs.getStringList('dateTime')!;
  //   dateTime.remove(value);
  //   prefs.setStringList("dateTime", dateTime);
  // }

  // localGetSlot() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   dateTime = prefs.getStringList('dateTime')!;
  // }

  bookedSlot(context,
      {required WidgetRef ref,
      required String purpose,
      required int slotId,
      required bookedDate}) async {
    load = true;
    notifyListeners();
    // final user = ref.read(authProvider).user;
    // var englishDate = DateFormat("EEE dd MMM", 'it').parse(bookedDate);
    final prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString("fname");
    String? email = prefs.getString("email");

    Map<String, dynamic> data = {
      "slot_id": slotId,
      // "date": DateFormat("EEE dd MMM", 'en').format(englishDate).toString(),
      "date": bookedDate,
      "user_id": '${BaseHelper.ids}',
      "email": email,
      "name": BaseHelper.name,
      "subject": purpose
    };

    try {
      final response =
          await dio.post("${AppConstants.BASE_URL_NEW}booked", data: data);
      if (response.statusCode == 200) {
        var message = response.data;
        await getAllSlots(context, daySelected, false);

        print(message['message']);
      } else {
        load = false;
        print("error");
      }
    } on DioException catch (e) {
      load = false;
      // showInSnackBar('got some error', context);
    }
  }

  cancelCallApi() async {
    final prefs = await SharedPreferences.getInstance();

    final response = await dio.post(
      "${AppConstants.BASE_URL_NEW}end_call/${BaseHelper.ids}",
    );
    if (response.data["message"] == "Call ended successfully") {
      return;
    } else {
      print('error');
    }
  }
  // newGetAllSlots(context) async {
  //   final response = await _apisNew.newGetSlots();
  //   try {
  //     if (response.statusCode == 200) {
  //       slots.clear();

  //       slots.addAll(response.data
  //           .map<NewGetAllSlotModel>((e) => NewGetAllSlotModel.fromJson(e))
  //           .toList());

  //       Navigator.pushNamed(context, DoctorTimeAvailibility.routeName,
  //          );
  //       return;
  //     } else {
  //       return;
  //     }
  //   } on DioError catch (e) {
  //     print(e);
  //   }
  // }
  // newBookedSlot(context, {required WidgetRef ref, required String purpose }) async {
  //   load = true;
  //   notifyListeners();
  //   final user = ref.read(authProvider).user;
  //   Map<String, dynamic> data = {
  //     'date': daySelected,
  //     'time': timeSelected,
  //     'user_id': user?.userId.toString(),
  //     'name':"${user?.firstName} ${user?.lastName}",
  //     'email':user?.email.toString(),
  //     'subject' :purpose
  //   };
  //   final response = await _apisNew.newBookedSlots(data);
  //   try {
  //     if (response.statusCode == 200) {
  //       var message = response.data;
  //       print(message);
  //       final responseAll = await _apisNew.newGetSlots();
  //       try {
  //         if (responseAll.statusCode == 200) {
  //           slots.clear();

  //           slots.addAll(responseAll.data
  //               .map<NewGetAllSlotModel>((e) => NewGetAllSlotModel.fromJson(e))
  //               .toList());
  //           ref.read(sheduleCallProvider).available.clear();
  //        ref.read(sheduleCallProvider).   available.addAll(slots.where((element) =>element.date==
  //                                           ref
  //                                               .watch(
  //                                                  sheduleCallProvider)
  //                                               .daySelected));
  //                                               print(available);
  //           load = false;
  //           notifyListeners();
  //           return;
  //         } else {
  //           load = false;
  //           return;
  //         }
  //       } on DioError catch (e) {
  //         load = false;
  //         print(e);
  //       }
  //       print(message['message']);
  //     } else {
  //       load = false;
  //       print("error");
  //     }
  //   } on DioError catch (e) {
  //     load = false;
  //     print(e);
  //   }
  // }

  cancelSlot(context, {required WidgetRef ref, required int index}) async {
    load = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    // var lang = prefs.getString('language');
    // var englishDate;
    // if (lang!.contains("it")) {
    //   var conDate = DateFormat("EEE dd MMM", 'it').parse(daySelected);
    //   englishDate = DateFormat("EEE dd MMM", 'en')
    //       .format(DateTime(DateTime.now().year, conDate.month, conDate.day))
    //       .toString();
    //   log(englishDate);
    // }
    // var englishDate = DateFormat("EEE dd MMM", 'it').parse(daySelected);

    Map<String, dynamic> data = {
      "user_id": '${BaseHelper.ids}',
      "slot_id": ref.watch(sheduleCallProvider).ssList[index]['id'],
      "date": daySelected
      // "date": ref.read(sheduleCallProvider).daySelected
    };
    final response =
        await dio.post("${AppConstants.BASE_URL_NEW}cancel", data: data);
    try {
      if (response.statusCode == 200) {
        var message = response.data;

        print(message['message']);
        ref.watch(sheduleCallProvider).getAllSlots(context, daySelected, false);
      } else {
        load = false;
        notifyListeners();
        print("error");
      }
    } on DioException catch (e) {
      load = false;
      print(e);
    }
  }

  // void initialDaySelected(
  //   WidgetRef ref,
  // ) {
  //   ref.watch(sheduleCallProvider).available.clear();
  //   ref.read(sheduleCallProvider).daySelected =
  //       DateFormat("EEE").format(DateTime.now());
  //   ref.watch(sheduleCallProvider).available.addAll(slots.where((element) {
  //     // print(element.day);
  //     return element.day.name == ref.watch(sheduleCallProvider).daySelected;
  //   }));
  // }
}
