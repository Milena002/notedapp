import 'package:flutter/material.dart';
import 'package:notedapp/common/widgets/reusable_text.dart';
import 'package:notedapp/common/widgets/appstyle.dart';

class CustomOutlineBtn extends StatelessWidget {
  const CustomOutlineBtn( {
    super.key, this.width, this.height, required this.text, 
    this.onTap, required this.color, this.color2,
  });

  final double? width;
  final double? height;
  final String text;
  final void Function()? onTap;
  final Color color;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(width: 1, color: color),
        ),
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(18, color, FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
