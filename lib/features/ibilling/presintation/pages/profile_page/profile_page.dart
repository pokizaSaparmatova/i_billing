import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/language_dialog.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/profil_info_widget.dart';
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
      appBar:  AppBar(
        title: Text(
          LocaleKeys.profile.tr(),
          style: const TextStyle(color: AppColors.white),
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
      ),
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          const ProfilInfo(),
          GestureDetector(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return const LanguageDialog();
                  }).then((value) {
                    setState(() {
                    });
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.dark),
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.locale.languageCode=="en"?"English(USA)":"O'zbek(Lotin)",
                      style: const TextStyle(
                        color: Color(0xFFE6E6E6),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(10), // Image radius
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
}
