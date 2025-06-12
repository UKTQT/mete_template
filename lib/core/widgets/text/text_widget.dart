import 'package:com_nectrom_metetemplate/core/utils/app_utils.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String? title;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  const TextWidget({
    super.key,
    this.title = "",
    this.style,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      AppUtils.instance.capitalizeWords(title),
      softWrap: true,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
