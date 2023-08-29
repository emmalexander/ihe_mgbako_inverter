import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihe_mgbako_inverter/style/app_colors.dart';
import 'package:ihe_mgbako_inverter/widgets/big_text_widget.dart';
import 'package:ihe_mgbako_inverter/widgets/button_widget.dart';

class ModesScreen extends StatelessWidget {
  const ModesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String loadRoute = '/loadCalculator';
    String backupRoute = '/backupCalculator';

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 65.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              onTap: () {
                Navigator.pushNamed(context, loadRoute);
              },
              text: 'Load Calculator',
              width: 260.w,
              isResponsive: true,
              height: 45.h,
              borderRadius: 25.r,
            ),
            SizedBox(height: 20.h),
            ButtonWidget(
              onTap: () {
                Navigator.pushNamed(context, backupRoute);
              },
              text: 'Backup Calculator',
              width: 260.w,
              isResponsive: true,
              height: 45.h,
              borderRadius: 25.r,
            ),
          ],
        ),
      ),
    );
  }
}
