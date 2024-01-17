import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibilling/assets/app_colors.dart';

class DatePickerWidget extends StatefulWidget {

  DatePickerWidget({Key? key}) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatepickerWidgetState();
}
class _DatepickerWidgetState extends State<DatePickerWidget> {
  DateTime date = DateTime.now();
  late String formatttedDate = "${date.day}.${date.month}.${date.year}";
  DateTime date2 = DateTime.now();
  late String formatttedDate2 = "To";
  @override
  Widget build(BuildContext context) {
    return Column(children: [  Row(
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
    ),],);
  }
}
