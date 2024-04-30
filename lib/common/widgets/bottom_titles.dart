import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
import 'package:notedapp/common/widgets/height_spacer.dart';
import 'package:notedapp/common/widgets/reusable_text.dart';
import 'package:notedapp/common/widgets/width_spacer.dart';
import 'package:notedapp/features/todo/controllers/todo/todo_notifier.dart';



class BottomTitles extends StatefulWidget {
  const BottomTitles({super.key, this.clr, required this.text, required this.text2});
  final Color? clr;
  final String text;
  final String text2;

  @override
  State<BottomTitles> createState() => _BottomTitlesState();
}

class _BottomTitlesState extends State<BottomTitles> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                      color: widget.clr ??
                          ref.read(todosNotifierProvider.notifier).getRandomColour(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                );
              },
            ),
            const WidthSpacer(wydth: 15),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                      text: widget.text,
                      style: appstyle(20, AppConst.kDarkGrey, FontWeight.bold)),
                  const HeightSpacer(height: 10),
                  ReusableText(
                      text: widget.text2,
                      style: appstyle(12, AppConst.kDarkGrey, FontWeight.normal))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
