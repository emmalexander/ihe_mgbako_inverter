import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  const SmallText(
      {Key? key,
      required this.text,
      this.textColor = Colors.black,
      this.fontWeight = FontWeight.w300,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: GoogleFonts.spaceGrotesk(
          fontSize: 15.sm, fontWeight: fontWeight, color: textColor),
      textAlign: TextAlign.center,
    );
  }
}
