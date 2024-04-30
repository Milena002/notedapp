
import 'package:flutter/material.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notedapp/common/widgets/height_spacer.dart';
import 'package:notedapp/common/widgets/custom_outline_btn.dart';
import 'package:notedapp/features/auth/pages/login_page.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

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
          child: Image.asset("assets/images/logo-no-background.png"),
        ),
        
       const HeightSpacer(height: 50),
       CustomOutlineBtn(
        onTap: (){
          Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        width: AppConst.kWidth * 0.9,
         height: AppConst.kHeight * 0.06,
         color2: AppConst.kTeaGreen,
         color: AppConst.kCharcoal,
         text: "Login with a Phone Number.")
          ],
      ),
    );
  }
}