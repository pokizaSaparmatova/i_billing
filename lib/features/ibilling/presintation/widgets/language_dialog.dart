import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/features/ibilling/presintation/pages/profile_page/bloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../dependency_injection.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({Key? key}) : super(key: key);

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

List<String> options = ["O'zbek(Lotin)", "English(USA)"];
List<String> langCode=["uz","en"];

class _LanguageDialogState extends State<LanguageDialog> {
  String selectedLanguage = options[0];
 String lang="en";
 String applyLang="";

  // Future<void> loadSelectedLanguage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     selectedLanguage = prefs.getString('selectedLanguage') ?? options[0];
  //   });
  // }
  //
  // Future<void> saveSelectedLanguage(String languageCode) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('selectedLanguage', languageCode);
  // }

  @override
  void initState() {
    print("loaddddddd");
    context.read<ProfileBloc>().add(LoadLanguage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            backgroundColor: AppColors.dark,
            insetPadding: const EdgeInsets.only(left: 24, right: 24),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              width: double.infinity,
              height: MediaQuery.of(context).size.height /3 ,
              child: Column(
                children: [
                  Text(
                    "choose_language".tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(12),
                                // Image radius
                                child: SvgPicture.asset(
                                    'assets/icons/eng_lang.svg',
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            options[1].toString(),
                            style: const TextStyle(
                              color: Color(0xFFE7E7E7),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.17,
                            ),
                          )
                        ],
                      ),
                      Radio(
                          value: langCode[1],
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.lightGreen),
                          groupValue: state.selectedlanguge,
                          onChanged: (newOptions) {
                            context
                                .read<ProfileBloc>()
                                .add(SelectedLanguage(newOptions!));
                           applyLang=langCode[1];
                            // context.read<ProfileBloc>().add(ChangeOptions(newOptions!));
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(12),
                                // Image radius
                                child: SvgPicture.asset('assets/icons/uzb.svg',
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            options[0].toString(),
                            style: const TextStyle(
                              color: Color(0xFFE7E7E7),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.17,
                            ),
                          )
                        ],
                      ),
                      Radio(

                        value: langCode[0],
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.lightGreen),
                          groupValue: state.selectedlanguge,
                          //state.selectedLanguage,
                          onChanged: (newOptions) {
                            context
                                .read<ProfileBloc>()
                                .add(SelectedLanguage(newOptions!));
                            applyLang=langCode[0];

                            // context.read<ProfileBloc>().add(ChangeOptions(newOptions!));
                          })
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.lightGreen),
                          width: 140,
                          height: 38,
                          child: Center(
                            child: Text(
                              "cancel".tr(),
                              style: const TextStyle(
                                color: Color(0xFFFCFCFC),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.17,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<ProfileBloc>()
                              .add(ChangeOptions(context, applyLang));
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.lightGreen),
                          width: 140,
                          height: 38,
                          child: Center(
                            child: Text(
                              "done".tr(),
                              style: const TextStyle(
                                color: Color(0xFFFCFCFC),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.17,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
      },
    );

  }
}
