import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihe_mgbako_inverter/provider/hive_provider.dart';
import 'package:provider/provider.dart';

import '../../model/database_model.dart';
import '../../style/app_colors.dart';
import '../../widgets/big_text_widget.dart';
import '../../widgets/button_widget.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog(
      {Key? key, required this.context, required this.databaseModel})
      : super(key: key);
  final BuildContext context;

  final DatabaseModel databaseModel;

  @override
  Widget build(BuildContext context) {
    final hiveProvider = Provider.of<HiveProvider>(context);
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        contentPadding: EdgeInsets.all(15.w),
        content: SizedBox(
          width: 240.w,
          height: 200.h,
          child: Column(
            children: [
              const BigText(text: 'Delete Item(s)'),
              SizedBox(height: 8.h),
              const Divider(color: Colors.black, thickness: 2),
              SizedBox(height: 8.h),
              const Text(
                'Do you wish to delete the selected item(s)?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: mainTextColor),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonWidget(
                    onTap: () {
                      hiveProvider.deleteData(databaseModel);
                      Navigator.pop(context);
                    },
                    text: 'Yes',
                    width: 65.w,
                    height: 40.h,
                    isResponsive: true,
                  ),
                  ButtonWidget(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    hasBorder: true,
                    text: 'No',
                    width: 65.w,
                    height: 40.h,
                    isResponsive: true,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
