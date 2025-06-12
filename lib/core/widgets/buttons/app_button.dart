import 'package:com_nectrom_metetemplate/core/enums/app_button_size.dart';
import 'package:com_nectrom_metetemplate/core/enums/app_button_type.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final bool isFullWidth;
  final IconData? icon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? child;

  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = false,
    this.icon,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = _getColors(theme);
    final dimensions = _getDimensions();

    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? dimensions.height,
      child: ElevatedButton(
        onPressed: (isDisabled || isLoading) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colors.backgroundColor,
          foregroundColor: textColor ?? colors.textColor,
          padding: padding ?? dimensions.padding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            side: BorderSide(
              color: borderColor ?? colors.borderColor,
              width: borderWidth ?? 1,
            ),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: dimensions.iconSize),
                    const SizedBox(width: 8),
                  ],
                  if (child != null)
                    child!
                  else
                    Text(
                      text,
                      style: textStyle ??
                          theme.textTheme.labelLarge?.copyWith(
                            color: textColor ?? colors.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                ],
              ),
      ),
    );
  }

  _ButtonColors _getColors(ThemeData theme) {
    switch (type) {
      case AppButtonType.primary:
        return _ButtonColors(
          backgroundColor: theme.primaryColor,
          textColor: Colors.white,
          borderColor: theme.primaryColor,
        );
      case AppButtonType.secondary:
        return _ButtonColors(
          backgroundColor: Colors.grey.shade700,
          textColor: Colors.white,
          borderColor: Colors.grey.shade700,
        );
      case AppButtonType.success:
        return const _ButtonColors(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          borderColor: Colors.green,
        );
      case AppButtonType.danger:
        return const _ButtonColors(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          borderColor: Colors.red,
        );
      case AppButtonType.warning:
        return const _ButtonColors(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          borderColor: Colors.orange,
        );
      case AppButtonType.info:
        return const _ButtonColors(
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          borderColor: Colors.blue,
        );
      case AppButtonType.light:
        return _ButtonColors(
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.black,
          borderColor: Colors.grey.shade300,
        );
      case AppButtonType.dark:
        return const _ButtonColors(
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          borderColor: Colors.black87,
        );
      case AppButtonType.outline:
        return _ButtonColors(
          backgroundColor: Colors.transparent,
          textColor: theme.primaryColor,
          borderColor: theme.primaryColor,
        );
    }
  }

  _ButtonDimensions _getDimensions() {
    switch (size) {
      case AppButtonSize.small:
        return const _ButtonDimensions(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          iconSize: 16,
        );
      case AppButtonSize.medium:
        return const _ButtonDimensions(
          height: 44,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          iconSize: 20,
        );
      case AppButtonSize.large:
        return const _ButtonDimensions(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          iconSize: 24,
        );
    }
  }
}

class _ButtonColors {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const _ButtonColors({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });
}

class _ButtonDimensions {
  final double height;
  final EdgeInsets padding;
  final double iconSize;

  const _ButtonDimensions({
    required this.height,
    required this.padding,
    required this.iconSize,
  });
}
