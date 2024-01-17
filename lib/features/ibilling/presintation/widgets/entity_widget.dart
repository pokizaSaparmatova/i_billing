import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/core/utils/enums/entity_enum.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/custom_drop_down_option.dart';

class EntityWidget extends StatelessWidget {
  final ValueNotifier<bool> isMenuOpen;
  final ValueChanged<String> onTap;
  final String selectedText;
  final String title;
  // final Widget child;

  const EntityWidget({
    Key? key,
    required this.isMenuOpen,
    required this.selectedText,
    required this.onTap,
    required this.title,
    // required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFFF1F1F1).withOpacity(.6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.17,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        ValueListenableBuilder(
          valueListenable: isMenuOpen,
          builder: (context, value, child) => PortalTarget(
            visible: isMenuOpen.value,
            anchor: const Aligned(
              follower: Alignment.topCenter,
              target: Alignment.bottomCenter,
            ),
            portalFollower:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                Entities.values.length,
                (index) {
                  final entity = Entities.values[index];
                  return GestureDetector(
                    onTap: () => onTap(entity.name),
                    child: CustomDropDownOption(
                      isSelected: entity.name == selectedText,
                      name: entity.name,
                    ),
                  );
                },
              ),
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: selectedText.length >= 2
                        ? AppColors.white
                        : const Color(0xFFF1F1F1).withOpacity(.6),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => isMenuOpen.value = !isMenuOpen.value,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          selectedText,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                            "assets/icons/arrow_circle.svg",
                            width: 18,
                            height: 18)
                      ],
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }
}
