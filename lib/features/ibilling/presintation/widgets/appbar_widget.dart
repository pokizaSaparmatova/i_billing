import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      title: const Text(
        "",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.darkest,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          "assets/icons/ellipse.svg",
        ),
      ),
      // leadingWidth: 24,
    );
  }
}
