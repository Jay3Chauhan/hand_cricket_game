import 'package:flutter/material.dart';

class ResponsiveUtil {
  ResponsiveUtil._();

  /// Returns true if the screen width is less than 600dp
  static bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  /// Gets a responsive value based on screen size
  static double getResponsiveValue({
    required BuildContext context,
    required double defaultValue,
    double? mobileValue,
  }) {
    if (mobileValue != null && isMobileScreen(context)) {
      return mobileValue;
    }
    return defaultValue;
  }

  /// Gets responsive padding based on screen size
  static EdgeInsets getResponsivePadding({
    required BuildContext context,
    required EdgeInsets defaultPadding,
    EdgeInsets? mobilePadding,
  }) {
    if (mobilePadding != null && isMobileScreen(context)) {
      return mobilePadding;
    }
    return defaultPadding;
  }
}
