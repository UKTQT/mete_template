import 'package:com_nectrom_metetemplate/core/utils/app_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class InputWidget extends StatelessWidget {
  final Function()? onTap;
  final bool readOnly;
  final String? label;
  final TextEditingController? textEditingController;
  final Function(String value)? onChangedFunction;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final bool isVisible;
  final TextInputType keyboardType;
  final bool isEnabled;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode autovalidateMode;
  final String? counterText;
  final bool enableInteractiveSelection;

  const InputWidget({
    super.key,
    this.onTap,
    this.readOnly = false,
    this.label,
    this.textEditingController,
    this.onChangedFunction,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.validator,
    this.isVisible = false,
    this.keyboardType = TextInputType.text,
    this.isEnabled = true,
    this.maxLength,
    this.maxLines,
    this.inputFormatters,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.counterText,
    this.enableInteractiveSelection = true,
  });

  InputBorder buildBorder({required Color color}) {
    return OutlineInputBorder(borderSide: BorderSide(color: color), borderRadius: BorderRadius.all(Radius.circular(6.0)));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: enableInteractiveSelection,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      onTap: onTap,
      obscureText: isVisible,
      enabled: isEnabled,
      textInputAction: TextInputAction.next,
      controller: textEditingController,
      keyboardType: keyboardType,
      validator: validator ??
          (value) {
            if (value?.isEmpty ?? true) {
              return 'globalThisFieldCannotBlankText'.tr();
            }
            return null;
          },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      maxLength: maxLength,
      maxLines: maxLines,
      onChanged: onChangedFunction,
      decoration: InputDecoration(
        counterText: counterText,
        contentPadding: EdgeInsets.symmetric(vertical: AppUtils.instance.heightRatio(0.01), horizontal: AppUtils.instance.widthRatio(0.04)),
        border: buildBorder(color: Colors.black.withValues(alpha: 0.4)),
        enabledBorder: buildBorder(color: Colors.black.withValues(alpha: 0.4)),
        focusedBorder: buildBorder(color: Colors.black.withValues(alpha: 0.4)),
        errorBorder: buildBorder(color: Colors.redAccent.withValues(alpha: 0.4)),
        labelText: label,
        labelStyle: AppUtils.instance.theme.textTheme.bodySmall,
        prefixIcon: prefixIcon,
        prefix: prefix,
        suffixIcon: suffixIcon,
        suffix: suffix,
      ),
    );
  }
}
