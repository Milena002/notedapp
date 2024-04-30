import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
import 'package:notedapp/common/widgets/height_spacer.dart';
import 'package:notedapp/common/widgets/reusable_text.dart';
import 'package:notedapp/common/widgets/width_spacer.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, required this.payload});

  final String? payload;

  @override
  Widget build(BuildContext context) {
    var title = payload!.split('|')[0];
    var desc = payload!.split('|')[1];
    var date = payload!.split('|')[2];
    var start = payload!.split('|')[3];
    var end = payload!.split('|')[4];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Container(
                width: AppConst.kWidth,
                height: AppConst.kHeight * 0.7,
                decoration: BoxDecoration(
                  color: AppConst.kLightZomp,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: "Reminder",
                          style:
                              appstyle(40, AppConst.kCharcoal, FontWeight.bold)),
                      const HeightSpacer(height: 10),
                      Container(
                        width: AppConst.kWidth ,
                        padding: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: AppConst.kTeaGreen,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: date.substring(0, 10),
                                style: appstyle(14, AppConst.kDarkGrey,
                                    FontWeight.normal)),
                            const WidthSpacer(wydth: 40),
                            ReusableText(
                                text: "From:$start - To:$end",
                                style: appstyle(14, AppConst.korangy,
                                    FontWeight.bold)),
                          ],
                        ),
                      ),
                      const HeightSpacer(height: 30),
                      Container(
                        width: AppConst.kWidth*0.85,
                        height: AppConst.kHeight*0.22,
                        decoration: BoxDecoration(
                          color: AppConst.kAshgreen, // Dark grey background color
                          borderRadius: BorderRadius.circular(9), // Rounded corners
                        ),
                        padding: const EdgeInsets.all(12), // Padding for the container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: "-> $title",
                                style: appstyle(
                                    25,AppConst.korangy, FontWeight.bold)),
                            const HeightSpacer(height: 10),
                            Text(
                                desc,
                                textAlign: TextAlign.start,
                                style: appstyle(16, AppConst.kDarkGrey, FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 45,
              top: 32,
              child: Image.asset("assets/images/bell5.png",width: 65.w,height: 65.h, ),
            ),
            Positioned(
              bottom: -AppConst.kHeight * 0.152,
              left: 0,
              right: 0,
              child: Align(
                child: Opacity(
                    opacity: 0.9,
                    child: Image.asset(
                      'assets/images/icon2.png',
                      width: 120.w,
                      height: AppConst.kHeight * 0.55,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
