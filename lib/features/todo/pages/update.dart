import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notedapp/common/models/task.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
import 'package:notedapp/common/widgets/custom_outline_btn.dart';
import 'package:notedapp/common/widgets/custom_textfield.dart';
import 'package:notedapp/common/widgets/height_spacer.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:notedapp/common/widgets/show_alert_dialog.dart';
import 'package:notedapp/features/todo/controllers/start_time_provider.dart';
import 'package:notedapp/features/todo/controllers/todo/todo_notifier.dart';

class Update extends ConsumerStatefulWidget {
  const Update({super.key, required this.data});

  final Task data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateState();
}

class _UpdateState extends ConsumerState<Update> {
  final TextEditingController title = TextEditingController(text: updateTitle);
  final TextEditingController desc = TextEditingController(text: updateDescription);
  final TextEditingController datet = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var start = ref.watch(startTimeNotifierProvider);
    var finish = ref.watch(finishTimeNotifierProvider);
    var scheduleDate = ref.watch(dateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: ListView(
          children: [
            const HeightSpacer(height: 20),
            CustomTextField(
                hintText: widget.data.title.toString(),
                controller: title,
                hintStyle: appstyle(16, AppConst.kMediumZomp, FontWeight.w600)),
            const HeightSpacer(height: 20),
            CustomTextField(
                hintText: widget.data.desc.toString(),
                controller: desc,
                hintStyle: appstyle(16, AppConst.kMediumZomp, FontWeight.w600)),
            const HeightSpacer(height: 20),
            Consumer(
              builder: (context, ref, child) {
                return CustomOutlineBtn(
                    onTap: () {
                      picker.DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2024, 4, 1),
                          maxTime: DateTime(2025, 4, 1),
                          theme: const picker.DatePickerTheme(
                              //headerColor: AppConst.kTeaGreen,
                              backgroundColor: AppConst.kGrey,
                              itemStyle: TextStyle(
                                  color: AppConst.kDarkGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              doneStyle:
                                  TextStyle(color: AppConst.kCharcoal, fontSize: 16)),
                          onChanged: (date) {}, onConfirm: (date) {
                        ref
                            .read(dateNotifierProvider.notifier)
                            .setStart(date.toString());
                      },
                          currentTime: DateTime.now(),
                          locale: picker.LocaleType.en);
                    },
                    height: 52.h,
                    text: scheduleDate == "" ? "Set date" : scheduleDate.substring(0, 10),
                    color2: AppConst.kveryLightGreen,
                    color: AppConst.kZomp);
              },
            ),
            const HeightSpacer(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOutlineBtn(
                    onTap: () {
                      picker.DatePicker.showTime12hPicker(context,
                          locale: LocaleType.en,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(startTimeNotifierProvider.notifier)
                            .setStart(date.toString());
                      }, 
                      // locale: picker.LocaleType.en);
                      currentTime: DateTime.now());
                    },
                    height: 52.h,
                    width: AppConst.kWidth * .4,
                    text: start == "" ? "Start Time" : start.substring(10, 16),
                    color2: AppConst.kveryLightGreen,
                    color: AppConst.kZomp),
                CustomOutlineBtn(
                    onTap: () {
                      picker.DatePicker.showTime12hPicker(context,
                          locale: LocaleType.en,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(finishTimeNotifierProvider.notifier)
                            .setStart(date.toString());
                      }, currentTime: DateTime.now());
                    },
                    height: 52.h,
                    width: AppConst.kWidth * .4,
                    color2: AppConst.kveryLightGreen,
                    text: finish == "" ? "End Time" : finish.substring(10, 16),
                    color: AppConst.kZomp),
              ],
            ),
            const HeightSpacer(height: 20),
            Consumer(
              builder: (context, ref, child) {
                return CustomOutlineBtn(
                    onTap: () {
                      if (title.text.isNotEmpty &&
                          desc.text.isNotEmpty &&
                          scheduleDate.isNotEmpty &&
                          start.isNotEmpty &&
                          finish.isNotEmpty) {
                        ref.read(todosNotifierProvider.notifier).updateTodos(
                            widget.data.id?? 0,
                            title.text,
                            desc.text,
                            scheduleDate,
                            start.substring(10, 16),
                            finish.substring(10, 16)).then((value) {
                          ref.read(dateNotifierProvider.notifier).setStart('');
                          ref.read(startTimeNotifierProvider.notifier).setStart('');
                          ref.read(finishTimeNotifierProvider.notifier).setStart('');
                          Navigator.pop(context);
                        });
                      } else {
                        showAlertDialog(
                            context: context,
                            message: "To submit please provide all fields");
                      }
                    },
                    height: 52.h,
                    text: "Submit",
                    color2: AppConst.kLightGreen,
                    color: AppConst.kZomp);
              },
            )
          ],
        ),
      ),
    );
  }
}
