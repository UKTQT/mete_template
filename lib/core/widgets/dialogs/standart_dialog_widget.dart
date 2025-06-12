import 'package:com_nectrom_metetemplate/core/utils/app_utils.dart';
import 'package:com_nectrom_metetemplate/core/widgets/text/text_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<dynamic> standartDialogWidget({
  Widget? widget,
  Widget? title,
  List<Widget>? actions,
  bool barrierDismissible = true,
  double? width,
  double? height,
}) async {
  final appUtils = AppUtils.instance;

  return showDialog(
    context: appUtils.context!,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(
          vertical: appUtils.heightRatio(0.01),
          horizontal: appUtils.widthRatio(0.03),
        ),
        actionsPadding: EdgeInsets.symmetric(
          vertical: appUtils.heightRatio(0.02),
          horizontal: appUtils.widthRatio(0.03),
        ),
        title: title ??
            Row(
              children: [
                const Expanded(flex: 2, child: Icon(Icons.my_location)),
                Expanded(
                  flex: 10,
                  child: TextWidget(
                    title: 'notificationManager.informationsText'.tr(),
                    style: appUtils.theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
        content: SizedBox(
          width: width,
          height: height,
          child: widget != null ? SingleChildScrollView(child: widget) : const SizedBox.shrink(),
        ),
        actions: actions ?? [],
      );
    },
  );
}
