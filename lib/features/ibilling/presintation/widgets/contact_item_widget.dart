import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibilling/assets/app_colors.dart';

class ContractItem extends StatelessWidget {
  final String number;
  final String status;
  final Color textColor;
  final Color containerColor;
  final String name;
  final String date;

  ContractItem(
      {Key? key,
      required this.number,
      required this.status,
      required this.textColor,
      required this.containerColor,
      required this.name,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 16, bottom: 16),
        margin: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: AppColors.dark),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/contact.svg"),
                    Text(
                      '''  №$number''',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Spacer(),
                Container(
                    height: 21,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: ShapeDecoration(
                      color: containerColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 0.12,
                        ),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Fish: ${name}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text("Amount: 1,250,000 UZS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(
              height: 4,
            ),
            Text("Last invoice: ${number}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text("Number of invoice: 8",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                Spacer(),
                Text(date,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ],
        ),
      );

  }
}
