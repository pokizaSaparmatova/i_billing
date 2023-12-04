import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibilling/core/utils/app_colors.dart';
import 'package:ibilling/generated/locale_keys.g.dart';


class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  DateTime selectedDate = DateTime.now(); // TO tracking date
  int currentDateSelectedIndex = 0; //For Horizontal Date
  List<String> listOfDays = [
    "mon",
    "tue",
    "wed",
    "thu",
    "fri",
   "sat",
    "sun"
  ];
  List<String> listOfMonths = [
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "september",
    "october",
    "november",
    'december'
  ];

  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildBar(context),
      body: Column(
        children: [

          Container(
            padding: EdgeInsets.all(8),
            height: 150,
            color: AppColors.darker,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 30,
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    listOfMonths[selectedDate.month - 1] +
                        ", " +
                        selectedDate.year.toString(),
                    style: const TextStyle(
                      color: Color(0xFFDADADA),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 0.08,
                      letterSpacing: -0.20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 72,
                      width: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF1E1E20),
                                offset: Offset(3, 3),
                                blurRadius: 5)
                          ],
                          color: AppColors.lightGreen),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listOfDays[DateTime.now()
                                        .add(Duration(days: selectedDate.day))
                                        .weekday -
                                    1]
                                .toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            DateTime.now()
                                .add(Duration(days: selectedDate.day))
                                .day
                                .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                              width: 15,
                              child: Divider(
                                thickness: 1,
                                height: 10,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 72,
                      width: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF1E1E20),
                                offset: Offset(3, 3),
                                blurRadius: 5)
                          ],
                          color: currentDateSelectedIndex == selectedDate.day
                              ? Color(0xFF00A795)
                              : Color(0xFF1E1E20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listOfDays[DateTime.now()
                                        .add(Duration(days: selectedDate.day))
                                        .weekday -
                                    1]
                                .toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            DateTime.now()
                                .add(Duration(days: selectedDate.day))
                                .day
                                .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                              width: 15,
                              child: Divider(
                                thickness: 1,
                                height: 10,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 72,
                      width: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF1E1E20),
                                offset: Offset(3, 3),
                                blurRadius: 5)
                          ],
                          color: currentDateSelectedIndex == selectedDate.day
                              ? Color(0xFF00A795)
                              : Color(0xFF1E1E20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listOfDays[DateTime.now()
                                        .add(Duration(days: selectedDate.day))
                                        .weekday -
                                    1]
                                .toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            DateTime.now()
                                .add(Duration(days: selectedDate.day))
                                .day
                                .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                              width: 15,
                              child: Divider(
                                thickness: 1,
                                height: 10,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 72,
                      width: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF1E1E20),
                                offset: Offset(3, 3),
                                blurRadius: 5)
                          ],
                          color: currentDateSelectedIndex == selectedDate.day
                              ? Color(0xFF00A795)
                              : Color(0xFF1E1E20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listOfDays[DateTime.now()
                                        .add(Duration(days: selectedDate.day))
                                        .weekday -
                                    1]
                                .toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            DateTime.now()
                                .add(Duration(days: selectedDate.day))
                                .day
                                .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                              width: 15,
                              child: Divider(
                                thickness: 1,
                                height: 10,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 72,
                      width: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF1E1E20),
                                offset: Offset(3, 3),
                                blurRadius: 5)
                          ],
                          color: currentDateSelectedIndex == selectedDate.day
                              ? Color(0xFF00A795)
                              : Color(0xFF1E1E20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listOfDays[DateTime.now()
                                        .add(Duration(days: selectedDate.day))
                                        .weekday -
                                    1]
                                .toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            DateTime.now()
                                .add(Duration(days: selectedDate.day))
                                .day
                                .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                              width: 15,
                              child: Divider(
                                thickness: 1,
                                height: 10,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 72,
                      width: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF1E1E20),
                                offset: Offset(3, 3),
                                blurRadius: 5)
                          ],
                          color: currentDateSelectedIndex == selectedDate.day
                              ? Color(0xFF00A795)
                              : Color(0xFF1E1E20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listOfDays[DateTime.now()
                                        .add(Duration(days: selectedDate.day))
                                        .weekday -
                                    1]
                                .toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            DateTime.now()
                                .add(Duration(days: selectedDate.day))
                                .day
                                .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    currentDateSelectedIndex == selectedDate.day
                                        ? Colors.white
                                        : Color(0xFFD1D1D1)),
                          ),
                          SizedBox(
                              width: 15,
                              child: Divider(
                                thickness: 1,
                                height: 10,
                              ))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildBar(BuildContext context) {
    return AppBar(
      title: Text(LocaleKeys.contacts.tr(),style: TextStyle(color: Colors.white),),
      backgroundColor: AppColors.darkest,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          "assets/icons/ellipse.svg",
        ),
      ),
      // leadingWidth: 24,
      actions: [
        SvgPicture.asset("assets/icons/filtr.svg"),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          child: VerticalDivider(
            thickness: 2,
            color: Colors.white,
          ),
          height: 18,
        ),
        SizedBox(
          width: 10,
        ),
        SvgPicture.asset("assets/icons/seatch.svg"),
        SizedBox(
          width: 16,
        )
      ],
    );
  }
}
