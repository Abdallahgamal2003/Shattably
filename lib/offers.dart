import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/presention/layout/cubit/cubit.dart';
import 'features/home/presention/layout/cubit/states.dart';

class OffersScreen extends StatefulWidget {
  dynamic orderId;
   OffersScreen({Key? key, this.orderId}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServiceCubit.get(context).getOffers(orderId: widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
      listener:(context, state) {},
      builder: (context, state) {
        if (state is ServiceGetOffersErrorState) {
          return Scaffold(
            body: Center(
              child: Text('Error' + state.error),
            ),
          );
        }
        if (state is ServiceAcceptOfferErrorState) {
          return Scaffold(
            body: Center(
              child: Text('Error' + state.error),
            ),
          );
        }

        if (state is ServiceGetOffersLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );

        }
        if (state is ServiceAcceptOfferLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );

        }
        List offers = ServiceCubit.get(context).offers;
        return Scaffold (
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Offers',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              fontSize: 25 ,
              color: Colors.deepOrange ,

            ),
            ),
          ),
          body: ListView.builder(
            itemCount: offers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Card(
                  color: Colors.deepOrange, // Set the card color to deep orange
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar( // Make the image circular
                              backgroundImage: NetworkImage(
                                offers[index]['image'] != null && offers[index]['image'] != "null"
                                    ? offers[index]['image']
                                    : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                              ),
                              radius: 25, // Set the radius for the circle avatar
                            ),
                            SizedBox(width: 10),
                            Text(
                              offers[index]['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Tajawal',
                                color: Colors.white, // Set text color to white
                              ),
                            ),
                            SizedBox(width: 5,), 
                            Icon(Icons.verified , color: Colors.white, size: 17, )
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "Price: " + offers[index]['price'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                  color: Colors.white, // Set text color to white
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "End date: " + offers[index]['endData'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                  color: Colors.white, // Set text color to white
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green, // Set button color to green
                              ),
                              onPressed: () {
                                ServiceCubit.get(context).acceptOffer(
                                  orderId: widget.orderId,
                                  offerId: offers[index]['offerId'],
                                );
                              },
                              child: Text(
                                'Accept',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                  color: Colors.white, // Set text color to white
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Set button color to white
                              ),
                              onPressed: () {
                                ServiceCubit.get(context).showProfile(offers[index]['employeeId']);
                              },
                              child: Text(
                                'Show Profile',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                  color: Colors.deepOrange, // Set text color to deep orange
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
