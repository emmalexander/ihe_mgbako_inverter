import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../style/app_colors.dart';

class InputTextField extends StatelessWidget {
  const InputTextField(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.validator,
      required this.formKey,
      required this.keyboardType,
      this.hintText = 'Click to type'})
      : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final GlobalKey? formKey;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.w, top: 10.h),
          height: 25.h,
          decoration: BoxDecoration(
              color: textInputColor, borderRadius: BorderRadius.circular(8.r)),
        ),
        Form(
          key: formKey,
          child: TextFormField(
              maxLines: 1,
              keyboardType: keyboardType,
              validator: validator,
              focusNode: focusNode,
              controller: controller,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 0.h),
                hintText: hintText,
                hintStyle:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
                border: InputBorder.none,
              )),
        ),
      ],
    );
  }
}
