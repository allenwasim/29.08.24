import 'package:flutter/material.dart';
import 'package:t_store/constants/colors.dart';

class TShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: TColors.darkGrey.withOpacity(0.01),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 20));

  static final horizondalProductShadow = BoxShadow(
      color: TColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 20));
}
