import 'package:flutter/material.dart';
import 'package:hng_stage_2/utils/extension.dart';

import '../theme/color.dart';

abstract class BaseNavigator {
  BaseNavigator._();
  static final key = GlobalKey<NavigatorState>();
  static BuildContext get currentContext => key.currentState!.context;

  static bool get canPop => key.currentState!.canPop();

  static Future pushNamed(String route, {arguments}) {
    return key.currentState!.pushNamed(route, arguments: arguments);
  }

  static Future pushNamedReplacement(String route, {arguments}) {
    return key.currentState!.pushReplacementNamed(route, arguments: arguments);
  }

  static void pushReplacement({
    required Widget child,
    argument,
    String? name,
  }) {
    Navigator.pushReplacement(
      key.currentState!.context,
      MaterialPageRoute(
        builder: (_) => child,
        settings: RouteSettings(
          name: name,
          arguments: argument,
        ),
      ),
    );
  }

  static Future pushNamedAndClear(String route, {arguments}) {
    return key.currentState!.pushNamedAndRemoveUntil(
      route,
      (_) => false,
      arguments: arguments,
    );
  }

  static void pop([result]) {
    if (canPop) return key.currentState!.pop(result);
  }

  static void showSnackBar(
    BuildContext ctx, {
    String? message,
    bool isFail = true,
    bool expanded = false,
    Color? color,
  }) async {
    OverlayState? overlayState = Overlay.of(ctx);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).size.height * 0.05,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: expanded ? 10 : 120.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              child: Container(
                alignment: Alignment.center,
                color: color ?? Colors.black.withOpacity(.5),
                padding: const EdgeInsets.all(5),
                child: Text(
                  message ?? "",
                  style: currentContext.body1.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });

    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 3)).whenComplete(() => overlayEntry.remove());
  }

  static void showToast(
    BuildContext ctx, {
    String? message,
    bool isFail = true,
  }) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          message ?? "",
          style: ctx.body1.copyWith(color: Colors.white),
        ),
        elevation: 2,
        behavior: SnackBarBehavior.floating,
        backgroundColor: isFail ? AppColor.errorColor : AppColor.textLightModeFF2E,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static dynamic bottomSheet({
    required Widget child,
    required BuildContext context,
    bool? isdismissable,
    bool? isScrollControlled,
    bool? enableDrag,
    Object? arguments,
    String? routeName,
    // required AnimationController controller,
  }) async {
    var i = await showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled ?? true,
      isDismissible: isdismissable ?? true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      enableDrag: enableDrag ?? true,
      // transitionAnimationController: controller,
      routeSettings: RouteSettings(
        name: routeName,
        arguments: arguments,
      ),
      builder: (context) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: BottomSheetWidget(
            child: child,
          ),
        );
      },
    );
    return i;
  }
}

class BottomSheetWidget extends StatelessWidget {
  final Widget child;
  const BottomSheetWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: AppColor.backgroundLightMode2,
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            8.heightSizing,
            Center(
              child: Container(
                height: 4,
                width: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFB9BCC8),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
