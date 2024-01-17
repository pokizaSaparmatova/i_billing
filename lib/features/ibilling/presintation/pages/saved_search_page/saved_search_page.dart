import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/assets/app_constans.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/bloc/add_page_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/pages/saved_page/bloc/saved_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/contact_item_widget.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';


class SavedSearchPage extends StatefulWidget {
  const SavedSearchPage({Key? key}) : super(key: key);

  @override
  State<SavedSearchPage> createState() => _SavedSearchPageState();
}

class _SavedSearchPageState extends State<SavedSearchPage> {
  final TextEditingController _searchQuery = TextEditingController();
  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: BlocBuilder<SavedBloc, SavedState>(
          builder: (context, state) {
            if (state.pageStatuses == PageStatuses.fail) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
                duration: const Duration(seconds: 3),
              ));
              if (state.savedList.isEmpty) {}
            }
            return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: AppColors.darkest,
                  title: TextField(
                    onChanged: (value) {
                      if (_searchQuery.text.length > 2) {
                        EasyDebounce.debounce("debouncer", Duration(seconds: 2),
                            () {
                          context.read<SavedBloc>().add(GetSearchSavedListEvent(_searchQuery.text));
                        });
                      }
                    },
                    keyboardType: TextInputType.name,
                    controller: _searchQuery,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                        hintText: "Search by keywords",
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(.5)),
                        focusColor: Colors.white,
                        contentPadding: const EdgeInsets.all(16),
                        border: InputBorder.none),
                  ),
                  titleSpacing: 0,
                  leading: Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/arrow.svg",
                      ),
                    ),
                  ),
                  // leadingWidth: 24,
                  actions: [
                    GestureDetector(
                        onTap: () {
                          _searchQuery.clear();
                        },
                        child: SvgPicture.asset("assets/icons/close.svg")),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                ),
                body: state.pageStatuses == PageStatuses.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.savedList.isEmpty
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/contact_unpaid.svg",
                                width: 66,
                                height: 74,
                              ),
                              const SizedBox(height: 18),
                              Text(
                                "Empty savedList",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.5)),
                              )
                            ],
                          ))
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                _searchQuery.text.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: state.savedList.length,
                                        itemBuilder: (context, index) {
                                          return ContractItem(
                                              number:
                                                  state.savedList[index].number,
                                              status:
                                                  state.savedList[index].status,
                                              textColor: AppConstants.getContainerColor(state
                                                  .savedList[index].status),
                                              containerColor: AppConstants.getContainerColor(
                                                  state
                                                      .savedList[index].status),
                                              name: state.savedList[index].name,
                                              date:
                                                  "${state.savedList[index].date.day}.${state.savedList[index].date.month}.${state.savedList[index].date.year}");
                                        })
                                    : Container(),
                              ],
                            ),
                          ));
          },
        ),
      );
}

