import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihe_mgbako_inverter/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  const BigText(
      {Key? key,
      required this.text,
      this.textColor = mainTextColor,
      this.textSize = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.spaceGrotesk(
          fontSize: textSize, fontWeight: FontWeight.w700, color: textColor),
    );
  }
}
