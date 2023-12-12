import 'package:chips_choice/chips_choice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibilling/core/utils/app_colors.dart';
import 'package:ibilling/core/utils/enums/status_contact_enum.dart';
import 'package:ibilling/features/ibilling/data/datasource/local_datasource/local_datasource.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';
import 'package:ibilling/features/ibilling/presintation/pages/contact_page/bloc/contact_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/bloc/add_page_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/contact_item_widget.dart';
import 'package:ibilling/generated/locale_keys.g.dart';

import '../../../../../dependency_injection.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  DateTime selectedDate = DateTime.now(); // TO tracking date
  int currentDateSelectedIndex = 0;
  int tag = 0;
  bool isChipChanged = true;

  final bloc = sl<ContactBloc>();
  List<String> chipList = ["Contracts", "Invoices"]; //For Horizontal Date
  List<String> listOfDays = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];
  List<String> listOfMonths = [
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "september",
    "october",
    "november",
    'december'
  ];
  var pref = sl<LocalDataSource>();
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
    super.dispose();
  }

  @override
  void initState() {
    if (isChipChanged) {
      bloc.add(GetAllContractsEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return Builder(builder: (context) {
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
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: buildBar(context),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 150,
                    color: AppColors.darker,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            listOfMonths[selectedDate.month - 1] +
                                ", " +
                                selectedDate.year.toString(),
                            style: const TextStyle(
                              color: Color(0xFFDADADA),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              height: 0.08,
                              letterSpacing: -0.20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 72,
                              width: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFF1E1E20),
                                        offset: Offset(3, 3),
                                        blurRadius: 5)
                                  ],
                                  color: AppColors.lightGreen),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listOfDays[DateTime
                                        .now()
                                        .add(Duration(
                                        days: selectedDate.day))
                                        .weekday -
                                        1]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    DateTime
                                        .now()
                                        .add(Duration(days: selectedDate.day))
                                        .day
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                      width: 15,
                                      child: Divider(
                                        thickness: 1,
                                        height: 10,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              height: 72,
                              width: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFF1E1E20),
                                        offset: Offset(3, 3),
                                        blurRadius: 5)
                                  ],
                                  color: currentDateSelectedIndex ==
                                      selectedDate.day
                                      ? Color(0xFF00A795)
                                      : Color(0xFF1E1E20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listOfDays[DateTime
                                        .now()
                                        .add(Duration(
                                        days: selectedDate.day))
                                        .weekday -
                                        1]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    DateTime
                                        .now()
                                        .add(Duration(days: selectedDate.day))
                                        .day
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                      width: 15,
                                      child: Divider(
                                        thickness: 1,
                                        height: 10,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              height: 72,
                              width: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFF1E1E20),
                                        offset: Offset(3, 3),
                                        blurRadius: 5)
                                  ],
                                  color: currentDateSelectedIndex ==
                                      selectedDate.day
                                      ? Color(0xFF00A795)
                                      : Color(0xFF1E1E20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listOfDays[DateTime
                                        .now()
                                        .add(Duration(
                                        days: selectedDate.day))
                                        .weekday -
                                        1]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    DateTime
                                        .now()
                                        .add(Duration(days: selectedDate.day))
                                        .day
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                      width: 15,
                                      child: Divider(
                                        thickness: 1,
                                        height: 10,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              height: 72,
                              width: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFF1E1E20),
                                        offset: Offset(3, 3),
                                        blurRadius: 5)
                                  ],
                                  color: currentDateSelectedIndex ==
                                      selectedDate.day
                                      ? Color(0xFF00A795)
                                      : Color(0xFF1E1E20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listOfDays[DateTime
                                        .now()
                                        .add(Duration(
                                        days: selectedDate.day))
                                        .weekday -
                                        1]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    DateTime
                                        .now()
                                        .add(Duration(days: selectedDate.day))
                                        .day
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                      width: 15,
                                      child: Divider(
                                        thickness: 1,
                                        height: 10,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              height: 72,
                              width: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFF1E1E20),
                                        offset: Offset(3, 3),
                                        blurRadius: 5)
                                  ],
                                  color: currentDateSelectedIndex ==
                                      selectedDate.day
                                      ? Color(0xFF00A795)
                                      : Color(0xFF1E1E20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listOfDays[DateTime
                                        .now()
                                        .add(Duration(
                                        days: selectedDate.day))
                                        .weekday -
                                        1]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    DateTime
                                        .now()
                                        .add(Duration(days: selectedDate.day))
                                        .day
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                      width: 15,
                                      child: Divider(
                                        thickness: 1,
                                        height: 10,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              height: 72,
                              width: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFF1E1E20),
                                        offset: Offset(3, 3),
                                        blurRadius: 5)
                                  ],
                                  color: currentDateSelectedIndex ==
                                      selectedDate.day
                                      ? Color(0xFF00A795)
                                      : Color(0xFF1E1E20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listOfDays[DateTime
                                        .now()
                                        .add(Duration(
                                        days: selectedDate.day))
                                        .weekday -
                                        1]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    DateTime
                                        .now()
                                        .add(Duration(days: selectedDate.day))
                                        .day
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: currentDateSelectedIndex ==
                                            selectedDate.day
                                            ? Colors.white
                                            : Color(0xFFD1D1D1)),
                                  ),
                                  const SizedBox(
                                      width: 15,
                                      child: Divider(
                                        thickness: 1,
                                        height: 10,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            flexibleSpace: FlexibleSpaceBar(
                              background: ChipsChoice.single(
                                value: tag,
                                onChanged: (val) {
                                  setState(() {
                                    tag = val;
                                    isChipChanged = !isChipChanged;
                                    bloc.add(
                                        ChangeChipChoiceEvent(isChipChanged));
                                  });
                                },
                                choiceItems: C2Choice.listFrom<int, String>(
                                    source: chipList,
                                    value: (index, v) => index,
                                    label: (index, v) => v,
                                    tooltip: (i, v) => v),
                                choiceStyle: C2ChipStyle.filled(
                                    disabledStyle: C2ChipStyle(
                                        backgroundColor: Colors.transparent),
                                    selectedStyle: const C2ChipStyle(
                                        backgroundColor: AppColors.darkGreen,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(6)))),
                              ),
                            ),
                          ),
                          Builder(builder: (context) {
                            if (state.list.isEmpty) {
                              return SliverAppBar();
                            }
                            if (state.chipChoiceEnum == true) {
                              return SliverList(
                                  delegate:
                                  SliverChildBuilderDelegate((context, index) {
                                    return ContractItem(
                                        number: state.list[index].number,
                                        status: state.list[index].status,
                                        textColor: getStatusColor(state.list[index].status),
                                        containerColor: getContainerColor(state.list[index].status),
                                        name: state.list[index].name);

                                  }, childCount: state.list.length));
                            }
                            return SliverAppBar();
                          })
                        ],
                      ))
                ],
              ),
            );
          });
        },
      ),
    );
  }

  AppBar buildBar(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.contacts.tr(),
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
        SvgPicture.asset("assets/icons/filtr.svg"),
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
        SvgPicture.asset("assets/icons/seatch.svg"),
        const SizedBox(
          width: 16,
        )
      ],
    );
  }
}
