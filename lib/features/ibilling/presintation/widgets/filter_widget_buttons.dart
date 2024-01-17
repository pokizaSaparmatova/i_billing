import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/core/utils/enums/status_contact_enum.dart';
import 'package:ibilling/features/ibilling/presintation/pages/saved_page/bloc/saved_bloc.dart';

class FilterWidgetButtons extends StatelessWidget {
  final bool isPaid;
  final bool isRejIQ;
  final bool isRejPayme;
  final bool isInProcc;
  final List<String> enumList;
  final DateTime date;
  final DateTime date2;

  const FilterWidgetButtons(
      {Key? key,
      required this.isPaid,
      required this.isRejIQ,
      required this.isRejPayme,
      required this.isInProcc,
      required this.enumList,
      required this.date,
      required this.date2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 163,
                height: 40,
                decoration: BoxDecoration(
                    color: const Color(0xFF008E7F).withOpacity(.4),
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                    child: Text(
                  textAlign: TextAlign.center,
                  "cancel".tr(),
                  style: const TextStyle(
                    color: AppColors.darkGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: -0.17,
                  ),
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (isPaid) {
                  enumList.add(StatusContactEnum.first.name);
                }
                if (isInProcc) {
                  enumList.add(StatusContactEnum.second.name);
                }
                if (isRejIQ) {
                  enumList.add(StatusContactEnum.fourth.name);
                }
                if (isRejPayme) {
                  enumList.add(StatusContactEnum.third.name);
                }
                context.read<SavedBloc>().add(GetFilterSavedListEvent(
                    startDate: date.subtract(const Duration(days: 1)),
                    endDate: date2.add(const Duration(days: 1)),
                    enumList: enumList));
                Navigator.pop(context);
              },
              child: Container(
                width: 163,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.darkGreen,
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                    child: Text(
                  textAlign: TextAlign.center,
                  "applyFilters".tr(),
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: -0.17,
                  ),
                )),
              ),
            ),
          ],
        )
      ],
    );
  }
}
