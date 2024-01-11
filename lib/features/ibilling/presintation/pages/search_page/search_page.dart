import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ibilling/features/ibilling/presintation/pages/contact_page/bloc/contact_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/contact_item_widget.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../../../assets/app_colors.dart';
import '../../../../../dependency_injection.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../new_page/bloc/add_page_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchQuery = TextEditingController();
  final bloc = sl<ContactBloc>();

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

  @override
  void dispose() {
    bloc.close();
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
          child: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {

            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: AppColors.darkest,
                title: TextField(
                  onChanged: (value){
                    if(_searchQuery.text.isNotEmpty){
                      EasyDebounce.debounce("debouncer", Duration(seconds: 2), () {
                        bloc.add(GetSearchListEvent(_searchQuery.text));
                        print("searchQuery:${_searchQuery.text.length}");
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
                      hintStyle: TextStyle(color: Colors.white.withOpacity(.5)),
                      focusColor: Colors.white,
                      contentPadding: EdgeInsets.all(16),
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
              body: Builder(
                builder: (context) {
                  if(state.list.isEmpty){
                    return
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/contact_unpaid.svg",
                              width: 66,
                              height: 74,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Empty list",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.5)),
                            )
                          ],
                        ));
                  }
                  if (state.pageStatuses == PageStatuses.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.pageStatuses == PageStatuses.fail) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        state.errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                      duration: Duration(seconds: 3),
                    ));
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                       _searchQuery.text.isNotEmpty?ListView.builder(
                         shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.list.length,
                              itemBuilder: (context, index) {
                                return
                                     ContractItem(
                                        number: state.list[index].number,
                                        status: state.list[index].status,
                                        textColor: getStatusColor(state.list[index].status),
                                        containerColor:
                                            getContainerColor(state.list[index].status),
                                        name: state.list[index].name,
                                        date:
                                            "${state.list[index].date.day}.${state.list[index].date.month}.${state.list[index].date.year}");


                              }):   Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/contact_unpaid.svg",
                                    width: 66,
                                    height: 74,
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Text(
                                    "Empty list",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.5)),
                                  )
                                ],
                              )),

                      ],
                    ),
                  );
                }
              ),
            );
          },
        ),
      ));
}
