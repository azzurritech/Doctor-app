
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
 // Import the path package
import 'dart:io';


int counters = 0;

class ChatScreen extends StatefulWidget {

  ChatScreen({
    Key? key,

  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController textz;
  String? room;
  String? url;

  bool _isTyping = false;
  File? file;
  String? downloadurl;

  String? seen;
  String? imagepath;
  String? selectedoptions;
  String? token;
  String? tokens;
  List<String> videourls = [];
  String? save;
  bool isshowingshare = false;
  var data;
  @override
  void initState() {
    textz = TextEditingController();


    // getUuid(widget.selecteduser);

    super.initState();
  }


  // updatevalue() async {
  //   return await FirebaseFirestore.instance
  //       .collection("talha")
  //       .doc(BaseHelper.auth.currentUser?.email)
  //       .collection("recentchat")
  //       .doc(widget.selecteduser)
  //       .withConverter(
  //           fromFirestore: RecentChatModel.fromFirestore,
  //           toFirestore: (RecentChatModel value, options) =>
  //               value.toFireStore())
  //       .get()
  //       .then((value) {
  //     counters = value.data()?.counter?.toInt() ?? 0;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 24,
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                // backgroundImage: NetworkImage(url ?? ""),
              ),
              Spacer(),
              Expanded(
                flex: 2, // Adjust the flex value as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        // Your onTap logic here
                      },
                      child: Text(
                       'Chat',style: TextStyle(color: Colors.black),
                        // style: notification_style,
                      ),
                    ),
                    SizedBox(height: 4), // Add spacing
                    Row(
                      children: [
                        Container(
                          height: 30,
                          // child: StreamBuilder(
                          //     // stream: FirebaseFirestore.instance
                          //     //     .collection("talha")
                          //     //     .doc(widget.selecteduser)
                          //     //     .withConverter(
                          //     //     fromFirestore: UserModel.fromFirestore,
                          //     //     toFirestore: (UserModel value, options) =>
                          //     //         value.toFireStore())
                          //     //     .snapshots(),
                          //     // builder: ((context, snapshot) {
                          //     //   if (snapshot.hasData) {
                          //     //     var datas = snapshot.data?.data()?.status;
                          //     //     return Text(
                          //     //       datas.toString(),
                          //     //       style: TextStyle(color: Colors.black),
                          //     //     );
                          //     //   } else {
                          //     //     return Text('');
                          //     //   }
                          //
                          //       return CircularProgressIndicator();
                          //     })),
                        ),
                      SizedBox(
                          width: 33,
                        ),
                        // Container(
                        //   height: 30,
                        //   child: StreamBuilder(
                        //       stream: FirebaseFirestore.instance
                        //           .collection("talha")
                        //           .doc(BaseHelper.currentuser?.email)
                        //           .collection('recentchat')
                        //           .doc(widget.selecteduser)
                        //           .withConverter(
                        //           fromFirestore: UserModel.fromFirestore,
                        //           toFirestore: (UserModel value, options) =>
                        //               value.toFireStore())
                        //           .snapshots(),
                        //       builder: ((context, snapshot) {
                        //         if (snapshot.hasData) {
                        //           final datas = snapshot.data;
                        //           var asd = datas?["typing"];
                        //           return Text(
                        //             asd == 'Typing' ? "Typing" : '',
                        //             style: const TextStyle(
                        //                 color: Colors.black, fontSize: 17),
                        //           );
                        //         } else
                        //           return CircularProgressIndicator();
                        //       })),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  // IconButton(
                  //   onPressed: () async {
                  //     // await getUuid(widget.selecteduser);
                  //     String token = await FirebaseMethod.getusertoken(
                  //         widget.selecteduser);
                  //     await Notificationss.sendCallNotification(
                  //         token,
                  //         BaseHelper.currentuser?.email,
                  //         BaseHelper.currentuser?.uuid);
                  //     // Your IconButton logic here
                  //   },
                  //   icon: Icon(
                  //     Icons.call,
                  //     color: Colors.pink,
                  //   ),
                  // ),
                  // IconButton(
                  //   onPressed: () async {
                  //     // await getUuid(widget.selecteduser);
                  //     // String token = await FirebaseMethod.getusertoken(
                  //     //     widget.selecteduser);
                  //     // await Notificationss.sendVideoCallNotification(
                  //     //     token,
                  //     //     BaseHelper.currentuser?.email,
                  //     //     BaseHelper.currentuser?.uuid);
                  //     // Your IconButton logic here
                  //   },
                  //   icon: const Icon(
                  //     Icons.video_call,
                  //     color: Colors.pink,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
        leading:IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back, color: Colors.black,))
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 19),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
            Expanded(
            flex: 12,
            child: Container(
              child: ListView.builder(
                reverse: true,
                itemCount: 33,
                itemBuilder: ((context, index) {
                  // ChatModel chatModel = data[index];

                  return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ChatScreenWidget(
                          //     chatModel: chatModel,
                          //     markers: markers,
                          //     seen: seen,
                          //     context: context,
                          //     isShowing: isshowingshare)
                          // // buildChatWidget(chatModel, _markers, seen ?? "",
                          // //     context, isshowingshare),

                          // Text(
                              // DateFormat('h:mm a')
                              // .format(chatModel.dateTime!)),
                        ]

                      ));
                }),
              ),
            ),
          ),
              Spacer(),

              // Container(
              //   height: 300,
              //   child: LinkPreview(
              //       onPreviewDataFetched: ((p0) {
              //         setState(() {
              //           data = p0;
              //         });
              //       }),
              //       previewData: data,
              //       text: 'https://youtu.be/GyErJTMPXCA?si=yOTvDTtHldERdtuE',
              //       width: width),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width * 0.7,
                    child: TextField(
                      // onChanged: (newText) => _onTextChanged(newText),
                      controller: textz,
                      decoration: InputDecoration(
                          suffixIcon: Container(
                            child: IconButton(
                                onPressed: () {
                                  showmodelbottomsheet(context);
                                },
                                icon: Icon(Icons.attachment)),
                          ),
                          // prefixIcon: Consumer(
                          //   builder: (context, WidgetRef ref, Widget? child) {
                          //     final read = ref.watch(listenemoji);
                          //     return IconButton(
                          //         onPressed: () {
                          //           read == true
                          //               ? ref
                          //               .read(listenemoji.notifier)
                          //               .showemoji(false)
                          //               : ref
                          //               .read(listenemoji.notifier)
                          //               .showemoji(true);
                          //           print(read);
                          //         },
                          //         icon: Image.asset(ImagePath.emojicon));
                          //   },
                          // ),
                          hintText: "Write Something",
                          border: InputBorder.none,
                          filled: true,
                          // fillColor: AppColors.chattextfieldcolor
                        ),
                    ),
                  ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color:Colors.grey,
                shape: BoxShape.circle),
            child: Center(
                child: IconButton(
                  onPressed: (() async {
                    final texts = textz.text.toString();
                    if (texts.isNotEmpty) {
                      // updatevalue();

                      textz.clear();


                      // updatevalue();
                    } else {}
                  }),
                  icon: Icon(Icons.send),
                )),
          )
                ],
              ),


              // EmojiPicker()
            ],
          ),
        ),
      ),
    );
  }

  showmodelbottomsheet(context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
        builder: (context) {
          return Container(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: (() async {
                                final image = ImagePicker();
                                final pickedimage = await image.pickImage(
                                    source: ImageSource.gallery);
                                if (pickedimage != null) {
                                  Navigator.pop(context);
                                  file = File(pickedimage.path);
                                  imagepath = file?.path;


                                } else {
                                  print("error");
                                }
                              }),
                              icon: Icon(Icons.camera)),
                          Text("Pick Image"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {


                              // lat: latt ?? 330, long: longg ?? 44
                            },
                            icon: const Icon(Icons.location_on),
                          ),
                          Text("Location"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: (() async {
                                final image = ImagePicker();
                                final pickedimage = await image.pickVideo(
                                    source: ImageSource.gallery);



                              }),
                              icon: const Icon(Icons.video_camera_front)),
                          const Text("Video")
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                            onPressed: () async {
                              FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: [
                                  'pdf',
                                  'doc',
                                  'docx',
                                  'txt',
                                ],
                              );

                              if (result != null) {
                                file =
                                    File(result.files.single.path.toString());
                                String selectedFileName =
                                    result.files.single.name;
                                print(selectedFileName);




                              } else {
                                // User canceled the picker
                              }
                            },
                            icon: const Icon(Icons.file_copy_sharp)),
                        const Text("Pick File"),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: (() async {
                              final image = ImagePicker();
                              final pickedimage = await image.pickImage(
                                  source: ImageSource.camera);
                              if (pickedimage != null) {
                                Navigator.pop(context);
                                file = File(pickedimage.path);
                                imagepath = file?.path;


                              } else {

                                  print("error");

                              }
                            }),
                            icon: Icon(Icons.camera)),
                        Text("Pick Camera"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
