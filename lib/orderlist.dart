import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'features/home/presention/layout/cubit/cubit.dart';
import 'features/home/presention/widgets/login/service_login_screen.dart';
import 'features/home/presention/widgets/profile/profile_screen.dart';

enum MenuAction { signOut, profile, availableOrders,lastOrders }

class OrdersList extends StatefulWidget {
  bool last=false;
  final dynamic workerCity;
  final dynamic workerJobType;

  OrdersList({required this.workerCity, required this.workerJobType,this.last=false});

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,

        title: Text(widget.last?"Last Orders":"Available Orders" ,
          style: TextStyle(

            fontFamily: 'Tajawal',
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,

          ),
        ),

        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuAction>>[
              PopupMenuItem<MenuAction>(
                value: MenuAction.signOut,
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.black38),
                    SizedBox(width: 8),
                    Text('Sign Out' ,   style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              ),
              PopupMenuItem<MenuAction>(
                value: MenuAction.profile,
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black38),
                    SizedBox(width: 8),
                    Text('Profile',   style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              ),
              PopupMenuItem<MenuAction>(
                value: MenuAction.availableOrders,
                child: Row(
                  children: [
                    Icon(Icons.list, color: Colors.black38),
                    SizedBox(width: 8),
                    Text('Available Orders',   style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              ),
              PopupMenuItem<MenuAction>(
                value: MenuAction.lastOrders,
                child: Row(
                  children: [
                    Icon(Icons.timer, color: Colors.black38),
                    SizedBox(width: 8),
                    Text('Last Orders',   style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream:widget.last==false?


        FirebaseFirestore.instance
            .collection('orders')
            .where('city', isEqualTo: widget.workerCity)
            .where('jobType', isEqualTo: widget.workerJobType)
            .where('status', isEqualTo: 'pending')
            .snapshots():   FirebaseFirestore.instance
            .collection('orders')
            .where('city', isEqualTo: widget.workerCity)
            .where('jobType', isEqualTo: widget.workerJobType)
            .where('status', isEqualTo: 'completed')
            .where('acceptedEmployeeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot order = snapshot.data!.docs[index];
              return OrderCard(order: order,last:widget.last);
            },
          );
        },
      ),
    );
  }

  Future<void> _handleMenuAction(MenuAction value) async {
    switch (value) {
      case MenuAction.signOut:
        await FirebaseAuth.instance.signOut();
        navigateTo(context, ServiceLoginScreen());
        break;
      case MenuAction.profile:
        navigateTo(context, ProfileScreen());
        break;
      case MenuAction.lastOrders:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrdersList(workerCity: widget.workerCity, workerJobType: widget.workerJobType,last: true)));
        // Navigate to orders page
        break;
      case MenuAction.availableOrders:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrdersList(workerCity: widget.workerCity, workerJobType: widget.workerJobType,last: false)));
        // Navigate to orders page
        break;
    }
  }
}

class OrderCard extends StatelessWidget {
  final DocumentSnapshot order;
  bool last;

