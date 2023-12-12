import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibilling/core/utils/app_colors.dart';
import 'package:ibilling/features/ibilling/presintation/pages/contact_page/contact_page.dart';
import 'package:ibilling/features/ibilling/presintation/pages/history_page/history_page.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/new_page.dart';
import 'package:ibilling/features/ibilling/presintation/pages/profile_page/profile_page.dart';
import 'package:ibilling/features/ibilling/presintation/pages/saved_page/saved_page.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/create_dialog.dart';

import '../widgets/language_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String name="";
  static const TextStyle optionStyle =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w700);

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            ContactPage(),
            HistoryPage(),
            NewPage(),
            SavedPage(),
            ProfilePage()
          ],
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            backgroundColor: AppColors.darkest,
            unselectedItemColor: Color(0xFFA6A6A6),
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: (int index){
              onTabTapped(index);
              setState(() {
                if(_currentIndex==2){
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return CreateDialog();
                      });
                }
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/contact_unpaid.svg",
                    color:
                        _currentIndex == 0 ? Colors.white : Color(0xFFA6A6A6),
                  ),
                  label: "contacts".tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/history.svg",
                      color: _currentIndex == 1
                          ? Colors.white
                          : Color(0xFFA6A6A6)),
                  label:  "history".tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/new.svg",
                      color: _currentIndex == 2
                          ? Colors.white
                          : Color(0xFFA6A6A6)),
                  label:  "New".tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/saved.svg",
                      color: _currentIndex == 3
                          ? Colors.white
                          : Color(0xFFA6A6A6)),
                  label:  "saved".tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/profile.svg",
                      color: _currentIndex == 4
                          ? Colors.white
                          : Color(0xFFA6A6A6)),
                  label:  "profile".tr()),
            ],
          ),
        ));
  }
}

// class HomeProvider extends ChangeNotifier {
//   var _index = 0;
//
//   void onChangedTab(int index) {
//     _index = index;
//     notifyListeners();
//   }
//
//   int get index => _index;
// }
