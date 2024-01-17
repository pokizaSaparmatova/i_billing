
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/core/utils/enums/status_contact_enum.dart';
import 'package:ibilling/features/ibilling/presintation/pages/contact_page/bloc/contact_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';


class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: Colors.black,
                appBar:
                AppBar(
                  backgroundColor: AppColors.darkest,
                  title: const Text(
                    "Filter",
                    style: TextStyle(color: Colors.white),
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
                                          ? Colors.white
                                          : Color(0xFFA6A6A6),
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
                                          ? Colors.white
                                          : Color(0xFFA6A6A6),
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
                                          ? Colors.white
                                          : Color(0xFFA6A6A6),
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
                                          ? Colors.white
                                          : Color(0xFFA6A6A6),
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
                                          style: TextStyle(
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
                                            return day.isAfter(date
                                                .subtract(Duration(days: 1)));
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
                                          style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 14,
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(
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
                          Spacer(),
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
                                      color: Color(0xFF008E7F).withOpacity(.4),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Center(
                                      child: Text(
                                    textAlign: TextAlign.center,
                                    "Cancel",
                                    style: TextStyle(
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
                                  context.read<ContactBloc>().add(
                                      GetFilterListEvent(
                                            startDate: date.subtract(Duration(days: 1)),
                                            endDate: date2.add(Duration(days: 1)),
                                            enumList: enumList)
                                  );
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 163,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.darkGreen,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: const Center(
                                      child: Text(
                                    textAlign: TextAlign.center,
                                    "Apply filters",
                                    style: TextStyle(
                                      color: Colors.white,
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
                        ])));
          },
        ),
      );
}
