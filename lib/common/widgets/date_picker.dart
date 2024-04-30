import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    this.onSaved, this.onChanged,
  });

  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      width: AppConst.kWidth * 0.9,
      decoration: BoxDecoration(
        color: AppConst.kLightGreen,
        borderRadius: BorderRadius.all(Radius.circular(12.h)),
      ),
      child: DateTimePicker(
        type: DateTimePickerType.dateTimeSeparate,
        dateMask: 'd MMM, yyyy',
        initialValue: DateTime.now().toString().toUpperCase(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        icon: const Icon(AntDesign.calendar),
        dateLabelText: 'Date',
        timeLabelText: "Hour",
        style: appstyle(16, AppConst.kGrey, FontWeight.w600),
        selectableDayPredicate: (date) {
          // Disable weekend days to select from the calendar
          // if (date.weekday == 6 || date.weekday == 7) {
          //   return false;
          // }
          return true;
        },
        onChanged: onChanged,
        validator: (val) {
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}
