import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihe_mgbako_inverter/provider/hive_provider.dart';
import 'package:ihe_mgbako_inverter/screens/dialogs/add_dialog.dart';
import 'package:ihe_mgbako_inverter/screens/dialogs/delete_dialog.dart';
import 'package:ihe_mgbako_inverter/style/app_colors.dart';
import 'package:ihe_mgbako_inverter/widgets/big_text_widget.dart';
import 'package:ihe_mgbako_inverter/widgets/button_widget.dart';
import 'package:ihe_mgbako_inverter/widgets/circle_button.dart';
import 'package:ihe_mgbako_inverter/widgets/small_text_widget.dart';
import 'package:provider/provider.dart';
import 'package:math_expressions/math_expressions.dart';

import '../controllers/boxes.dart';
import '../model/database_model.dart';

class LoadCalculatorScreen extends StatefulWidget {
  const LoadCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<LoadCalculatorScreen> createState() => _LoadCalculatorScreenState();
}

class _LoadCalculatorScreenState extends State<LoadCalculatorScreen> {
  @override
  void initState() {
    Provider.of<HiveProvider>(context, listen: false).setDatabaseList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String summaryPage = '/summary';

    double totalWattage = 0;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: mainTextColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: mainTextColor,
              ))
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        title: BigText(
          text: 'ihe Mgbako Inverter',
          textSize: 20.sp,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddDialog(context: context);
              });
        },
        backgroundColor: mainTextColor,
        child: Icon(
          Icons.add,
          size: 30.sp,
        ),
      ),
      body: Consumer<HiveProvider>(builder: (context, hiveProv, child) {
        return Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'Load Calculator', textSize: 24.sp),
                    hiveProv.getDatabaseList.isEmpty
                        ? SizedBox(height: 200.h)
                        : SizedBox(height: 10.h),
                    hiveProv.getDatabaseList.isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 35.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                        color: mainBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                  ),
                                  SizedBox(width: 5.w),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    height: 35.h,
                                    width: 305.w,
                                    decoration: BoxDecoration(
                                        color: mainTextColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 35.w, left: 5.w),
                                          width: 220.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SmallText(
                                                  text: 'Appliance',
                                                  textColor: Colors.white),
                                              SmallText(
                                                  text: 'Qty',
                                                  textColor: Colors.white),
                                            ],
                                          ),
                                        ),
                                        const SmallText(
                                            text: 'Power(W)',
                                            textColor: Colors.white),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Consumer<HiveProvider>(
                                  builder: (context, boxesProvider, child) {
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        boxesProvider.getDatabaseList.length,
                                    itemBuilder: (context, index) {
                                      Parser p = Parser();
                                      Expression exp = p.parse(
                                          '${boxesProvider.getDatabaseList[index].quantity}*${boxesProvider.getDatabaseList[index].power}');
                                      ContextModel cm = ContextModel();
                                      double totalPower =
                                          exp.evaluate(EvaluationType.REAL, cm);
                                      totalWattage = totalPower + totalWattage;
                                      boxesProvider.totalWatt(totalWattage);
                                      // log(totalWattage.toString());

                                      return Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 7.w, right: 10.w),
                                            child: RemoveButton(onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return DeleteDialog(
                                                      databaseModel: boxesProvider
                                                              .getDatabaseList[
                                                          index],
                                                      context: context,
                                                    );
                                                  });
                                            }),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AddDialog(
                                                      initialAppliance:
                                                          boxesProvider
                                                              .getDatabaseList[
                                                                  index]
                                                              .appliance,
                                                      initialQuantity:
                                                          boxesProvider
                                                              .getDatabaseList[
                                                                  index]
                                                              .quantity,
                                                      initialPower:
                                                          boxesProvider
                                                              .getDatabaseList[
                                                                  index]
                                                              .power,
                                                      databaseModel: boxesProvider
                                                              .getDatabaseList[
                                                          index],
                                                      isEditing: true,
                                                      context: context,
                                                    );
                                                  });
                                              //update the values
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  // padding: EdgeInsets.symmetric(
                                                  //     horizontal: 8.w),
                                                  height: 35.h,
                                                  width: 305.w,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          mainBackgroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 15.w,
                                                                left: 15.w),
                                                        width: 200.w,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SmallText(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              text: boxesProvider
                                                                  .getDatabaseList[
                                                                      index]
                                                                  .appliance,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            SmallText(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              text: boxesProvider
                                                                  .getDatabaseList[
                                                                      index]
                                                                  .quantity,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        //width: 60.w,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w),
                                                        child: SmallText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: boxesProvider
                                                              .getDatabaseList[
                                                                  index]
                                                              .power,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5.h)
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              })
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.all(40.w),
                            child: const SmallText(
                                overflow: TextOverflow.visible,
                                text:
                                    'Click the button below to add appliances'),
                          )
                  ],
                )),
            Positioned(
                bottom: 20.h,
                right: 20.w,
                child: hiveProv.getDatabaseList.isEmpty
                    ? Container()
                    : ButtonWidget(
                        onTap: () {
                          Navigator.pushNamed(context, summaryPage);
                        },
                        text: 'Next',
                        isResponsive: true,
                        width: 100,
                        height: 32,
                        borderRadius: 20.r,
                      ))
          ],
        );
      }),
    );
  }
}
