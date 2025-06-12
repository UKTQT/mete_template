import 'package:com_nectrom_metetemplate/core/enums/app_card_type.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardType type;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final Color? selectedColor;
  final double? selectedBorderWidth;
  final Color? selectedBorderColor;
  final Widget? selectedIcon;
  final Alignment? selectedIconAlignment;

  const AppCard({
    Key? key,
    required this.child,
    this.type = AppCardType.elevated,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.margin,
    this.elevation,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.selectedColor,
    this.selectedBorderWidth,
    this.selectedBorderColor,
    this.selectedIcon,
    this.selectedIconAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = _getColors(theme);

    return Stack(
      children: [
        Card(
          color: isSelected ? selectedColor ?? backgroundColor ?? colors.backgroundColor : backgroundColor ?? colors.backgroundColor,
          elevation: elevation ?? _getElevation(),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? selectedBorderColor ?? theme.primaryColor : borderColor ?? colors.borderColor,
              width: isSelected ? selectedBorderWidth ?? 2 : borderWidth ?? _getBorderWidth(),
            ),
          ),
          margin: margin ?? EdgeInsets.zero,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
        if (isSelected && selectedIcon != null)
          Positioned.fill(
            child: Align(
              alignment: selectedIconAlignment ?? Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: selectedIcon!,
              ),
            ),
          ),
      ],
    );
  }

  double _getElevation() {
    switch (type) {
      case AppCardType.elevated:
        return 2;
      case AppCardType.outlined:
      case AppCardType.filled:
        return 0;
    }
  }

  double _getBorderWidth() {
    switch (type) {
      case AppCardType.elevated:
      case AppCardType.filled:
        return 0;
      case AppCardType.outlined:
        return 1;
    }
  }

  _CardColors _getColors(ThemeData theme) {
    switch (type) {
      case AppCardType.elevated:
        return _CardColors(
          backgroundColor: theme.cardColor,
          borderColor: Colors.transparent,
        );
      case AppCardType.outlined:
        return _CardColors(
          backgroundColor: Colors.transparent,
          borderColor: theme.dividerColor,
        );
      case AppCardType.filled:
        return _CardColors(
          backgroundColor: theme.cardColor.withOpacity(0.5),
          borderColor: Colors.transparent,
        );
    }
  }
}

class _CardColors {
  final Color backgroundColor;
  final Color borderColor;

  const _CardColors({
    required this.backgroundColor,
    required this.borderColor,
  });
}
