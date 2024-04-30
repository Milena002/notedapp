import 'package:flutter/material.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notedapp/common/widgets/height_spacer.dart';
import 'package:notedapp/common/widgets/reusable_text.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.kHeight,
      width: AppConst.kWidth,
      color: AppConst.kWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Image.asset("assets/images/logo-color.png"),
        ),
        
       const HeightSpacer(height: 100),

       Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReusableText(text: "Welcome To Noted!", 
          style: appstyle(30, AppConst.kZomp, FontWeight.w600)),
          const HeightSpacer(height: 10),

          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
          "Manage Your Tasks and Time with ease.",
          textAlign: TextAlign.center,
          style: appstyle(16, AppConst.kCharcoal, FontWeight.normal),
          )
          )
        ],
       )
          ],
      ),
    );
  }
}