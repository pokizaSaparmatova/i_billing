import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/core/utils/app_colors.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/language_dialog.dart';
import 'package:ibilling/generated/locale_keys.g.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: buildBar(context),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: AppColors.dark),
            padding: EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/account_circle.svg"),
                    SizedBox(
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
                const Row(
                  children: [
                    Text(
                      "Date of birth:",
                      style: TextStyle(
                        color: Color(0xFFE6E6E6),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('08.03.1997',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                const Row(
                  children: [
                    Text(
                      "Phone number:",
                      style: TextStyle(
                        color: Color(0xFFE6E6E6),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('+998 93 600 20 90',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        ))
                  ],
                ),
                SizedBox(
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
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return LanguageDialog();
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.dark),
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.all(16),
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.locale.languageCode=="en"?"English(USA)":"O'zbek(Lotin)",
                      style: TextStyle(
                        color: Color(0xFFE6E6E6),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(10), // Image radius
                        child:context.locale.languageCode=="en"? SvgPicture.asset('assets/icons/eng_lang.svg',
                            fit: BoxFit.cover):SvgPicture.asset('assets/icons/uzb.svg',
                            fit: BoxFit.cover),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildBar(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.profile.tr(),
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.darkest,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          "assets/icons/ellipse.svg",
        ),
      ),
      // leadingWidth: 24,
    );
  }
}
