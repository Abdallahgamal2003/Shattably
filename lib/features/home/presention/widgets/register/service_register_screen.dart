import 'dart:io';
import 'package:path/path.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shattably/components/CustomButtonAuth.dart';
import 'package:shattably/components/CustomLogoAuth.dart';
import 'package:shattably/components/CustomTextForm.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/layout/service_layout_screen.dart';
import 'package:shattably/features/home/presention/widgets/login/service_login_screen.dart';
import 'package:shattably/features/home/presention/widgets/register/cubit/cubit.dart';
import 'package:shattably/features/home/presention/widgets/register/cubit/states.dart';
import 'package:shattably/home.dart';

class ServiceRegisterScreen extends StatefulWidget {
  const ServiceRegisterScreen({super.key});

  State<ServiceRegisterScreen> createState() => _ServiceRegisterScreenState();
}

class _ServiceRegisterScreenState extends State<ServiceRegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var jobController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var whatsappController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
   //var locationlink = TextEditingController();
  File? file;
  String? url;

  getImage() async {

    final ImagePicker picker = ImagePicker();
    //final XFile? image=await picker.pickImage(source: ImageSource.gallery);
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      var storage = FirebaseStorage.instance;
      var storageRef = storage.ref();
      var imagesRef = storageRef.child('${basename(photo!.path)}');
      var selectedImage = File(photo.path);
      var uploadTask = imagesRef.putFile(selectedImage);
      await (await uploadTask).ref.getDownloadURL().then((value) {
        setState(() {
          url = value;
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceRegisterCubit(),
      child: BlocConsumer<ServiceRegisterCubit, ServiceRegisterStates>(
        listener: (context, state) async {
          if (state is ServiceRegisterErrorState) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'حدث خطأ',
              desc: 'الايميل مستخدم بالفعل او كلمة المرور ضعيفة',
            )..show();
            return;
            // late String e;
            // e= ServiceCreateUserErrorState(e.code).error;
            //   try {
            //     // final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            //     //   email: emailController.text,
            //     //   password: passwordController.text,
            //     // );
            //
            //   } on FirebaseAuthException catch (e) {
            //     if (e.code == 'weak-password') {
            //       AwesomeDialog(
            //         context: context,
            //         dialogType: DialogType.error,
            //         animType: AnimType.rightSlide,
            //         title: 'Error',
            //         desc: 'weak password',
            //       )..show();
            //     } else if (e.code == 'email-already-in-use') {
            //       AwesomeDialog(
            //         context: context,
            //         dialogType: DialogType.error,
            //         animType: AnimType.rightSlide,
            //         title: 'Error',
            //         desc: 'this email is already in use',
            //       )..show();
            //     }
            //   } catch (e) {
            //     print(e);
            //   }
          }

          if (state is ServiceRegisterCreateUserSuccessState) {
            navigateTo(
              context,
              ServiceLoginScreen(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white24, // Setting background color to grey

            appBar: AppBar(
              bottomOpacity: 0,
              elevation: 0,
              backgroundColor: Colors.transparent, // Setting background color to grey
              leading: IconButtonHomeScreen(context),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,

                                  ),
                        ),
                        Text(
                          'Register now to start the services',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.deepOrange,
                                fontFamily: 'Tajawal',

                                  ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty)
                              return ('please enter your name');
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('ادخل مدينتك ',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),

                        ),
                        AppTextField(
                          textEditingController: cityController,
                          title: "",

                          hint: "المدينه",
                          isCitySelected: true,
                          titleTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                            color: Colors.white,
                          ),
                          hintTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                            color: Colors.white,
                          ),
                          DataList: [
                            SelectedListItem(name: "القاهرة"),
                            SelectedListItem(name: "الجيزة"),
                            SelectedListItem(name: "الاسكندرية"),
                            SelectedListItem(name: "اسيوط"),
                            SelectedListItem(name: "دمياط"),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: addressController,
                          type: TextInputType.streetAddress,
                          validate: (value) {
                            if (value!.isEmpty)
                              return ('الرجاء ادخال العنوان');
                            return null;
                          },
                          label: 'Address',
                          prefix: Icons.maps_home_work_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty)
                              return ('الرجاء ادخال البريد الالكتروني');
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          suffixPressed: () {
                            ServiceRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ServiceRegisterCubit.get(context).suffix,
                          validate: (value) {
                            if (value!.isEmpty)
                              return ('password is too short.');


                            if (value.length < 8 && !RegExp(r'[0-9]').hasMatch(value) && !RegExp(r'[a-z]').hasMatch(value)) {
                              return 'Password must be at least 8 characters long and include at least one letter and one digit';
                            }
                            return null;
                          },
                          isPassword:
                              ServiceRegisterCubit.get(context).isPassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ('الرجاء ادخال رقم التليفون');
                            }
                            return null;
                          },
                          label: 'رقم التليفون',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: whatsappController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ('الرجاء ادخال رقم الواتس اب');
                            }
                            return null;
                          },
                          label: 'رقم الواتس اب',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        Text('ادخل وظيفتك ',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),

                        ),
                        AppTextField(
                          textEditingController: jobController,
                          title: "",
                          hint: "الوظيفة",
                          isCitySelected: true,
                          DataList: [
                            SelectedListItem(name: "مستخدم عادي"),
                            SelectedListItem(name: "مقاول"),
                            SelectedListItem(name: "كهربائي"),
                            SelectedListItem(name: "سباك"),
                            SelectedListItem(name: "نجار"),
                            SelectedListItem(name: "نقاش"),
                            SelectedListItem(name: "حداد"),
                            SelectedListItem(name: "باركية"),
                            SelectedListItem(name: "تكييف"),
                            SelectedListItem(name: "الموتال"),
                            SelectedListItem(name: "رخام"),
                          ],
                        ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        // defaultFormField(
                        //   controller: locationlink,
                        //   type: TextInputType.url,
                        //   validate: (value) {
                        //     if (value!.isEmpty) {
                        //       return ('please enter your location link');
                        //     }
                        //     return null;
                        //   },
                        //   label: 'location',
                        //   prefix: Icons.location_city_outlined,
                        // ),

                        SizedBox(
                          height: 25.0,
                        ),

                        Center(
                          child: defaultButton(
                              function: () async {
                                await getImage();
                              },
                              text: 'التقاط صورة'),
                        ),
                        if (url != null)
                          Center(
                            child: Image.network(

                              url!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ),

                        SizedBox(
                          height: 25.0,
                        ),

                        Center(
                          child: defaultButton(
                              function: () {

                                if (formKey.currentState!.validate()) {
                                  ServiceRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      whatsapp: whatsappController.text,
                                      address: addressController.text,
                                      job: jobController.text,
                                      city: cityController.text,
                                    //  locationlink: locationlink.toString(),
                                      image: url.toString());
                                }
                              },
                              text: 'REGISTER'),
                        ),
                        if (file != null)
                          Image.file(
                            file!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        SizedBox(height: 100,),

                        // ElevatedButton(
                        //   onPressed: () {
                        //     addUser();
                        //     navigateTo(context, ServiceLayout());
                        //   },
                        //   child: Text("REGISTER"),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
//   Future<void>? addUser() {
//     // Call the user's CollectionReference to add a new user
//     if (jobController.text == 'نجار') {
//       return jobs.add({
//         if (formKey.currentState!.validate())
//           {
//             'الاسم': nameController.text,
//             'رقم التليفون': phoneController.text,
//             'كلمة السر': passwordController.text,
//             'العنوان': addressController.text,
//             'الوظيفة': jobController.text,
//             'الايميل': emailController.text,
//           }
//       });
//     } else if (jobController.text == 'سباك') {
//       return jobs2.add({
//         if (formKey.currentState!.validate())
//           {
//             'الاسم': nameController.text,
//             'رقم التليفون': phoneController.text,
//             'كلمة السر': passwordController.text,
//             'العنوان': addressController.text,
//             'الوظيفة': jobController.text,
//             'الايميل': emailController.text,
//           }
//       });
//     } else if (jobController.text == 'مستخدم') {
//       return jobs4.add({
//         if (formKey.currentState!.validate())
//           {
//             'الاسم': nameController.text,
//             'رقم التليفون': phoneController.text,
//             'كلمة السر': passwordController.text,
//             'العنوان': addressController.text,
//             'الوظيفة': jobController.text,
//             'الايميل': emailController.text,
//           }
//       });
//     } else if (jobController.text == 'كهربائي') {
//       return jobs3.add({
//         if (formKey.currentState!.validate())
//           {
//             'الاسم': nameController.text,
//             'رقم التليفون': phoneController.text,
//             'كلمة السر': passwordController.text,
//             'العنوان': addressController.text,
//             'الوظيفة': jobController.text,
//             'الايميل': emailController.text,
//           }
//       });
//     } else if (jobController.text == 'مقاول') {
//       return jobs5.add({
//         if (formKey.currentState!.validate())
//           {
//             {
//               'الاسم': nameController.text,
//               'رقم التليفون': phoneController.text,
//               'كلمة السر': passwordController.text,
//               'العنوان': addressController.text,
//               'الوظيفة': jobController.text,
//               'الايميل': emailController.text,
//             }
//           }
//       });
//     }
//   }
// }

// class ServiceRegisterScreen extends StatefulWidget {
//   const ServiceRegisterScreen({super.key});
//
//   @override
//   State<ServiceRegisterScreen> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<ServiceRegisterScreen> {
//   TextEditingController username = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController phone = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         child: ListView(children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(height: 50),
//               //const CustomLogoAuth(),
//               Container(height: 20),
//               const Text("SignUp",
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//               Container(height: 10),
//               const Text("SignUp To Continue Using The App",
//                   style: TextStyle(color: Colors.grey)),
//               Container(height: 20),
//               const Text(
//                 "username",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               Container(height: 10),
//               CustomTextForm(
//                   hinttext: "ُEnter Your username", mycontroller: username),
//               const Text(
//                 "Phone number",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               Container(height: 10),
//               CustomTextForm(
//                   hinttext: "ُEnter Your Phone number", mycontroller: phone),
//               Container(height: 20),
//               const Text(
//                 "Email",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               Container(height: 10),
//               CustomTextForm(
//                   hinttext: "ُEnter Your Email", mycontroller: email),
//               Container(height: 10),
//               const Text(
//                 "Password",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               Container(height: 10),
//               CustomTextForm(
//                   hinttext: "ُEnter Your Password", mycontroller: password),
//               Container(
//                 margin: const EdgeInsets.only(top: 10, bottom: 20),
//                 alignment: Alignment.topRight,
//                 child: const Text(
//                   "Forgot Password ?",
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           CustomButtonAuth(
//               title: "SignUp",
//               onPressed: ()  {
//                 ConditionalBuilder(
//                             condition: state is! ServiceRegisterLoadingState,
//                             builder: (context) => defaultButton(
//                               function: ()
//                               {
//                                 if(formKey.currentState!.validate())
//                                 {
//                                   ServiceRegisterCubit.get(context).userRegister(
//                                     name:nameController.text,
//                                     email: emailController.text,
//                                     password: passwordController.text,
//                                     phone: phoneController.text,
//                                   );
//                                 }
//                               },
//                               text: 'register',
//                               isUpperCase: true,
//                             ),
//                             fallback: (context) =>Center(child: CircularProgressIndicator(),),
//                         ),
//               }),
//           Container(height: 20),
//
//           Container(height: 20),
//           // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
//           InkWell(
//             onTap: () {
//               navigateTo(context, ServiceLoginScreen());
//             },
//             child: const Center(
//               child: Text.rich(TextSpan(children: [
//                 TextSpan(
//                   text: "Have An Account ? ",
//                 ),
//                 TextSpan(
//                     text: "Login",
//                     style: TextStyle(
//                         color: Colors.orange, fontWeight: FontWeight.bold)),
//               ])),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }
