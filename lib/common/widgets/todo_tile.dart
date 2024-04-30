 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
import 'package:notedapp/common/widgets/height_spacer.dart';
import 'package:notedapp/common/widgets/reusable_text.dart';
import 'package:notedapp/common/widgets/width_spacer.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key,
       this.child,
      this.title,
      this.description,
      this.update,
      this.delete,
      this.color,
      this.start,
      this.end, this.editIcon});
  final Widget? child;
  final Widget? editIcon;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final void Function()? update;
  final void Function()? delete;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            width: AppConst.kWidth,
            decoration: const BoxDecoration(
                color: AppConst.kZomp,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                   
                    Container(
                      height: 80,
                      width: 5,
                      decoration: BoxDecoration(
                          color: color ?? AppConst.kZomp,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                    ),
                    const WidthSpacer(wydth: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: AppConst.kWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: title ?? 'Title of Todo',
                                style: appstyle(
                                    18, AppConst.kVeryTeaGreen, FontWeight.bold)),
                            const HeightSpacer(height: 3),
                            ReusableText(
                                text: description ?? "Description of Todo",
                                style: appstyle(
                                    12, AppConst.kVeryTeaGreen, FontWeight.bold)),
                            const HeightSpacer(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               
                                Container(
                                  width: AppConst.kWidth * 0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3, color: AppConst.kAntiqueWhite),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    color: AppConst.kMediumZomp,
                                  ),
                                  child: Center(
                                    child: ReusableText(
                                        text: "$start | $end",
                                        style: appstyle(12, AppConst.kpeach,
                                            FontWeight.bold)),
                                  ),
                                ),
                               
                                const WidthSpacer(wydth: 20),
                               
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editIcon,
                                    ),
                                    const WidthSpacer(wydth: 20),
                                    GestureDetector(
                                        onTap: delete,
                                        child: const Icon(MaterialCommunityIcons
                                            .delete_circle)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 0.h,
                  ),
                  child: child,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}