import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
import 'package:shattably/features/home/presention/layout/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/cards_view/one_card_screen.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/google_maps/google_maps_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String job = "";

class CardHomeScreen extends StatelessWidget {
  String? textTitle;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(

          backgroundColor: Colors.black38,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,




          ),
          body: Column(

            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepOrange, // Border color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: one_card(
                                imageForCard: 'electrician.png',
                                textTitle:
                                '${AppLocalizations.of(context)!.electrician}',
                                function: () {
                                  job = "كهربائي";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => form(job)),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepOrange, // Border color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: one_card(
                                imageForCard: 'plumber.png',
                                textTitle:
                                '${AppLocalizations.of(context)!.plumber}',
                                function: () {
                                  job = "سباك";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => form(job)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepOrange, // Border color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: one_card(
                                imageForCard: 'carpenter.png',
                                textTitle:
                                '${AppLocalizations.of(context)!.carpenter}',
                                function: () {
                                  job = "نجار";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => form(job)),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepOrange, // Border color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: one_card(
                                imageForCard: 'painter.png',
                                textTitle:
                                '${AppLocalizations.of(context)!.painter}',
                                function: () {
                                  job = "نقاش";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => form(job)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepOrange, // Border color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: one_card(
                                imageForCard: 'ceramic_tiles.png',
                                textTitle:
                                '${AppLocalizations.of(context)!.ceramicTiles}',
                                function: () {
                                  job = "سيراميك";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => form(job)),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepOrange, // Border color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: one_card(
                                imageForCard: 'simth.png',
                                textTitle:
                                '${AppLocalizations.of(context)!.smith}',
                                function: () {
                                  job = "حداد";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => form(job)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepOrange, // Border color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: one_card(
                                imageForCard: 'conditioning.png',
                                textTitle:
                                '${AppLocalizations.of(context)!.conditioning}',
                                function: () {
                                  job = "تكييف";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => form(job)),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepOrange, // Border color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: one_card(
                                imageForCard: 'parquet.png',
                                textTitle:
                                '${AppLocalizations.of(context)!.parquet}',
                                function: () {
                                  job = "باركية";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => form(job)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepOrange, // Border color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: one_card(
                                imageForCard: 'portal.png',
                                textTitle:
                                '${AppLocalizations.of(context)!.portal}',
                                function: () {
                                  job = "الموتال";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => form(job)),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepOrange, // Border color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: one_card(
                                imageForCard: 'marble.png',
                                textTitle:
                                '${AppLocalizations.of(context)!.marble}',
                                function: () {
                                  job = "رخام";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => form(job)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
