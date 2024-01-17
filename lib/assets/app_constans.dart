import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ibilling/assets/app_colors.dart';

class AppConstants {
  static const List<String> options = ["O'zbek(Lotin)", "English(USA)"];
  static const List<String> langCode = ["uz", "en"];

  static  getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return AppColors.greenA5;
      case "In process":
        return AppColors.yellow;
      case "Rejected by Payme":
        return AppColors.red;
      case "Rejected by IQ":
        return AppColors.red;
      default:
        return AppColors.black;
    }
  }

  static  Color getContainerColor(String status) {
    switch (status) {
      case "Paid":
        return AppColors.greenA5.withOpacity(.4);
      case "In process":
        return AppColors.yellow.withOpacity(.4);
      case "Rejected by Payme":
        return AppColors.red.withOpacity(.1);
      case "Rejected by IQ":
        return AppColors.red.withOpacity(.1);
      default:
        return Colors.black;
    }
  }
}
