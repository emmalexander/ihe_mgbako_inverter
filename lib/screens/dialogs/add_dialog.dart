import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihe_mgbako_inverter/provider/hive_provider.dart';
import 'package:ihe_mgbako_inverter/style/app_colors.dart';
import 'package:ihe_mgbako_inverter/widgets/button_widget.dart';
import 'package:ihe_mgbako_inverter/widgets/input_text_field.dart';
import 'package:ihe_mgbako_inverter/widgets/small_text_widget.dart';
import 'package:ihe_mgbako_inverter/consts/global_consts.dart';
import 'package:provider/provider.dart';

import '../../model/database_model.dart';

class AddDialog extends StatelessWidget {
  const AddDialog(
      {Key? key,
      this.isEditing = false,
      required this.context,
      this.databaseModel,
      this.initialAppliance,
      this.initialQuantity,
      this.initialPower})
      : super(key: key);
  final bool isEditing;
  final BuildContext context;
  final DatabaseModel? databaseModel;
  final String? initialAppliance;
  final String? initialQuantity;
  final String? initialPower;

  @override
  Widget build(BuildContext context) {
    final hiveProvider = Provider.of<HiveProvider>(context);
    TextEditingController controllerAppliance =
        TextEditingController(text: initialAppliance);
    TextEditingController controllerQuantity =
        TextEditingController(text: initialQuantity);
    TextEditingController controllerPower =
        TextEditingController(text: initialPower);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: EdgeInsets.all(12.w),
      content: SizedBox(
        width: 230.w,
        height: 350.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //close button
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      focusNodes[0].unfocus();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    color: mainTextColor)),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  const SmallText(
                      text: 'Appliance', fontWeight: FontWeight.w400),
                  SizedBox(height: 5.h),
                  InputTextField(
                    keyboardType: TextInputType.name,
                    formKey: formKeys[0],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*field can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    focusNode: focusNodes[0],
                    controller:
                        isEditing ? controllerAppliance : myControllers[0],
                  ),
                  SizedBox(height: 5.h),
                  const SmallText(
                      text: 'Quantity', fontWeight: FontWeight.w400),
                  SizedBox(height: 5.h),
                  InputTextField(
                    keyboardType: TextInputType.number,
                    formKey: formKeys[1],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*input a number';
                      }
                      if (value.length > 10) {
                        return '*quantity too large';
                      } else {
                        return null;
                      }
                    },
                    focusNode: focusNodes[1],
                    controller:
                        isEditing ? controllerQuantity : myControllers[1],
                  ),
                  SizedBox(height: 5.h),
                  const SmallText(text: 'Power', fontWeight: FontWeight.w400),
                  SizedBox(height: 5.h),
                  InputTextField(
                    formKey: formKeys[2],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '*input a number';
                      }
                      if (value.length > 10) {
                        return '*input too long';
                      } else {
                        return null;
                      }
                    },
                    focusNode: focusNodes[2],
                    controller: isEditing ? controllerPower : myControllers[2],
                  ),
                  SizedBox(height: 30.h),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: ButtonWidget(
                        text: isEditing ? 'Save' : 'Add',
                        onTap: () {
                          if (!isEditing &&
                              formKeys[0].currentState.validate() &&
                              formKeys[1].currentState.validate() &&
                              formKeys[2].currentState.validate()) {
                            hiveProvider.addData(
                                myControllers[0].value.text.toString(),
                                myControllers[1].value.text.toString(),
                                myControllers[2].value.text.toString());

                            focusNodes[0].unfocus();
                            focusNodes[1].unfocus();
                            focusNodes[2].unfocus();

                            myControllers[0].clear();
                            myControllers[1].clear();
                            myControllers[2].clear();

                            Navigator.pop(context);
                          } else if (isEditing &&
                              formKeys[0].currentState.validate() &&
                              formKeys[1].currentState.validate() &&
                              formKeys[2].currentState.validate()) {
                            //editing code
                            hiveProvider.editData(
                                databaseModel!,
                                controllerAppliance.value.text.toString(),
                                controllerQuantity.value.text.toString(),
                                controllerPower.value.text.toString());

                            focusNodes[0].unfocus();
                            focusNodes[1].unfocus();
                            focusNodes[2].unfocus();

                            // controllerAppliance.clear();
                            // controllerQuantity.clear();
                            // controllerPower.clear();

                            Navigator.pop(context);
                          }

                          // myControllers[0].dispose();
                          // myControllers[1].dispose();
                          // myControllers[2].dispose();
                        },
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
