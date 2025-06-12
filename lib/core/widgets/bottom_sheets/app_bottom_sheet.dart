import 'package:com_nectrom_metetemplate/core/enums/app_bottom_sheet_type.dart';
import 'package:flutter/material.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? leading;
  final Widget? trailing;
  final bool showCloseButton;
  final bool showHeader;
  final bool showDragHandle;
  final VoidCallback? onClose;

  const AppBottomSheet({
    Key? key,
    required this.child,
    this.title,
    this.leading,
    this.trailing,
    this.showCloseButton = true,
    this.showHeader = true,
    this.showDragHandle = true,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.dialogBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDragHandle)
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          if (showHeader) _buildHeader(context),
          Flexible(child: child),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title ?? '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],
          if (showCloseButton) ...[
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                onClose?.call();
                Navigator.of(context).maybePop();
              },
            ),
          ],
        ],
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    AppBottomSheetType type = AppBottomSheetType.modal,
    String? title,
    Widget? leading,
    Widget? trailing,
    bool showCloseButton = true,
    bool showHeader = true,
    bool showDragHandle = true,
    VoidCallback? onClose,
    bool isDismissible = true,
    bool enableDrag = true,
    double initialSize = 0.5,
    double minSize = 0.25,
    double maxSize = 1.0,
  }) {
    final sheet = AppBottomSheet(
      child: child,
      title: title,
      leading: leading,
      trailing: trailing,
      showCloseButton: showCloseButton,
      showHeader: showHeader,
      showDragHandle: showDragHandle,
      onClose: onClose,
    );

    if (type == AppBottomSheetType.draggable) {
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: initialSize,
            minChildSize: minSize,
            maxChildSize: maxSize,
            expand: false,
            builder: (_, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: sheet,
              );
            },
          );
        },
      );
    }

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (context) => sheet,
    );
  }
}
