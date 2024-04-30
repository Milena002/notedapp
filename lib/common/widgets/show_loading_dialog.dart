

import 'package:flutter/material.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
showLoadingDialog({
  required BuildContext context,
  required String message,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const CircularProgressIndicator(
                  color: AppConst.kLightGreen,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    message,
                    style: appstyle(18, AppConst.kGrey, FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
