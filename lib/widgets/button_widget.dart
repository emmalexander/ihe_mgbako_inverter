import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihe_mgbako_inverter/style/app_colors.dart';
import 'package:ihe_mgbako_inverter/widgets/small_text_widget.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.onTap,
      this.isResponsive = false,
      this.width,
      required this.text,
      this.borderRadius = 10,
      this.height,
      this.hasBorder = false,
      this.fontWeight = FontWeight.w500})
      : super(key: key);
  final Function() onTap;
  final bool isResponsive;
  final double? width;
  final String text;
  final double borderRadius;
  final double? height;
  final bool hasBorder;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isResponsive ? width : 80.w,
        height: isResponsive ? height : 40.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: mainTextColor, width: 2.w),
            color: hasBorder ? Colors.white : mainTextColor),
        child: Center(
          child: SmallText(
            text: text,
            fontWeight: fontWeight,
            textColor: hasBorder ? mainTextColor : Colors.white,
          ),
        ),
      ),
    );
  }
}
