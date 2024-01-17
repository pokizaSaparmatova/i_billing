import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibilling/assets/app_colors.dart';

class CustomDropDownOption extends StatelessWidget {
  final bool isSelected;
  final String name;
  const CustomDropDownOption({Key? key, required this.isSelected, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.dark,
      padding: const EdgeInsets.symmetric(
          horizontal: 24, vertical: 15),
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFFF1F1F1),
              fontSize: 14,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            "assets/icons/radio.svg",
            colorFilter: ColorFilter.mode(
                isSelected
                    ? AppColors.lightGreen
                    : AppColors.grey,
                BlendMode.srcIn,),
          ),
        ],
      ),
    );
  }
}
