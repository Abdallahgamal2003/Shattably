//APIKEY = AIzaSyAIWlZTXnbbcpRon7-KzW4ev29y-Hdr43Q

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/pop_up_view/pup_up_screen.dart';

import '../../../../../../../packages/syncfusion_flutter_datepicker-23.2.4/lib/datepicker.dart';
import '../../../../../../../packages/syncfusion_flutter_datepicker-23.2.4/lib/src/date_picker/date_picker.dart';
import '../cards_view/card_home_screen.dart';


class form extends StatefulWidget {

  form(this.job);
  String job ;
  @override
  State<form> createState() => _formState();
  final String order="";
}

class _formState extends State<form> {
  String? deliveryDate;
  String? rentingPeriod;
  DateTime? deliverySelectedDate = DateTime.now();
  DateTime? rentingPeriodSelectedDate;
var cityController=TextEditingController();
var orderController=TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButtonHomeScreen(context),
        iconTheme: IconThemeData(

          color: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'orders',
          style: TextStyle(
            color: Colors.deepOrange,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            fontSize: 25 ,
          ),
        ),
      ),
      body:
      SingleChildScrollView(
        child: Column
          (children: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              controller: orderController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontFamily: 'Tajawal', // Set text style to Tajawal font
                color: Colors.white, // Set text color to white
              ),
              decoration: InputDecoration(
                labelText: "اكتب طلبك",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Set border color to deepOrange
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Set border color to white when enabled (not focused)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2), // Set border color to deepOrange when focused
                ),
                prefixIcon: Icon(Icons.message , color: Colors.white,),
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal', // Set label text style to Tajawal font
                  color: Colors.deepOrange, // Set label text color to deepOrange
                ),
                // Optional: You can customize other properties of InputDecoration here
              ),
            ),
          ),

          SizedBox(height: 15,) ,


          Padding(
            padding: const EdgeInsets.all(17),
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedDate: DateTime.now(),
              rangeSelectionColor: Colors.deepOrange,
              rangeTextStyle: const TextStyle(color: Colors.white),

              toggleDaySelection: true,
              todayHighlightColor: Colors.white,
              endRangeSelectionColor: Colors.grey,
              startRangeSelectionColor: Colors.deepOrange,
              selectionColor: Colors.white,

              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: TextStyle(color: Colors.white), // Set text color to white for date numbers
              ),

              // Customize the header style to set the color of day headers to white
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: TextStyle(color: Colors.white), // Set text color to white for day headers
              ),


              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  deliverySelectedDate = args.value.startDate;
                  rentingPeriodSelectedDate = args.value.endDate;
                  deliveryDate = args.value.startDate.toString().substring(0, 11);
                  rentingPeriod = args.value.endDate.toString().substring(0, 11);

                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              controller: TextEditingController(text: deliveryDate),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontFamily: 'Tajawal', // Set text style to Tajawal font
                color: Colors.white, // Set text color to white
              ),
              decoration: InputDecoration(
                labelText: "بدايه المده",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Set border color to deepOrange
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Set border color to white when enabled (not focused)
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2), // Set border color to deepOrange when focused
                ),
                prefixIcon: Icon(Icons.message , color: Colors.white,),
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal', // Set label text style to Tajawal font
                  color: Colors.deepOrange, // Set label text color to deepOrange
                ),
                // Optional: You can customize other properties of InputDecoration here
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17 , right: 17),
            child: TextField(
              controller: TextEditingController(text: rentingPeriod),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontFamily: 'Tajawal', // Set text style to Tajawal font
                color: Colors.white, // Set text color to white
              ),
              decoration: InputDecoration(
                labelText: "نهايه المده",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Set border color to deepOrange
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Set border color to white when enabled (not focused)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2), // Set border color to deepOrange when focused
                ),
                prefixIcon: Icon(Icons.message , color: Colors.white,),
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal', // Set label text style to Tajawal font
                  color: Colors.deepOrange, // Set label text color to deepOrange
                ),
                // Optional: You can customize other properties of InputDecoration here
              ),

            ),
          ),
          AppTextField(
          textEditingController: cityController,
          title: "",
          hintTextStyle: TextStyle(color: Colors.deepOrange , fontFamily: 'Tajawal' , fontSize: 25),
          titleTextStyle: TextStyle(color: Colors.deepOrange , fontFamily: 'Tajawal' , fontSize: 25),
          hint: "city",
          isCitySelected: true,
          DataList: [
            SelectedListItem(name: "القاهرة"),
            SelectedListItem(name: "الجيزة"),
            SelectedListItem(name: "الاسكندرية"),
            SelectedListItem(name: "اسيوط"),
            SelectedListItem(name: "دمياط"),
            SelectedListItem(name: "الجميع")
          ],
        ),ElevatedButton(

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange), // Set background color
                // You can add more styling options here if needed
              ),
              onPressed: () async {

          String orderId="";
            await FirebaseFirestore.instance.collection("orders")
                .add({}).then((value) async {
              orderId=value.id;
              var userId= FirebaseAuth.instance.currentUser!.uid;
              return await FirebaseFirestore.instance.collection("orders").doc(value.id).set({
                'orderId': value.id,
                "order":orderController.text,
                "start_date": deliveryDate.toString(),
                "end_date":rentingPeriod.toString(),
                "jobType":job,
                "city":cityController.text,
                "clientID":userId,
                "status":"pending",
              }).then((value) async {
                FirebaseFirestore firestore = FirebaseFirestore.instance;

                // Query the "users" collection to get users above a certain age (e.g., 18)

                QuerySnapshot querySnapshot = await firestore
                    .collection('profiles')
                    .where('city', isEqualTo: cityController.text)
                    .where('job', isEqualTo: widget.job)
                    .get();
                QuerySnapshot querySnapshot2 = await firestore
                    .collection('profiles')
                    .where('job', isEqualTo: widget.job)
                    .get();
                String name = await firestore
                    .collection('profiles')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get().then((value) {
                  return value ['name'];
                });

                if(cityController.text=='الجميع') {
                  for (QueryDocumentSnapshot documentSnapshot in querySnapshot2.docs) {
                    print('User ID: ${documentSnapshot.id}');
                    List fcms = documentSnapshot['fcm'] ?? [];
                    for (var i in fcms) {
                      const String fcmAPI = 'https://fcm.googleapis.com/fcm/send';
                      final Dio dio = Dio();
                      Options options = Options(
                          followRedirects: false,
                          validateStatus: (status) => true,
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization':
                            'key=AAAA5yTPL-g:APA91bF7co5xPVOQ41P3Qpu4BBi0eueSYbeeJJYgmMo2OOP-m3L6aitb_xAhE89sRsp3SeVtqpG0W6rivce0KJ7-MXDM6ocCgM2HpRqoEWjbs1kJmLIvrZAaHJCxkMd2WwCzGRs-vyFd'
                          });
                      dio
                          .post(fcmAPI,
                          data: {
                            "to": i,
                            "notification": {
                              "title": 'shattably',
                              "body": "${name}تم استقبال طلب من ",
                              "mutable_content": true,
                            },
                            "data": {
                              "id": orderId,
                              'click_action' : 'FLUTTER_NOTIFICATION_CLICK',
                              "key":"orderEvent"
                            }
                          },
                          options: options)
                          .then((value) {});
                    }
                  }
                }
                else
                {
                  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
                    print('User ID: ${documentSnapshot.id}');
                    List fcms = documentSnapshot['fcm'] ?? [];
                    for (var i in fcms) {
                      const String fcmAPI = 'https://fcm.googleapis.com/fcm/send';
                      final Dio dio = Dio();
                      Options options = Options(
                          followRedirects: false,
                          validateStatus: (status) => true,
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization':
                            'key=AAAA5yTPL-g:APA91bF7co5xPVOQ41P3Qpu4BBi0eueSYbeeJJYgmMo2OOP-m3L6aitb_xAhE89sRsp3SeVtqpG0W6rivce0KJ7-MXDM6ocCgM2HpRqoEWjbs1kJmLIvrZAaHJCxkMd2WwCzGRs-vyFd'
                          });
                      dio
                          .post(fcmAPI,
                          data: {
                            "to": i,
                            "notification": {
                              "title": 'shattably',
                              "body": "${name}تم استقبال طلب من ",
                              "mutable_content": true,
                            },
                            "data": {
                              "id": orderId,
                              'click_action' : 'FLUTTER_NOTIFICATION_CLICK',
                              "key":"orderEvent"
                            }
                          },
                          options: options)
                          .then((value) {});
                    }
                  }
                }

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('تم ارسال الطلب بنجاح'),
                  duration: Duration(seconds: 3),
                ));

                return true;
              }).catchError((error) {
                print("Failed to add user: $error");
                return false;
              });
            });

        }, child: Text("send request" , style: TextStyle(color: Colors.white , fontFamily: 'Tajawal' , fontSize: 20),))],),
      )
    );
  }
}

