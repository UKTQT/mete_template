import 'package:com_nectrom_metetemplate/core/utils/app_utils.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final bool isScrollPage;
  final bool isPaddingZero;
  final bool isResizeToAvoidBottomInset;
  final bool canPop;
  final bool isSafeAreaTop;
  final bool isSafeAreaBottom;
  final bool extendBodyBehindAppBar;

  const BaseScaffold({
    super.key,
    this.scaffoldKey,
    this.appBar,
    this.body,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.isScrollPage = false,
    this.isPaddingZero = false,
    this.isResizeToAvoidBottomInset = true,
    this.canPop = true,
    this.isSafeAreaTop = true,
    this.isSafeAreaBottom = true,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 20 && Navigator.of(context).canPop()) {
            Navigator.of(context).maybePop();
          }
        },
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: isResizeToAvoidBottomInset,
          drawerEnableOpenDragGesture: false,
          appBar: appBar,
          bottomNavigationBar: bottomNavigationBar,
          drawer: drawer,
          endDrawer: endDrawer,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          body: SafeArea(
            top: isSafeAreaTop,
            bottom: isSafeAreaBottom,
            child: _buildBody(context),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (body == null) return const SizedBox.shrink();

    final padding = isPaddingZero
        ? EdgeInsets.zero
        : EdgeInsets.symmetric(
            vertical: AppUtils.instance.heightRatio(0.02),
            horizontal: AppUtils.instance.widthRatio(0.06),
          );

    final content = Padding(
      padding: padding,
      child: body!,
    );

    return isScrollPage
        ? SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: content,
          )
        : content;
  }
}
