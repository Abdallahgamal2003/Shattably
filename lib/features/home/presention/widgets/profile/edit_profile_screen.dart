import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';
import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
import 'package:shattably/features/home/presention/layout/cubit/states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var jobController = TextEditingController();
  var cityController = TextEditingController();
  var whatsappController = TextEditingController();
 // var locationlink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = ServiceCubit.get(context).userModel;
        var profileImage = ServiceCubit.get(context).profileImage;

        nameController.text = userModel!.name;
        phoneController.text = userModel!.phone;
        emailController.text = userModel!.email;
        addressController.text = userModel!.address;
        cityController.text = userModel!.city;
        jobController.text = userModel!.job;
        whatsappController.text = userModel!.whatsapp;
        //locationlink.text = userModel!.locationlink;

        return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var userModel = ServiceCubit.get(context).userModel;
            var profileImage = ServiceCubit.get(context).profileImage;

            nameController.text = userModel!.name;
            phoneController.text = userModel!.phone;
            emailController.text = userModel!.email;
            addressController.text = userModel!.address;
            cityController.text = userModel!.city;
            jobController.text = userModel!.job;
            whatsappController.text = userModel!.whatsapp;
            //locationlink.text = userModel!.locationlink;

            return Scaffold(
              appBar: AppBar(
                leading: IconButtonHomeScreen(context),
                title: Text(
                  'Edit Profile',
                ),
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (state is ServiceUserUpdateLoadingState)
                        LinearProgressIndicator(),
                      if (state is ServiceUserUpdateLoadingState)
                        SizedBox(
                          height: 10.0,
                        ),
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 55.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                          '${userModel.image}',
                                        )
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                  backgroundColor: Colors.white,
                                ),
                                IconButton(
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 14.0,
                                    child: Icon(
                                      Icons.edit,
                                      size: 16.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    ServiceCubit.get(context).getProfileImage();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Text(
                              '${userModel.name}',
                              style: kTextDialog,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Column(
                        children: [
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return ('الاسم يجب الا تكون فارغة');
                              }

                              return null;
                            },
                            label: 'الاسم',
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return ('البريد الالكتروني يجب الا تكون فارغة');
                              }
                              return null;
                            },
                            label: 'البريد الالكتروني',
                            prefix: Icons.email,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return ('رقم التليفون يجب الا تكون فارغة');
                              }
                              return null;
                            },
                            label: 'رقم التليفون',
                            prefix: Icons.phone,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: whatsappController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return ('رقم التليفون يجب الا تكون فارغة');
                              }
                              return null;
                            },
                            label: 'رقم التليفون',
                            prefix: Icons.phone,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          AppTextField(
                            textEditingController: jobController,
                            title: "ادخل وظيفتك",
                            hint: "الوظيفة",
                            isCitySelected: true,
                            DataList: [
                              SelectedListItem(name: "نجار"),
                              SelectedListItem(name: "سباك"),
                              SelectedListItem(name: "كهربائي"),
                              SelectedListItem(name: "مقاول"),
                              SelectedListItem(name: "مستخدم"),
                              SelectedListItem(name: "نقاش"),
                              SelectedListItem(name: "حداد"),
                              SelectedListItem(name: "باركية"),
                              SelectedListItem(name: "تكييف"),
                              SelectedListItem(name: "الموتال"),
                              SelectedListItem(name: "رخام"),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          AppTextField(
                            textEditingController: cityController,
                            title: "Enter your city",
                            hint: "city",
                            isCitySelected: true,
                            DataList: [
                              SelectedListItem(name: "القاهرة"),
                              SelectedListItem(name: "الجيزة"),
                              SelectedListItem(name: "الاسكندرية"),
                              SelectedListItem(name: "اسيوط"),
                              SelectedListItem(name: "دمياط"),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: addressController,
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return ('العنوان يجب الا تكون فارغ');
                              }
                              return null;
                            },
                            label: 'العنوان',
                            prefix: Icons.maps_home_work_outlined,
                          ),
                          // SizedBox(
                          //   height: 20.0,
                          // ),
                          // defaultFormField(
                          //   controller: locationlink,
                          //   type: TextInputType.text,
                          //   validate: (String? value) {
                          //     if (value!.isEmpty) {
                          //       return ('العنوان يجب الا تكون فارغ');
                          //     }
                          //     return null;
                          //   },
                          //   label: 'العنوان',
                          //   prefix: Icons.location_city_outlined,
                          //),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultButton(
                            text: 'تعديل البيانات',
                            function: () {
                              ServiceCubit.get(context).updateUser(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                address: addressController.text,
                                job: jobController.text,
                                city: cityController.text,
                                whatsapp: whatsappController.text,
                               // locationlink: locationlink.text,
                              );
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
        ;
      },
    );
  }
}
