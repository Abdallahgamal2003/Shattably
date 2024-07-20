import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/features/home/presention/widgets/orders/order_service_item.dart';
import 'package:shattably/offers.dart';

import '../../../../../components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../Rate/ratePage.dart';


class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServiceCubit.get(context).getOrders();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
      listener:(context, state) {},
      builder: (context, state) {
        if (state is ServiceGetOrdersErrorState) {
          return Scaffold(
            body: Center(
              child: Text('Error' + state.error),
            ),
          );
        }
        if (state is ServiceGetOrdersLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        List allOrders = ServiceCubit.get(context).myOrders;
        List pendingOrders = allOrders.where((order) => order.data()['status'] == 'pending').toList();
        List completedOrders = allOrders.where((order) => order.data()['status'] == 'completed').toList();

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const TabBar(
                indicatorColor: Colors.deepOrange, // Set custom indicator color here

                tabs: [

                  Tab( child: Text('pinding orders ', style: TextStyle(
                    fontSize: 20 ,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal' ,

                  ),),


                  ),
                  Tab(child: Text('completed orders ', style: TextStyle(
                    fontSize: 18 ,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal' ,

                  ),),),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                buildPOrderList(pendingOrders),
                buildCOrderList(completedOrders),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget buildPOrderList(List orders) {
    if (orders.isEmpty) {
      return Center(
        child: Text('No orders found' ,
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 32,

          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderItem(
          order: orders[index].data(),
        );
      },
    );
  }
  Widget buildCOrderList(List orders) {
    if (orders.isEmpty) {
      return Center(
        child: Text('No orders found'),
      );
    }
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return CompletedOrderItem(
          order: orders[index].data(),
        );
      },
    );
  }

}

class OrderItem extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OffersScreen(orderId: order['orderId'])
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Start Date: ${order['start_date']}'),
                  Text('End Date: ${order['end_date']}'),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Job Type: ${order['jobType']}'),
                  Text('City: ${order['city']}'),

                ],
              ),
              Center(child: Text('Order: ${order['order']}')),
            ],
          ),
        ),
      ),
    );
  }
}
class CompletedOrderItem extends StatelessWidget {
  final Map<String, dynamic> order;
  const CompletedOrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ServiceCubit.get(context).showProfile(order["acceptedEmployeeId"]);
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        order['image'] != null && order['image'] != "null"
                            ? order['image']
                            : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                      ),
                    ),

                    SizedBox(width: 10,),
                    Text(order['name'],
                      style: TextStyle(
                        fontSize: 25 ,
                        fontWeight: FontWeight.bold ,
                        fontFamily: 'Tajawal',
                        color: Colors.deepOrange ,
                      ),
                    ),

                    SizedBox(width: 5,),
                    Icon(Icons.verified, color: Colors.grey, size: 19,)
                  ],
                ),

                SizedBox(height: 30,) ,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Start Date: ${order['start_date']}',
                      style: TextStyle(
                        fontSize: 18 ,
                        fontWeight: FontWeight.bold ,
                        fontFamily: 'Tajawal',
                        color: Colors.deepOrange ,

                      ),
                    ),

                  ],
                ),
                SizedBox(height: 6,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text('End Date: ${order['end_date']}',
                      style: TextStyle(
                        fontSize: 18 ,
                        fontWeight: FontWeight.bold ,
                        fontFamily: 'Tajawal',
                        color: Colors.deepOrange ,

                      ),),
                  ],
                ),
                SizedBox(height: 6,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Job Type: ${order['jobType']}',
                  style: TextStyle(
                  fontSize: 18 ,
                  fontWeight: FontWeight.bold ,
                fontFamily: 'Tajawal',
                  color: Colors.deepOrange ,

                ),),

                  ],
                ),
                SizedBox(height: 6,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text('City: ${order['city']}' ,
                      style: TextStyle(
                        fontSize: 18 ,
                        fontWeight: FontWeight.bold ,
                        fontFamily: 'Tajawal',
                        color: Colors.deepOrange ,

                      ),),
                  ],
                ),
                SizedBox(height: 6,) ,
                Center(child: Text(' ${order['order']}',
    style: TextStyle(
    fontSize: 25 ,
    fontWeight: FontWeight.bold ,
    fontFamily: 'Tajawal',
    color: Colors.black87 ,

    ),  ), ),
                SizedBox(height: 10,),
                Text("Accepted Offer:" ,
                style: TextStyle(
                  fontSize: 18 ,
                  fontWeight: FontWeight.bold ,
                  fontFamily: 'Tajawal',
                  color: Colors.grey ,

                )
                ),
                SizedBox(height: 10,),

                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price   : "+order['price'],
                        style: TextStyle(
                          fontSize: 18 ,
                          fontWeight: FontWeight.bold ,
                          fontFamily: 'Tajawal',
                          color: Colors.deepOrange ,

                        )),

                  ],
                ),
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text("End date: "+order['endData'],
                        style: TextStyle(
                          fontSize: 18 ,
                          fontWeight: FontWeight.bold ,
                          fontFamily: 'Tajawal',
                          color: Colors.deepOrange ,

                        )),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('rate the worker here  ',
                      style: TextStyle(
                        fontFamily: 'Tajawal', // Font family
                        fontWeight: FontWeight.w900,
                        fontSize: 15, // Font size
                        color: Colors.grey,

                      ),),
                  ],
                ),
                Row(
                  children:
                  [
                     Center(
                       child: ElevatedButton(
                          onPressed: () {
                            navigateTo(context, ratePage());




                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange, // Background color
                            onPrimary: Colors.white, // Text color
                            textStyle: TextStyle(
                              fontFamily: 'Tajawal', // Font family
                              fontWeight: FontWeight.bold,
                              // Font weight
                              fontSize: 20.0, // Font size
                            ),
                          ),
                          child: Text('Rate'),
                        ),
                     ),
                    
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

