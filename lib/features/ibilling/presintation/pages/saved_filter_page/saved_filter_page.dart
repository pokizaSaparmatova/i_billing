import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/core/utils/enums/status_contact_enum.dart';
import 'package:ibilling/features/ibilling/presintation/pages/saved_page/bloc/saved_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/filter_widget_buttons.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SavedFilterPage extends StatefulWidget {
  const SavedFilterPage({Key? key}) : super(key: key);

  @override
  State<SavedFilterPage> createState() => _SavedFilterPageState();
}

class _SavedFilterPageState extends State<SavedFilterPage> {
  bool isPaid = false;
  bool isRejIQ = false;
  bool isRejPayme = false;
  bool isInProcc = false;
  List<String> enumList = [];
  DateTime date = DateTime.now();
  late String formatttedDate = "${date.day}.${date.month}.${date.year}";
  DateTime date2 = DateTime.now();
  late String formatttedDate2 = "To";

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: BlocBuilder<SavedBloc, SavedState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: AppColors.black,
                appBar: AppBar(
                  backgroundColor: AppColors.darkest,
                  title: const Text(
                    "Filter",
                    style: TextStyle(color: AppColors.white),
                  ),
                  centerTitle: true,
                  titleSpacing: 0,
                  leading: Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/arrow.svg",
                      ),
                    ),
                  ),
                  // leadingWidth: 24,
                ),
                body: Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 28, bottom: 28),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Status",
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPaid = !isPaid;
                                      });
                                    },
                                    child: isPaid
                                        ? SvgPicture.asset(
                                            "assets/icons/tick_square_paid.svg")
                                        : SvgPicture.asset(
                                            "assets/icons/tick_square.svg"),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    StatusContactEnum.first.name,
                                    style: TextStyle(
                                      color: isPaid
                                          ? AppColors.white
                                          : const Color(0xFFA6A6A6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isRejIQ = !isRejIQ;
                                      });
                                    },
                                    child: isRejIQ
                                        ? SvgPicture.asset(
                                            "assets/icons/tick_square_paid.svg")
                                        : SvgPicture.asset(
                                            "assets/icons/tick_square.svg"),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    StatusContactEnum.fourth.name,
                                    style: TextStyle(
                                      color: isRejIQ
                                          ? AppColors.white
                                          : const Color(0xFFA6A6A6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isInProcc = !isInProcc;
                                      });
                                    },
                                    child: isInProcc
                                        ? SvgPicture.asset(
                                            "assets/icons/tick_square_paid.svg")
                                        : SvgPicture.asset(
                                            "assets/icons/tick_square.svg"),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    StatusContactEnum.second.name,
                                    style: TextStyle(
                                      color: isInProcc
                                          ? AppColors.white
                                          : const Color(0xFFA6A6A6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isRejPayme = !isRejPayme;
                                      });
                                    },
                                    child: isRejPayme
                                        ? SvgPicture.asset(
                                            "assets/icons/tick_square_paid.svg")
                                        : SvgPicture.asset(
                                            "assets/icons/tick_square.svg"),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    StatusContactEnum.third.name,
                                    style: TextStyle(
                                      color: isRejPayme
                                          ? AppColors.white
                                          : const Color(0xFFA6A6A6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 36,
                          ),
                          const Text(
                            'Date',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime.now())
                                      .then((selectedDate) {
                                    if (selectedDate == null) {
                                      return;
                                    } else {
                                      setState(() {
                                        date = selectedDate;
                                        formatttedDate =
                                            "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}";
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  width: 116,
                                  height: 37,
                                  decoration: ShapeDecoration(
                                    color: AppColors.dark,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          formatttedDate,
                                          style: const TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 14,
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/calendar.svg")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                width: 8,
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                      color: Color(0xFFD1D1D1),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await showDatePicker(
                                          context: context,
                                          initialDate: date,
                                          firstDate: date,
                                          selectableDayPredicate:
                                              (DateTime day) {
                                            return day.isAfter(date.subtract(
                                                const Duration(days: 1)));
                                          },
                                          lastDate: DateTime.now())
                                      .then((selectedDate) {
                                    if (selectedDate == null) {
                                      return;
                                    } else {
                                      date2 = selectedDate;
                                      setState(() {
                                        formatttedDate2 =
                                            "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}";
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  width: 116,
                                  height: 37,
                                  decoration: ShapeDecoration(
                                    color: AppColors.dark,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          formatttedDate2,
                                          style: const TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 14,
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/calendar.svg")
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          FilterWidgetButtons(
                              isPaid: isPaid,
                              isRejIQ: isRejIQ,
                              isRejPayme: isRejPayme,
                              isInProcc: isInProcc,
                              enumList: enumList,
                              date: date,
                              date2: date2)
                        ])));
          },
        ),
      );
}
