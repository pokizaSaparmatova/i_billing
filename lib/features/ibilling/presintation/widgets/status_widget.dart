import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/core/utils/enums/entity_enum.dart';
import 'package:ibilling/core/utils/enums/status_contact_enum.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/custom_drop_down_option.dart';

class StatusWidget extends StatelessWidget {
  final ValueNotifier<bool> isStatusOpened;
  final ValueChanged<String> onTap;
  final String selectedStatus;
  final String title;

  const StatusWidget({
    Key? key,
    required this.onTap,
    required this.isStatusOpened,
    required this.selectedStatus, required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ValueListenableBuilder(
                  valueListenable: isStatusOpened,
                  builder: (context, value, child) => PortalTarget(
                    visible: isStatusOpened.value,
                    anchor: const Aligned(
                      follower: Alignment.topCenter,
                      target: Alignment.bottomCenter,
                    ),
                    portalFollower: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        StatusContactEnum.values.length,
                        (index) {
                          final status = StatusContactEnum.values[index];
                          return GestureDetector(
                            onTap: () => onTap(status.name),
                            child: CustomDropDownOption(
                              isSelected: status.name == selectedStatus,
                              name: status.name,
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
                            color: selectedStatus.length >= 2
                                ? AppColors.white
                                : const Color(0xFFF1F1F1).withOpacity(.6),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => isStatusOpened.value = !isStatusOpened.value,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  selectedStatus,
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
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
