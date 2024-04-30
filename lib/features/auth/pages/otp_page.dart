import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
import 'package:notedapp/common/widgets/height_spacer.dart';
import 'package:notedapp/common/widgets/reusable_text.dart';
import 'package:notedapp/features/auth/controllers/auth_controller.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({Key? key, required this.smsCodeId, required this.phone});

  final String smsCodeId;
  final String phone;


  void verifyOtpCode(
    BuildContext context,
    WidgetRef ref,
    String smsCode
  ){
    ref.read(authControllerProvider).verifyOtpCode(
      context: context,
       smsCodeId: smsCodeId,
        smsCode: smsCode, 
        mounted: true);
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView( 
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeightSpacer(height: AppConst.kHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  child: Image.asset(
                    "assets/images/logo-color.png",
                    width: AppConst.kWidth * 0.5,
                  ),
                ),
                const HeightSpacer(height: 26),
                ReusableText(
                  text: "Enter Your One Time SMS passcode:",
                  style: appstyle(18, AppConst.kLightGreen, FontWeight.bold),
                ),
                const HeightSpacer(height: 26),
                SizedBox(
                  width: ScreenUtil().setWidth(320), 
                  child: Pinput(
                    length: 6,
                    showCursor: true,
                    onCompleted: (value) {
                      if (value.length == 6) {
                    
                        return verifyOtpCode(context, ref, value);
                      }
                    },
                    onSubmitted: (value) {
                      if (value.length == 6) {
                     
                        return verifyOtpCode(context, ref, value); 
                      }
                    },
                  ),
                ),
               const SizedBox(height: 100), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
