import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
import 'package:shattably/features/home/presention/layout/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/profile/edit_profile_screen.dart';
import'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var addressController=TextEditingController();

  var cityController=TextEditingController();

  var jobController=TextEditingController();

  var whatsappController=TextEditingController();

   //var locationlink=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServiceCubit.get(context).getUserData();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
      listener:(context, state) {},
      builder: (context, state) {
        if (state is ServiceGetUserErrorState) {
          return Scaffold(
            backgroundColor: Colors.deepOrange, // Setting background color to grey

            body: Center(
              child: Text('Error' + state.error),
            ),
          );
        }
        if (state is! ServiceGetUserSuccessState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        var userModel = ServiceCubit.get(context).userModel;
        var profileImage = ServiceCubit.get(context).profileImage;

        nameController.text = userModel!.name;
        phoneController.text = userModel!.phone;
        emailController.text = userModel!.email;
        addressController.text=userModel!.address;
        cityController.text=userModel!.city;
        jobController.text=userModel!.job;
        whatsappController.text=userModel!.whatsapp;
         //locationlink.text=userModel!.locationlink;

        return Scaffold(
          backgroundColor: Colors.white24, // Setting background color to grey
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children:[
                            SizedBox(height: 200,),
                            CircleAvatar(
                              radius: 71.0,
                              backgroundImage: profileImage == null ?NetworkImage(
                                '${userModel.image}',
                              ): FileImage(profileImage) as ImageProvider,
                              backgroundColor: Colors.white,
                            ),
                            IconButton(
                              icon:CircleAvatar(

                                backgroundColor: Colors.deepOrange,

                                radius: 14.0,
                                child: Icon(
                                  Icons.edit,
                                  size: 16.0,
                                ),
                              ),
                              onPressed: ()
                              {
                                navigateTo(
                                  context,
                                  EditProfileScreen(),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          '${nameController.text}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Column(
                    children: [
                      itemProfile('Name', nameController.text, Icons.person),
                      const SizedBox(height: 15),
                      itemProfile('Phone', phoneController.text, Icons.phone),
                      const SizedBox(height: 15),
                      itemProfile('Address', addressController.text, Icons.home),
                      const SizedBox(height: 15),
                      itemProfile('city', cityController.text, Icons.location_city),
                      const SizedBox(height: 15),
                      itemProfile('job', jobController.text, Icons.engineering),
                      const SizedBox(height: 15),
                      itemProfile('whatsapp', whatsappController.text, Icons.messenger_outlined),
                      const SizedBox(height: 15),
                      // itemProfile('locationlink', locationlink.text, Icons.location_city_outlined),
                      // const SizedBox(height: 20,),

                      // defaultFormField(
                      //   controller: nameController,
                      //   type: TextInputType.name,
                      //   validate: (value){
                      //     if(value!.isEmpty)
                      //     {
                      //       return ('name must be not empty');
                      //
                      //     }
                      //     return null;
                      //   },
                      //   label: '${AppLocalizations.of(context)!.nameProfile}',
                      //   prefix: Icons.person,
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // defaultFormField(
                      //   controller: emailController,
                      //   type: TextInputType.emailAddress,
                      //   validate: (value){
                      //     if(value!.isEmpty)
                      //     {
                      //       return('email must be not empty');
                      //     }
                      //     return null;
                      //   },
                      //   label: '${AppLocalizations.of(context)!.emilProfile}',
                      //   prefix: Icons.email,
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // defaultFormField(
                      //   controller: phoneController,
                      //   type: TextInputType.phone,
                      //   validate: (String? value){
                      //     if(value!.isEmpty)
                      //     {
                      //       return('phone must be not empty');
                      //     }
                      //     return null;
                      //   },
                      //   label: '${AppLocalizations.of(context)!.phoneProfile}',
                      //   prefix: Icons.phone,
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // defaultFormField(
                      //   controller: addressController,
                      //   type: TextInputType.emailAddress,
                      //   validate: (value){
                      //     if(value!.isEmpty)
                      //     {
                      //       return('برجاء ادخال العنوان');
                      //     }
                      //     return null;
                      //   },
                      //   label: 'العنوان',
                      //   prefix: Icons.home,
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // defaultFormField(
                      //   controller: emailController,
                      //   type: TextInputType.emailAddress,
                      //   validate: (value){
                      //     if(value!.isEmpty)
                      //     {
                      //       return('برجاء ادخال العنوان');
                      //     }
                      //     return null;
                      //   },
                      //   label: 'المحافظة',
                      //   prefix: Icons.email,
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // defaultFormField(
                      //   controller: emailController,
                      //   type: TextInputType.emailAddress,
                      //   validate: (value){
                      //     if(value!.isEmpty)
                      //     {
                      //       return('email must be not empty');
                      //     }
                      //     return null;
                      //   },
                      //   label: 'الوظيفة',
                      //   prefix: Icons.email,
                      // ),

                      SizedBox(
                        height: 20.0,
                      ),
                      /*Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                FlutterPhoneDirectCaller.callNumber(phoneController.text);
                              },
                              icon: Icon(Icons.call)),
                          // IconButton(
                          //   onPressed: () {
                          //     launch("https://wa.me/${whatsappController}");
                          //   },
                          //   icon: Icon(Icons.messenger_outlined),
                          // ),
                          // IconButton(
                          //     onPressed: () {
                          //       launch(
                          //           locationlink.text);
                          //     },
                          //     icon: Icon(Icons.location_on_outlined)),

                        ],
                      ),*/
                      defaultButton(
                        text: '${AppLocalizations.of(context)!.editProfile}',
                        function: (){
                          navigateTo(context, EditProfileScreen());
                        },
                      ),



                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
Widget itemProfile(String title, String subtitle, IconData iconData) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.deepOrange,
      borderRadius: BorderRadius.circular(50),
    ),
    clipBehavior: Clip.antiAlias, // This will ensure the border radius applies to its child
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Tajawal',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Tajawal',
        ),
      ),
      leading: Icon(
        iconData,
        color: Colors.white, // Ensuring icon color matches the design
      ),
      trailing: Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      tileColor: Colors.transparent, // Make sure the tile color is transparent
    ),
  );
}


/*
itemProfile(String title, String subtitle, IconData iconData) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(50),
        /*boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              color: Colors.deepOrange.withOpacity(.2),
              spreadRadius: 5,
          )
        ]*/
    ),
    child: ListTile(
      title: Text(title
      ,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Tajawal',
        ),
      ),
      iconColor: Colors.white,
      subtitle: Text(subtitle,style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Tajawal',
      ),),
      leading: Icon(iconData),

      trailing: Icon(Icons.arrow_forward, color: Colors.white),
      tileColor: Colors.white,
    ),
  );
}*/
// Image link = https://cdn-icons-png.flaticon.com/512/3135/3135715.png