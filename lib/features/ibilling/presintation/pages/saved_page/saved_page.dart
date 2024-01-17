import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/assets/app_constans.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/bloc/add_page_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/pages/saved_filter_page/saved_filter_page.dart';
import 'package:ibilling/features/ibilling/presintation/pages/saved_page/bloc/saved_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/pages/saved_search_page/saved_search_page.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/contact_item_widget.dart';
import 'package:ibilling/generated/locale_keys.g.dart';


class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  String appBarTitle = '';

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
          backgroundColor:AppColors.black,
          appBar: AppBar(
            title: Text(
              appBarTitle,
              style: const TextStyle(color:AppColors.white),
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
                          builder: (context) => const SavedFilterPage()),
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
                  color: AppColors.white,
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
                          builder: (context) => const SavedSearchPage()),
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
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
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
                                textColor: AppConstants.getContainerColor(
                                    state.savedList[index].status),
                                containerColor: AppConstants.getContainerColor(
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
