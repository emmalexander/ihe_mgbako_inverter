import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihe_mgbako_inverter/style/app_colors.dart';

class RemoveButton extends StatelessWidget {
  const RemoveButton({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: removeButtonColor,
          ),
          child: const Icon(
            Icons.remove,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
// return Material(
// type: MaterialType.transparency,
// clipBehavior: Clip.hardEdge,
// shape: const CircleBorder(),
// child: InkWell(
// onTap: onTap,
// child: Padding(
// padding: const EdgeInsets.all(10),
// child: child,
// )),
// );
