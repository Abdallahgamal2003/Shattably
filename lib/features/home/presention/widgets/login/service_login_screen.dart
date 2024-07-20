import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/widgets/login/cubit/cubit.dart';
import 'package:shattably/features/home/presention/widgets/login/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/register/service_register_screen.dart';
import 'package:shattably/home.dart';
import 'package:shattably/network/local/cache_helper.dart';
import 'package:flutter/services.dart';


class ServiceLoginScreen extends StatelessWidget {
  ServiceLoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => ServiceLoginCubit(),
      child: BlocConsumer<ServiceLoginCubit, ServiceLoginStates>(
        listener: (context, state) async {
          if (state is ServiceLoginErrorState) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'حدث خطأ',
              desc:
              'يوجد خطا في البيانات المدخلة. برجاء ادخال البيانات صحيحة',
            ).show();
            return;
          }

          if (state is ServiceLoginSuccessState
             ) {
            final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
            if( credential.user!.emailVerified) {

              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                navigateAndFinish(context, Home());
              });
            }
            else
              {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: 'حدث خطأ',
                  desc:
                  'هذا الايميل لم يتم التحقق منه من خلال اللينك المرسل',
                ).show();
                return;
              }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white24, // Setting background color to grey

            appBar: AppBar(
              bottomOpacity: 0,
              elevation: 0,
              backgroundColor: Colors.transparent, // Setting background color to grey


            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'login',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.white,
                                fontFamily: 'Tajawal',
                                  ),
                        ),
                        Text(
                          'now to see our different services ',
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
                          autoFocus: true,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ('please enter your email address');
                            }
                            return null;
                          },
                          label: 'email address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ServiceLoginCubit.get(context).suffix,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ServiceLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ('password is too short');
                            }
                            return null;
                          },
                          isPassword: ServiceLoginCubit.get(context).isPassword,
                          label: 'password',
                          prefix: Icons.lock_outline,
                        ),
                        InkWell(
                          onTap: () async {
                            if(emailController.text=="")
                              {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'حدث خطأ',
                                  desc: 'برجاء كتابة البريد الالكتروني اولا',
                                ).show();
                                return;
                              }
                            try
                            {
                              await FirebaseAuth.instance.sendPasswordResetEmail(
                                  email: emailController.text);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'تم بنجاح',
                                desc: 'لقد تم ارسال لينك لاعادة تعيين كلمة المرور',
                              ).show();
                            }catch(e)
                            {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'برجاءالتاكد من البريد الالكتروني',
                              ).show();
                              return;
                            }


                          },


                          child: Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            alignment: Alignment.topRight,
                            child: const Text(
                              "Forgot Password ?",

                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 15 ,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ServiceLoginLoadingState,
                          builder: (context) => Center(
                            child: defaultButton(
                              function: () async {
                                {
                                  if (formKey.currentState!.validate()) {
                                    ServiceLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    );


                                  }
                                }
                                // navigateAndFinish(context, ServiceLayout());
                              },
                              text: 'login',
                              isUpperCase: true,
                            ),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'dont have an account?',
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 20 ,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                              ),
                            ),
                            defaultTextButton(
                              function: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceRegisterScreen(),),);
                                navigateTo(context, ServiceRegisterScreen());
                              },
                              text: 'register',


                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.0,
                        ),

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
// class ServiceLoginScreen extends StatefulWidget {
//   const ServiceLoginScreen({super.key});
//
//   @override
//   State<ServiceLoginScreen> createState() => _LoginState();
// }
//
// class _LoginState extends State<ServiceLoginScreen> {
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
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
//               const Text("Login",
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//               Container(height: 10),
//               const Text("Login To Continue Using The App",
//                   style: TextStyle(color: Colors.grey)),
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
//           CustomButtonAuth(title: "login", onPressed: () {
//             navigateTo(context, ServiceLayout());
//           }),
//           Container(height: 20),
//
//           MaterialButton(
//               height: 40,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               color: Colors.red[700],
//               textColor: Colors.white,
//               onPressed: () {},
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Login With Google  "),
//                  // Image.asset(
//                  //    "images/4.png",
//                  //    width: 20,
//                  //  )
//                 ],
//               )),
//           Container(height: 20),
//           // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
//           InkWell(
//             onTap: () {
//               navigateTo(context, ServiceRegisterScreen());
//             },
//             child: const Center(
//               child: Text.rich(TextSpan(children: [
//                 TextSpan(
//                   text: "Don't Have An Account ? ",
//                 ),
//                 TextSpan(
//                     text: "Register",
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
//
