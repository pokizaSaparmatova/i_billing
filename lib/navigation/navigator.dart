import 'package:flutter/cupertino.dart';
import 'package:ibilling/features/ibilling/presintation/pages/contact_page/contact_page.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/new_contact.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/new_invoice.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/new_page.dart';
import '../features/ibilling/presintation/pages/history_page/history_page.dart';
import '../features/ibilling/presintation/pages/profile_page/profile_page.dart';
import '../features/ibilling/presintation/pages/saved_page/saved_page.dart';
import 'nav_item_enum.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final NavItemEnum tabItem;
  final Function() onTapSave;

  const TabNavigator({required this.tabItem, required this.navigatorKey, Key? key, required this.onTapSave}) : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> with AutomaticKeepAliveClientMixin {
  Map<String, WidgetBuilder> _routeBuilders({required BuildContext context, required RouteSettings routeSettings}) {
    switch (widget.tabItem) {
      case NavItemEnum.contracts:
        return {
          TabNavigatorRoutes.root: (context) => const ContactPage(),
        };
      case NavItemEnum.history:
        return {
          TabNavigatorRoutes.root: (context) => const HistoryPage(),
        };
      case NavItemEnum.add:
        return {
          TabNavigatorRoutes.root: (context) =>   NewPage(onTapSave: widget.onTapSave),
        };
      case NavItemEnum.saved:
        return {
          TabNavigatorRoutes.root: (context) => const SavedPage(),
        };
      case NavItemEnum.profile:
        return {
          TabNavigatorRoutes.root: (context) => const ProfilePage(),
        };
      case NavItemEnum.newContact:
        return {
          TabNavigatorRoutes.root: (context) =>  NewContact(onTapSave: widget.onTapSave,),
        };
      case NavItemEnum.newInvoice:
        return {
          TabNavigatorRoutes.root: (context) => const NewInvoice(),
        };
      default:
        return {
          TabNavigatorRoutes.root: (context) => Container(),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        final routeBuilders = _routeBuilders(context: context, routeSettings: routeSettings);
        return CupertinoPageRoute(
          builder: (context) =>
              routeBuilders.containsKey(routeSettings.name) ? routeBuilders[routeSettings.name]!(context) : Container(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}


