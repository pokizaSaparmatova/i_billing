import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../assets/app_colors.dart';
import '../features/ibilling/presintation/widgets/create_dialog.dart';
import 'nav_bar.dart';
import 'nav_bar_entity.dart';
import 'nav_item_enum.dart';
import 'navigator.dart';


class HomeScreen extends StatefulWidget {
  final int index;

  const HomeScreen({Key? key, this.index = 0}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _controller;

  final Map<NavItemEnum, GlobalKey<NavigatorState>> _navigatorKeys = {
    NavItemEnum.contracts: GlobalKey<NavigatorState>(),
    NavItemEnum.history: GlobalKey<NavigatorState>(),
    NavItemEnum.add: GlobalKey<NavigatorState>(),
    NavItemEnum.saved: GlobalKey<NavigatorState>(),
    NavItemEnum.profile: GlobalKey<NavigatorState>(),
    NavItemEnum.newContact: GlobalKey<NavigatorState>(),
    NavItemEnum.newInvoice: GlobalKey<NavigatorState>(),
  };

  List<NavBar> labels = [];
  int _currentIndex = 0;
  DateTime? pauseTime;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _controller = TabController(length: 7, vsync: this);
    _controller.addListener(onTabChange);

    if (widget.index != 0) {
      changePage(widget.index);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void onTabChange() {

    print("onTab1:${_controller.index}");
    setState(() => _currentIndex = _controller.index);
    print("onTab:${_currentIndex}");

  }

  Widget _buildPageNavigator(NavItemEnum tabItem) =>
      TabNavigator(navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
        onTapSave: () {
        changePage(0);
        },);

  void changePage(int index) {

    if (index == 2) {

    return showCustom();

    }else{
      setState(() => _currentIndex = index);
      _controller.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    labels = [
      NavBar(
          title:"contacts".tr(),
          id: 0,
          icon:  "assets/icons/contact_unpaid.svg",
          selectedIcon: 'assets/icons/sel_contract.svg'),
      NavBar(
          title: "history".tr(),
          id: 1,
          icon: "assets/icons/history.svg",
          selectedIcon: 'assets/icons/sel_history.svg'),
      NavBar(
          title:  "New".tr(),
          id: 2,
          icon:"assets/icons/new.svg",
          selectedIcon: 'assets/icons/sel_add.svg'),
      NavBar(
          title:  "saved".tr(),
          id: 3,
          icon: "assets/icons/saved.svg",
          selectedIcon: 'assets/icons/sel_saved.svg'),
      NavBar(
          title: "profile".tr(),
          id: 4,
          icon: "assets/icons/profile.svg",
          selectedIcon: 'assets/icons/sel_profile.svg'),
      NavBar(
          title: "newContract".tr(),
          id: 5,
          icon: "assets/icons/profile.svg",
          selectedIcon: 'assets/icons/sel_profile.svg'),
      NavBar(
          title: "newInvoice".tr(),
          id: 6,
          icon: "assets/icons/profile.svg",
          selectedIcon: 'assets/icons/sel_profile.svg'),
    ];

    return HomeTabControllerProvider(
      controller: _controller,
      child: WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[NavItemEnum.values[_currentIndex]]!.currentState!.maybePop();
          if (isFirstRouteInCurrentTab) {
            if(_currentIndex==2 && _navigatorKeys[NavItemEnum.add]!.currentState!.canPop()){
              _navigatorKeys[NavItemEnum.add]!.currentState!.pop();
              return true;
            }
            if (NavItemEnum.values[_currentIndex] != NavItemEnum.contracts) {
              changePage(0);
              return false;
            }
          }
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: TabBarView(
            dragStartBehavior: DragStartBehavior.down,
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildPageNavigator(NavItemEnum.contracts),
              _buildPageNavigator(NavItemEnum.history),
              _buildPageNavigator(NavItemEnum.add),
              _buildPageNavigator(NavItemEnum.saved),
              _buildPageNavigator(NavItemEnum.profile),
              _buildPageNavigator(NavItemEnum.newContact),
              _buildPageNavigator(NavItemEnum.newInvoice),
            ],
          ),
          bottomNavigationBar: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 8, top: 8),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 28,
                  spreadRadius: 0,
                  offset: Offset(4, 4),
                ),
              ],
              color:  AppColors.darkest,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
              5,
                (index) => Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      print("label:${labels[index].id}");
                      changePage(index);
                      _navigatorKeys[NavItemEnum.values[_currentIndex]]!
                          .currentState
                          ?.popUntil((route) => route.isFirst);
                    },
                    child: NavItemWidget(
                      navBar: labels[index],
                      currentIndex: _currentIndex, isSelected: isSelected(labels[index].id),
                    ),
                  ),
                ),
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
        ),
      ),
    );
  }
  bool isSelected(int labelId){
    if((_currentIndex==5|| _currentIndex==6)&& labelId==2){
      return true;
    }
    return labelId==_currentIndex;
  }

  void showCustom() async {
    await showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {


    return CreateDialog(onTabChanged: (int a ) {
      print("ontTab3:${_currentIndex}");
      setState(() => _currentIndex = a);
      _controller.animateTo(a);
      print("ontTab4:${_currentIndex}");
    },);


        },
        transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
            child: FadeTransition(
              opacity: anim1,
              child: child,
            ))).then((value) {print("KKKKK:${value}");
              HomeTabControllerProvider.of(context).controller.animateTo(0);
    });
  }
}

class HomeTabControllerProvider extends InheritedWidget {
  final TabController controller;

  const HomeTabControllerProvider({
    Key? key,
    required Widget child,
    required this.controller,
  }) : super(key: key, child: child);

  static HomeTabControllerProvider of(BuildContext context) {
    final HomeTabControllerProvider? result = context.dependOnInheritedWidgetOfExactType<HomeTabControllerProvider>();
    assert(result != null, 'No HomeTabControllerProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HomeTabControllerProvider oldWidget) => false;
}

class CreateDialogWidget extends StatefulWidget {
  const CreateDialogWidget({required this.contractClicked, required this.invoiceClicked, super.key});

  final Function() contractClicked;
  final Function() invoiceClicked;

  @override
  State<CreateDialogWidget> createState() => _CreateDialogWidgetState();
}

class _CreateDialogWidgetState extends State<CreateDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      padding: EdgeInsets.only(top: 16, bottom: 24, left: 20, right: 20),
      decoration: ShapeDecoration(
        color: Color(0xFF2A2A2D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Что вы хотите создать?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.contractClicked.call();
            },
            child: Container(
              margin: EdgeInsets.only(top: 28, bottom: 12),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: ShapeDecoration(
                color: Color(0xFF4D4D4D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    height: 26,
                    width: 26,
                    child: Image.asset('assets/images/ic_contract.png'),
                  ),
                  Text(
                    'Contract',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.invoiceClicked.call();
            },
            child: Container(
              margin: EdgeInsets.only(top: 0, bottom: 0),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: ShapeDecoration(
                color: Color(0xFF4D4D4D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    height: 26,
                    width: 26,
                    child: Image.asset('assets/images/ic_invoice.png'),
                  ),
                  Text(
                    'Invoice',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
