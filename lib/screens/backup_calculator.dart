import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihe_mgbako_inverter/provider/ui_provider.dart';
import 'package:ihe_mgbako_inverter/screens/dialogs/system_report_dialog.dart';
import 'package:ihe_mgbako_inverter/widgets/button_widget.dart';
import 'package:ihe_mgbako_inverter/widgets/small_text_widget.dart';
import 'package:provider/provider.dart';
import '../style/app_colors.dart';
import '../widgets/big_text_widget.dart';
import '../widgets/input_text_field.dart';

class BackupCalculatorScreen extends StatelessWidget {
  const BackupCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    TextEditingController controller3 = TextEditingController();

    FocusNode focusNode1 = FocusNode();
    FocusNode focusNode2 = FocusNode();
    FocusNode focusNode3 = FocusNode();

    GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
    GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
    GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

    final ratingProv = Provider.of<UIProvider>(context, listen: false);

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
        padding: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BigText(text: 'Backup Calculator'),
              SizedBox(height: 30.h),
              const SmallText(
                  text: 'Enter Total load (W): ',
                  textColor: mainTextColor,
                  fontWeight: FontWeight.w500),
              SizedBox(height: 10.h),
              InputTextField(
                hintText: 'Click to type',
                controller: controller1,
                focusNode: focusNode1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*field can\'t be empty';
                  } else {
                    return null;
                  }
                },
                formKey: formKey1,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 30.h),
              const SmallText(
                  text: 'Enter Backup Time: ',
                  textColor: mainTextColor,
                  fontWeight: FontWeight.w500),
              SizedBox(height: 10.h),
              SizedBox(
                width: 110.w,
                child: Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                          hintText: 'hh',
                          controller: controller2,
                          focusNode: focusNode2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '**';
                            } else {
                              return null;
                            }
                          },
                          formKey: formKey2,
                          keyboardType: TextInputType.number),
                    ),
                    SizedBox(width: 5.w),
                    const SmallText(
                        text: ':',
                        textColor: mainTextColor,
                        fontWeight: FontWeight.w500),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: InputTextField(
                          hintText: 'mm',
                          controller: controller3,
                          focusNode: focusNode3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '**';
                            } else {
                              return null;
                            }
                          },
                          formKey: formKey3,
                          keyboardType: TextInputType.number),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  const SmallText(
                    text: 'Preferred Battery Rating: ',
                    textColor: mainTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 10.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Consumer<UIProvider>(
                        builder: (context, dropdownProv, child) {
                      return DropdownButton(
                          hint: const SmallText(
                            text: 'Not Selected',
                          ),
                          value: dropdownProv.getSelectedItem,
                          items: dropdownProv.getDropdownList
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: SmallText(
                                      text: '$e Volts',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            dropdownProv.selectedItem = value!;
                          });
                    }),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              ButtonWidget(
                onTap: () {
                  if (formKey1.currentState!.validate() &&
                      formKey2.currentState!.validate() &&
                      formKey3.currentState!.validate() &&
                      ratingProv.getSelectedItem == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: mainTextColor,
                      content: SmallText(
                        text: 'Please Select battery rating',
                        textColor: Colors.white,
                      ),
                    ));
                  } else if (formKey1.currentState!.validate() &&
                      formKey2.currentState!.validate() &&
                      formKey3.currentState!.validate() &&
                      ratingProv.getSelectedItem != null) {
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                    focusNode3.unfocus();

                    // controller1.clear();
                    // controller2.clear();
                    // controller3.clear();

                    showDialog(
                        context: context,
                        builder: (context) => SystemReportDialog(
                              isBackupScreen: true,
                              load: controller1.value.text.toString(),
                              timeH: controller2.value.text.toString(),
                              timeM: controller3.value.text.toString(),
                              rating: ratingProv.getSelectedItem.toString(),
                            ));
                  }
                },
                text: 'Calculate Backup',
                isResponsive: true,
                width: double.maxFinite,
                height: 35.h,
                borderRadius: 20.r,
              )
            ],
          ),
        ),
      ),
    );
  }
}
