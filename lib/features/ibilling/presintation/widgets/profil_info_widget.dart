import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibilling/assets/app_colors.dart';

class ProfilInfo extends StatelessWidget {
  const ProfilInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.dark),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      width: double.infinity,

      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/account_circle.svg"),
              const SizedBox(
                width: 10,
              ),
              const Column(
                children: [
                  Text(
                    "Akbaraliyeva Pokizaxon",
                    style: TextStyle(
                        color: AppColors.lightGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text('Graphic designer • IQ Education',
                      style: TextStyle(
                        color: Color(0xFFE7E7E7),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            children: [
              Text(
                "dateOfBirth".tr(),
                style: const TextStyle(
                  color: Color(0xFFE6E6E6),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('08.03.1997',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                  ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "phoneNumber".tr(),
                style: const TextStyle(
                  color: Color(0xFFE6E6E6),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('+998 93 600 20 90',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                  ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Row(
            children: [
              Text(
                "E-mail",
                style: TextStyle(
                  color: Color(0xFFE6E6E6),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text('saparmatovap@gmail.com',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
