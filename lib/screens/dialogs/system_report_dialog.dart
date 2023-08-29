import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihe_mgbako_inverter/provider/hive_provider.dart';
import 'package:ihe_mgbako_inverter/provider/ui_provider.dart';
import 'package:provider/provider.dart';

import '../../style/app_colors.dart';
import '../../widgets/big_text_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/small_text_widget.dart';

class SystemReportDialog extends StatelessWidget {
  const SystemReportDialog(
      {Key? key,
      this.isBackupScreen = false,
      this.load,
      this.timeH,
      this.timeM,
      this.rating})
      : super(key: key);
  final bool isBackupScreen;
  final String? load;
  final String? timeH;
  final String? timeM;
  final String? rating;

  @override
  Widget build(BuildContext context) {
    String backupScreen = '/backupCalculator';
    final systemReportProv = Provider.of<HiveProvider>(context);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
          contentPadding: EdgeInsets.all(15.w),
          content: SizedBox(
            width: 312.w,
            height: 220.h,
            child: Column(
              children: [
                const BigText(text: 'System Report'),
                SizedBox(height: 8.h),
                const Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                SizedBox(height: 8.h),
                SmallText(
                    overflow: TextOverflow.visible,
                    text: isBackupScreen
                        ? 'The rating of battery for your desired backup time is: '
                        : 'From the total wattage, the suggested Inverter rating is',
                    fontWeight: FontWeight.w500,
                    textColor: mainTextColor),
                SizedBox(height: 20.h),
                Consumer<UIProvider>(builder: (context, uiProv, child) {
                  return SmallText(
                      text: isBackupScreen
                          ? '${rating}V/${uiProv.calculateBackup(load!, timeH!, timeM!, rating!)}AH'
                          : '${((systemReportProv.totalWattage) / 0.8).toStringAsFixed(0)}VA or ${(((systemReportProv.totalWattage) / 0.8) / 1000).toStringAsFixed(2)}KVA',
                      fontWeight: FontWeight.w800,
                      textColor: Colors.green);
                }),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(
                      onTap: () {
                        isBackupScreen
                            ? Navigator.pop(context)
                            : Navigator.pushNamed(context, backupScreen);
                      },
                      borderRadius: 50,
                      text: isBackupScreen
                          ? 'Done'
                          : 'Proceed to Backup Calculator',
                      width: isBackupScreen ? 80.w : 280.w,
                      height: 40.h,
                      isResponsive: true,
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
