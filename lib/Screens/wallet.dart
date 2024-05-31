import 'package:flutter/material.dart';

import 'package:flutter_credit_card/flutter_credit_card.dart';
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  void onpress() {}

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CommonAppBar(
      //   centertitle: false,
      //   title: 'Wallet',
      //   leading: CommonIconButton(
      //     iconData: Icons.chevron_left,
      //     color: AppColors.blackButtoncolor,
      //     isButton: true,
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      //   actions: [
      //     Image.asset(
      //       AppAssets.appsecondarylogo,
      //       fit: BoxFit.contain,
      //     ).marginAll(12)
      //   ],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreditCardWidget(
                cardNumber: "1234 123412341234",
                expiryDate: "11/25",
                cardHolderName: "Asad",
                cvvCode: "789",
                showBackView: false,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Colors.blueAccent,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange:
                    (CreditCardBrand creditCardBrand) {},
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Top Up Amount',
                              style: TextStyle(color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 8.0),
                            child: TextField(
                            ),
                          )
                          ,
                          Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 8.0, vertical: 22),
                            child: Text(
                              '*This amount will be deducted from your card connected*',
                              style: TextStyle(color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // height: 50,
                      padding: const EdgeInsets.all(18),
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,),

                          )),
                    ),
                  ),
                ],
              ),
              const Text(
                'Your Recent Credits',
                style: TextStyle(color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,),

              ),
              Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                      const Divider(
                        color: Colors.grey,
                        height: 1,
                        endIndent: 20,
                        indent: 20,
                      ),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.lightGreen,
                              child: IconButton(onPressed: onpress, icon: Icon(
                                  Icons.wallet))

                          ),
                          title: RichText(
                            text: const TextSpan(
                                text: 'You have been credit ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '\u0024 100',
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600),
                                  )
                                ]),
                          ),
                          subtitle: Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Dated: ',
                                  style: TextStyle(color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,),

                                ), Text(
                                  '2022-20-10 ',
                                  style: TextStyle(color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,),

                                ),
                              ]),
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}