import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihe_mgbako_inverter/provider/hive_provider.dart';
import 'package:ihe_mgbako_inverter/screens/dialogs/system_report_dialog.dart';
import 'package:ihe_mgbako_inverter/style/app_colors.dart';
import 'package:ihe_mgbako_inverter/widgets/big_text_widget.dart';
import 'package:ihe_mgbako_inverter/widgets/small_text_widget.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import '../widgets/button_widget.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BigText(text: 'Summary of Appliances', textSize: 24.sp),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(20.h),
                    width: double.maxFinite,
                    height: 250.h,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(
                                2, 3), // changes position of shadow
                          )
                        ],
                        color: mainBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r))),
                    child: Column(
                      children: [
                        Expanded(
                          child: Consumer<HiveProvider>(
                              builder: (context, summaryProv, child) {
                            return ListView.builder(
                                itemCount: summaryProv.getDatabaseList.length,
                                itemBuilder: (context, index) {
                                  Parser p = Parser();
                                  Expression exp = p.parse(
                                      '${summaryProv.getDatabaseList[index].quantity}*${summaryProv.getDatabaseList[index].power}');
                                  ContextModel cm = ContextModel();
                                  double totalPower =
                                      exp.evaluate(EvaluationType.REAL, cm);
                                  //totalWattage = totalPower + totalWattage;
                                  // summaryProv.totalWatt(totalWattage);
                                  // log(totalWattage.toString());
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SmallText(
                                          text:
                                              '${summaryProv.getDatabaseList[index].quantity}  ${summaryProv.getDatabaseList[index].appliance}',
                                          fontWeight: FontWeight.w500),
                                      SmallText(
                                        text: '$totalPower',
                                        textColor: mainTextColor,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  );
                                });
                          }),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    width: double.maxFinite,
                    height: 36.h,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(
                                2, 3), // changes position of shadow
                          )
                        ],
                        color: mainTextColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r))),
                    //Total wattage calculation section
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SmallText(
                            text: 'Total Wattage',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w500),
                        SizedBox(width: 25.w),
                        const SmallText(
                            text: '=',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w500),
                        SizedBox(width: 15.w),
                        Consumer<HiveProvider>(
                            builder: (context, totalProv, child) {
                          return SmallText(
                              text: '${totalProv.totalWattage}',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w500);
                        })
                      ],
                    ),
                  ),
                  SizedBox(height: 120.h),
                  const SmallText(
                      text:
                          'Confirm all entries before proceeding to the next section',
                      overflow: TextOverflow.visible),
                ],
              )),
          Positioned(
              bottom: 20.h,
              right: 20.w,
              child: ButtonWidget(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const SystemReportDialog();
                      });
                },
                text: 'See Result',
                isResponsive: true,
                width: 120.w,
                height: 40.h,
                borderRadius: 20.r,
              ))
        ],
      ),
    );
  }
}
