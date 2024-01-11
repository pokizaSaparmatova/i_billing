import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/features/ibilling/presintation/pages/saved_page/bloc/saved_bloc.dart';
import '../../../../../assets/app_colors.dart';
import '../../../../../dependency_injection.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../widgets/contact_item_widget.dart';
import '../contact_page/bloc/contact_bloc.dart';
import '../filter_page/filter_page.dart';
import '../new_page/bloc/add_page_bloc.dart';
import '../saved_filter_page/saved_filter_page.dart';
import '../saved_search_page/saved_search_page.dart';
import '../search_page/search_page.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  Color getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return Color(0xFF49B7A5);
      case "In process":
        return Color(0xFFFDAB2A);
      case "Rejected by Payme":
        return Color(0xFFFF426D);
      case "Rejected by IQ":
        return Color(0xFFFF426D);
      default:
        return Colors.black;
    }
  }

  String appBarTitle = '';

  Color getContainerColor(String status) {
    switch (status) {
      case "Paid":
        return Color(0xFF49B7A5).withOpacity(.4);
      case "In process":
        return Color(0xFFFDAB2A).withOpacity(.4);
      case "Rejected by Payme":
        return Color(0xFFFF426D).withOpacity(.4);
      case "Rejected by IQ":
        return Color(0xFFFF426D).withOpacity(.4);
      default:
        return Colors.black;
    }
  }

  // Method to update the title
  void updateAppBarTitle() {
    setState(() {
      appBarTitle = LocaleKeys.saved.tr();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Listen for language changes and update the title
    if (EasyLocalization.of(context)?.locale != null) {
      updateAppBarTitle();
    }
  }

  Future<void> _refresh() async {
    return context.read<SavedBloc>().add(GetSavedListEvent());
  }

  @override
  void initState() {
    context.read<SavedBloc>().add(GetSavedListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedBloc, SavedState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              appBarTitle,
              style: const TextStyle(color: Colors.white),
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
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedFilterPage()),
                    );
                  },
                  child: SvgPicture.asset("assets/icons/filtr.svg")),
              const SizedBox(
                width: 10,
              ),
              const SizedBox(
                height: 18,
                child: VerticalDivider(
                  thickness: 2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {
                    // showSearch(context: context, delegate: CustomSearchDelegate());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedSearchPage()),
                    );
                  },
                  child: SvgPicture.asset("assets/icons/seatch.svg")),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          body: RefreshIndicator.adaptive(
            color: AppColors.darkGreen,
            onRefresh: _refresh,
            child: state.pageStatuses == PageStatuses.loading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.savedList.length,
                            itemBuilder: (context, index) {
                              return ContractItem(
                                number: state.savedList[index].number,
                                status: state.savedList[index].status,
                                textColor: getStatusColor(
                                    state.savedList[index].status),
                                containerColor: getContainerColor(
                                    state.savedList[index].status),
                                name: state.savedList[index].name,
                                date:
                                    "${state.savedList[index].date.day}.${state.savedList[index].date.month}.${state.savedList[index].date.year}",
                              );
                            }),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
