import 'package:flutter/material.dart';

enum NotificationStyleType {
  info(
    titleKey: 'notificationManager.infoTitle',
    icon: Icons.info,
    backgroundColor: Color(0xFF2196F3),
  ),

  warning(
    titleKey: 'notificationManager.warningTitle',
    icon: Icons.warning,
    backgroundColor: Color(0xFFFF9800),
  ),

  error(
    titleKey: 'notificationManager.errorTitle',
    icon: Icons.error,
    backgroundColor: Color(0xFFF44336),
  ),

  success(
    titleKey: 'notificationManager.successTitle',
    icon: Icons.check_circle,
    backgroundColor: Color(0xFF4CAF50),
  );

  final String titleKey;
  final IconData icon;
  final Color backgroundColor;

  const NotificationStyleType({
    required this.titleKey,
    required this.icon,
    required this.backgroundColor,
  });
}
