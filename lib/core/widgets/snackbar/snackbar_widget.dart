import 'package:flutter/material.dart';

SnackBar snackBarWidget({
  required BuildContext context,
  required Icon icon,
  required String title,
  required String text,
  required Color bgColor,
  int? maxLines,
  Duration? duration,
  bool isDismissible = true,
  SnackBarAction? action,
  SnackBarBehavior? behavior,
  void Function()? onTap,
}) {
  final theme = Theme.of(context);

  return SnackBar(
    content: GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon ve Başlık
          Row(
            children: [
              icon,
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Açıklama metni
          Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
    duration: duration ?? const Duration(seconds: 3),
    backgroundColor: bgColor,
    dismissDirection: isDismissible ? DismissDirection.down : DismissDirection.none,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    elevation: 2.0,
    behavior: behavior ?? SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    action: action,
  );
}