  OrderCard({required this.order,required this.last});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = order.data() as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        color: Colors.deepOrange, // Set card color

        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderDetailsScreen(data: data)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Order :  ${data['order']}',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),




                ),

                SizedBox(height: 10,),
                Text('Start Date: ${data['start_date']}',  style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
                Text('End Date: ${data['end_date']}' ,  style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
                if (last)
                  SizedBox(
                    height: 5,
                  ),
                if (last)
                  Text("Status : You Accepted The Offer" ,  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(height: 6,),
                if (last)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price: ${data['price']}',  style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                Text('End Date: ${data['endData']}' ,  style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),

                if (last)
                  SizedBox(
                    height: 10,
                  ),
                if (last)
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        ServiceCubit.get(context).showProfile(data['clientID']);

                      },
                      child: Text("Show Client Profile" ,  style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 25,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  OrderDetailsScreen({required this.data}) {
    order = data["order"];
    sDate = data["start_date"];
    eDate = data["end_date"];
    orderId = data["orderId"];
    clientId = data["clientID"];
  }

  late String order;
  late String sDate;
  late String eDate;
  late String orderId;
  late String clientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text("order",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal' ,
                fontSize: 25 ,
                color: Colors.white ,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: TextEditingController(text: order),
                maxLines: null,
                enabled: false,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontFamily: 'Tajawal',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  prefixIcon: Icon(Icons.message , color: Colors.white,),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Text("start date",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal' ,
                fontSize: 25 ,
                color: Colors.white ,
              ) ,


            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: TextEditingController(text: sDate),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                enabled: false,
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontFamily: 'Tajawal',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  prefixIcon: Icon(Icons.date_range_rounded , color: Colors.white,),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Text("end date" ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal' ,
                fontSize: 25 ,
                color: Colors.white ,
              ),


            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: TextEditingController(text: eDate),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                enabled: false,
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontFamily: 'Tajawal',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  prefixIcon: Icon(Icons.date_range_outlined , color: Colors.white,),
                ),
              ),
            ),

            SizedBox(height: 50,) ,

            ElevatedButton(
              onPressed: () {
                navigateTo(
                  context,
                  SetOfferPage(
                    orderId: orderId,
                    clientId: clientId,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange, // Set the button color
              ),
              child: Text(
                "ارسال عرض",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}

class SetOfferPage extends StatefulWidget {
  final String orderId;
  final String clientId;

  SetOfferPage({required this.orderId, required this.clientId});

  @override
  _SetOfferPageState createState() => _SetOfferPageState();
}

class _SetOfferPageState extends State<SetOfferPage> {
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Text('Set Your Offer',
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 25 ,
          fontWeight: FontWeight.bold,
          color: Colors.deepOrange ,

        ),

      )),
      body: Column(
        children: [
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _priceController,
              style: TextStyle(
                color: Colors.deepOrange,
                fontFamily: 'Tajawal',
              ),
              decoration: InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(
                  color: Colors.deepOrange, // Optional: Change the label text color to deep orange
                  fontFamily: 'Tajawal',
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 25,),

          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _dateController,
              style: TextStyle(
                color: Colors.deepOrange,
                fontFamily: 'Tajawal',
              ),
              decoration: InputDecoration(
                labelText: 'End Date',
                labelStyle: TextStyle(
                  color: Colors.deepOrange, // Optional: Change the label text color to deep orange
                  fontFamily: 'Tajawal',
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange, // Set the button color
                ),
                child: Text('Send Offer',

                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 25 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.white ,
                  ),

                ),
                onPressed: () async {
                  await FirebaseFirestore.instance.collection("orders").doc(widget.orderId).get().then((value) {
                    if (value.data()!["status"] != "pending") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('This order is already pending')));
                      return;
                    }
                    FirebaseFirestore.instance
                        .collection("offers")
                        .add({}).then((value) async {
                      var offerId = value.id;
                      var userId = FirebaseAuth.instance.currentUser!.uid;
                      var currentUser=await FirebaseFirestore.instance.collection("profiles").doc(userId).get();
                      var name=currentUser.data()!["name"];
                      return await FirebaseFirestore.instance
                          .collection("offers")
                          .doc(value.id)
                          .set({
                        'offerId': value.id,
                        "price": _priceController.text,
                        "endData": _dateController.text,
                        "orderId": widget.orderId,
                        "name":name,
                        "image":currentUser.data()!["image"],
                        "employeeId": userId
                      }).then((value) async {
                        var client=await FirebaseFirestore.instance.collection("profiles").doc(widget.clientId).get();
                        List fcms=client.data()!["fcm"];
                        for (var i in fcms) {
                          const String fcmAPI =
                              'https://fcm.googleapis.com/fcm/send';
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
                                  "body": "${name}تم استقبال عرض لطلبك من ",
                                  "mutable_content": true,
                                },
                                "data": {
                                  "id":  widget.orderId,
                                  "key":"offerEvent",
                                  'click_action': 'FLUTTER_NOTIFICATION_CLICK'
                                }
                              },
                              options: options)
                              .then((value) {});
                        }
                        Navigator.pop(context);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Offer sent successfully')));

                      });
                    });
                  });

                }),
          ),
        ],
      ),
    );
  }
}
//   Future<void> _sendOffer() async {
//     final offerData = {
//       'price': _priceController.text,
//       'endDate': _dateController.text,
//       'workerId': _fcm.getToken(), // Assuming this gets the worker's FCM token or use FirebaseAuth to get user ID
//     };
//
//     // Save offer in Firestore under the specific order
//     await _db.collection('orders').doc(widget.orderId).collection('offers').add(offerData);
//
//     // Retrieve the user's FCM token to send notification
//     final userProfile = await _db.collection('profiles').doc(widget.userId).get();
//     final userFcmToken = userProfile.data()!['fcmToken'];
//
//     // Send FCM notification to the user
//     await _sendFcmMessage(userFcmToken, "New Offer", "You have received a new offer!");
//
//     Navigator.pop(context); // Optionally pop back to previous screen
//   }
//
//   Future<void> _sendFcmMessage(String to, String title, String body) async {
//     // Logic to send FCM message
//   }
// }
