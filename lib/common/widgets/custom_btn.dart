import 'package:flutter/material.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/reusable_text.dart';
import 'package:notedapp/common/widgets/appstyle.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.text, this.color,
  });

  final void Function()? onTap;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppConst.kZomp,
        width: AppConst.kWidth,
        height: AppConst.kHeight* 0.065,
        child: Center(
          child: ReusableText(
              text: text,
              style: appstyle(16, color ?? AppConst.kLightGreen, FontWeight.w600)),
        ),
      ),
    );
  }
}
