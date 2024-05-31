
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../controller/scheduling_provider.dart';


class PaymentForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<PaymentForm> createState() => _PaymentFormState();
 // _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends ConsumerState<PaymentForm> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
       Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Center(
             child: Container(
               width: 300,
               height: 200,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: NetworkImage('https://seeklogo.com/images/J/jazz-cash-logo-829841352F-seeklogo.com.png'),
                   fit: BoxFit.contain,
                 ),
               ),
             ),
           ),
           Padding(
             padding: EdgeInsets.all(20.0),
             child: Column(
               children: <Widget>[
                 TextField(
                   controller: _cardNumberController,
                   decoration: InputDecoration(
                     labelText: 'Card Number',
                   ),
                 ),
                 SizedBox(height: 20),
                 TextField(
                   controller: _expiryDateController,
                   decoration: InputDecoration(
                     labelText: 'Expiry Date',
                   ),
                 ),
                 SizedBox(height: 20),
                 TextField(
                   controller: _cvvController,
                   decoration: InputDecoration(
                     labelText: 'CVV',
                   ),
                   obscureText: true,
                 ),
                 SizedBox(height: 40),
                 TextButton(
                     onPressed:
                   ref
                               .watch(sheduleCallProvider)
                               .adminStatus ==
                           "1"
                       ? () async {
                           if (ref.watch(micheckProvider) ==
                                   false ||
                               ref.watch(
                                       videoCamCheckProvider) ==
                                   false) {
                             if (ref.watch(
                                     micheckProvider) ==
                                 false) {
                               if (await Permission
                                   .microphone
                                   .request()
                                   .isGranted) {
                                 ref
                                     .read(micheckProvider
                                         .notifier)
                                     .state = true;
                               } else if (await Permission
                                   .microphone.isDenied) {
                                 ref
                                     .read(micheckProvider
                                         .notifier)
                                     .state = false;
                               } else {
                                 await openAppSettings();
                               }
                             }
                             if (ref.watch(
                                     videoCamCheckProvider) ==
                                 false) {
                               if (await Permission.camera
                                   .request()
                                   .isGranted) {
                                 ref
                                     .read(
                                         videoCamCheckProvider
                                             .notifier)
                                     .state = true;
                               } else if (await Permission
                                   .camera.isDenied) {
                                 ref
                                     .read(
                                         videoCamCheckProvider
                                             .notifier)
                                     .state = false;
                               } else {
                                 openAppSettings();
                               }
                             }
                           } else {
                             ref
                                 .read(sheduleCallProvider)
                                 .getCall(context, ref: ref);

                             // ref
                             //     .read(sheduleCallProvider)
                             //     .getCall(context, ref: ref);
                           }
                         }
                       : null
                     //     () async {
                     //   await ref
                     //       .read(sheduleCallProvider)
                     //       .getAllSlots(
                     //       context,
                     //       "${DateFormat(
                     //         'EEE dd MMM',
                     //       ).format(DateTime.now())}",
                     //       true);
                     //   // }
                     // }
                   // onPressed: () {
                   //   // Navigate to the next screen
                   //   Navigator.push(
                   //     context,
                   //     MaterialPageRoute(builder: (context) => NextScreen()),
                   //   );
                   // },,
                     ,
                   child: Text('Proceed'),
                 ),
               ],
             ),
           ),
         ],
       ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('This is the next screen after payment.'),
      ),
    );
  }
}
