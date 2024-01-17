import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'nav_bar_entity.dart';

class NavItemWidget extends StatelessWidget {
  final int currentIndex;
  final NavBar navBar;
  final bool isSelected;

  const NavItemWidget({
    required this.navBar,
    required this.currentIndex,
    Key? key, required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = isSelected
        ? Color(0xFFF2F2F2)
        : Color(0xFFA6A6A6);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        SvgPicture.asset(
          isSelected ? navBar.selectedIcon : navBar.icon,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          height: 24,
          width: 24,
        ),
        const SizedBox(height: 6),
        Text(
          navBar.title.tr(),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: isSelected
              ?  const TextStyle(
              color: Color(0xFFF2F2F2),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              height: 0,
            )
              : const TextStyle(
            color: Color(0xFFA6A6A6),
            fontSize: 10,
            fontWeight: FontWeight.w500
          ),
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}
