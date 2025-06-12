import 'package:com_nectrom_metetemplate/core/enums/app_chip_style.dart';
import 'package:com_nectrom_metetemplate/core/enums/app_chip_type.dart';
import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  final String label;
  final Widget? avatar;
  final Widget? deleteIcon;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final AppChipType type;
  final AppChipStyle style;
  final bool isSelected;
  final bool isEnabled;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? disabledColor;
  final Color? labelColor;
  final Color? selectedLabelColor;
  final Color? disabledLabelColor;
  final Color? deleteIconColor;
  final Color? selectedDeleteIconColor;
  final Color? disabledDeleteIconColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final TextStyle? labelStyle;
  final double? avatarSize;
  final double? deleteIconSize;
  final bool showCheckmark;
  final bool showDeleteIcon;
  final bool isDense;
  final bool autofocus;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final MouseCursor? mouseCursor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final Clip clipBehavior;

  const AppChip({
    super.key,
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.onTap,
    this.onDeleted,
    this.type = AppChipType.action,
    this.style = AppChipStyle.normal,
    this.isSelected = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.selectedColor,
    this.disabledColor,
    this.labelColor,
    this.selectedLabelColor,
    this.disabledLabelColor,
    this.deleteIconColor,
    this.selectedDeleteIconColor,
    this.disabledDeleteIconColor,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.margin,
    this.border,
    this.boxShadow,
    this.labelStyle,
    this.avatarSize,
    this.deleteIconSize,
    this.showCheckmark = false,
    this.showDeleteIcon = false,
    this.isDense = false,
    this.autofocus = false,
    this.enableFeedback = true,
    this.focusNode,
    this.mouseCursor,
    this.materialTapTargetSize,
    this.visualDensity,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultColors = (
      backgroundColor: backgroundColor ?? theme.cardColor,
      selectedColor: selectedColor ?? theme.primaryColor,
      disabledColor: disabledColor ?? theme.disabledColor,
      labelColor: labelColor ?? theme.textTheme.bodyLarge?.color ?? Colors.black,
      selectedLabelColor: selectedLabelColor ?? Colors.white,
      disabledLabelColor: disabledLabelColor ?? theme.disabledColor,
      deleteIconColor: deleteIconColor ?? theme.iconTheme.color,
      selectedDeleteIconColor: selectedDeleteIconColor ?? Colors.white,
      disabledDeleteIconColor: disabledDeleteIconColor ?? theme.disabledColor,
    );

    final effectiveLabelStyle = labelStyle?.copyWith(
          color: isEnabled
              ? isSelected
                  ? defaultColors.selectedLabelColor
                  : defaultColors.labelColor
              : defaultColors.disabledLabelColor,
        ) ??
        TextStyle(
          color: isEnabled
              ? isSelected
                  ? defaultColors.selectedLabelColor
                  : defaultColors.labelColor
              : defaultColors.disabledLabelColor,
        );

    final chip = switch (type) {
      AppChipType.action => ActionChip(
          label: Text(label, style: effectiveLabelStyle),
          avatar: avatar,
          onPressed: isEnabled ? onTap : null,
          backgroundColor: backgroundColor,
          disabledColor: disabledColor,
          elevation: elevation ?? _getElevation(),
          pressElevation: elevation ?? _getElevation(),
          padding: padding,
          visualDensity: visualDensity,
          materialTapTargetSize: materialTapTargetSize,
          clipBehavior: clipBehavior,
          autofocus: autofocus,
          focusNode: focusNode,
          mouseCursor: mouseCursor,
        ),
      AppChipType.filter => FilterChip(
          label: Text(label, style: effectiveLabelStyle),
          avatar: avatar,
          selected: isSelected,
          onSelected: isEnabled ? (_) => onTap?.call() : null,
          backgroundColor: backgroundColor,
          selectedColor: selectedColor,
          disabledColor: disabledColor,
          elevation: elevation ?? _getElevation(),
          pressElevation: elevation ?? _getElevation(),
          padding: padding,
          visualDensity: visualDensity,
          materialTapTargetSize: materialTapTargetSize,
          clipBehavior: clipBehavior,
          autofocus: autofocus,
          focusNode: focusNode,
          mouseCursor: mouseCursor,
          showCheckmark: showCheckmark,
        ),
      AppChipType.input => InputChip(
          label: Text(label, style: effectiveLabelStyle),
          avatar: avatar,
          selected: isSelected,
          onSelected: isEnabled ? (_) => onTap?.call() : null,
          onDeleted: isEnabled ? onDeleted : null,
          deleteIcon: showDeleteIcon ? deleteIcon : null,
          deleteIconColor: isEnabled
              ? isSelected
                  ? defaultColors.selectedDeleteIconColor
                  : defaultColors.deleteIconColor
              : defaultColors.disabledDeleteIconColor,
          backgroundColor: backgroundColor,
          selectedColor: selectedColor,
          disabledColor: disabledColor,
          elevation: elevation ?? _getElevation(),
          pressElevation: elevation ?? _getElevation(),
          padding: padding,
          visualDensity: visualDensity,
          materialTapTargetSize: materialTapTargetSize,
          clipBehavior: clipBehavior,
          autofocus: autofocus,
          focusNode: focusNode,
          mouseCursor: mouseCursor,
          isEnabled: isEnabled,
        ),
      AppChipType.choice => ChoiceChip(
          label: Text(label, style: effectiveLabelStyle),
          avatar: avatar,
          selected: isSelected,
          onSelected: isEnabled ? (_) => onTap?.call() : null,
          backgroundColor: backgroundColor,
          selectedColor: selectedColor,
          disabledColor: disabledColor,
          elevation: elevation ?? _getElevation(),
          pressElevation: elevation ?? _getElevation(),
          padding: padding,
          visualDensity: visualDensity,
          materialTapTargetSize: materialTapTargetSize,
          clipBehavior: clipBehavior,
          autofocus: autofocus,
          focusNode: focusNode,
          mouseCursor: mouseCursor,
        ),
    };

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
        boxShadow: boxShadow,
      ),
      child: chip,
    );
  }

  double _getElevation() {
    return switch (style) {
      AppChipStyle.normal => 0,
      AppChipStyle.outlined => 0,
      AppChipStyle.filled => 2,
    };
  }
}
