import 'package:chips_choice/chips_choice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/features/ibilling/presintation/pages/contact_page/bloc/contact_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/contact_item_widget.dart';
import 'package:ibilling/generated/locale_keys.g.dart';
import '../filter_page/filter_page.dart';
import '../search_page/search_page.dart';
import '../single_page/single_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now(); // TO tracking date
  late int currentDateSelectedIndex;
  String appBarTitle = '';
  int tag = 0;
  var selected = 0;
  bool tapped = false;
  bool isChipChanged = true;
  List<String> chipList = ["Contracts", "Invoices"]; //For Horizontal Date
  List<String> listOfDays = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];
  List<String> listOfMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    'December'
  ];
  late AnimationController _controller;
  late Animation<int> _animation;
  DateTime currenTime = DateTime.now();
  DateTime now = DateTime.now();

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
  Future<void> _refresh(DateTime dateTime) async {

    print("selectedDate:${selectedDate}");
    context
        .read<ContactBloc>()
        .add(GetAllContractsEvent(dateTime: dateTime));
  }
  void _loadMoreData(DateTime dateTime) {
    context
        .read<ContactBloc>()
        .add(LoadMoreDataEvent(dateTime: dateTime));
  }
  // Method to update the title
  void updateAppBarTitle() {
    setState(() {
      appBarTitle = LocaleKeys.contacts.tr();
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


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    int weekday = selectedDate.weekday;
    // Handle Sunday separately
    currentDateSelectedIndex = (weekday == 7) ? 0 : weekday % 7;

    print("currentDate:${selectedDate.weekday}");
    if (isChipChanged) {
      context
          .read<ContactBloc>()
          .add(GetAllContractsEvent(dateTime: selectedDate));
    }
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    _animation = IntTween(begin: 0, end: 2).animate(_controller);

    //todo  else part create bloc that return invoice list and show it here

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
          InkWell(
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilterPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/icons/filtr.svg"),
              )),
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
          InkWell(
              highlightColor: Colors.transparent,
              onTap: () {
                // showSearch(context: context, delegate: CustomSearchDelegate());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/icons/seatch.svg"),
              )),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return RefreshIndicator.adaptive(
            color: AppColors.darkGreen,
            onRefresh:()=>_refresh(state.selectedDates) ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  color: AppColors.darker,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        // padding: EdgeInsets.only(top: 6),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
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
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          selectedDate = selectedDate
                                              .subtract(Duration(days: 7));
                                          print("selectedDate:${selectedDate}");
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_back_ios_new_sharp,
                                          color: Colors.white.withOpacity(.8),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      setState(() {
                                        selectedDate = selectedDate
                                            .add(Duration(days: 7));
                                        print("selectedDate:${selectedDate}");
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Colors.white.withOpacity(.8),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      Builder(builder: (context) {
                        return const SizedBox(
                          height: 26
                        );
                      }),
                      Container(
                        height: 72,
                        child: ListView.separated(
                            separatorBuilder: (context, index) {

                              return const SizedBox(width: 18);
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: listOfDays.length - 1,
                            itemBuilder: (BuildContext context, index) {
                              int daysToAdd =
                                  index - (selectedDate.weekday - 1);
                              print("daysToAdd:$daysToAdd");
                              DateTime currentDate =
                              selectedDate.add(Duration(days: daysToAdd));
                              int dayOfWeek = currentDate.weekday;
                              print("dayOfWeek:$dayOfWeek");

                              int dayIndexInWeek = (dayOfWeek) % 7;
                              bool isSelectedDate =state.selectedDates.year == currentDate.year &&
                                  state.selectedDates.month == currentDate.month &&
                                  state.selectedDates.day == currentDate.day;
                              print("isSelected:${state.dateList}");
                              print("isSelected:${state.selectedDates}");
                              // currentDateSelectedIndex == dayIndexInWeek;
                              currenTime = currentDate;

                              print("sateList:${currentDate}");
                              selected = dayIndexInWeek;
                              //   context.read<ContactBloc>().add(AddWeekListEvent(currentDate));
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    currentDateSelectedIndex = dayIndexInWeek;
                                  });
                                  context.read<ContactBloc>().add(
                                      GetAllContractsEvent(
                                          dateTime: currentDate));
                                  print("dateee:${currentDate}");
                                  now = currentDate;
                                },
                                child: Container(
                                  width: (MediaQuery.of(context).size.width -
                                      122) /
                                      6,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xFF1E1E20),
                                            offset: Offset(3, 3),
                                            blurRadius: 5)
                                      ],
                                      color: isSelectedDate
                                          ? AppColors.lightGreen
                                          : Colors.transparent),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        listOfDays[index],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: isSelectedDate
                                                ? Colors.white
                                                : Color(0xFFD1D1D1)),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        '${currentDate.day}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: isSelectedDate
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
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  return Expanded(child: Builder(builder: (context) {
                    if (state.list.isEmpty) {
                      return Center(
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
                                "No contracts are made",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.5)),
                              )
                            ],
                          ));
                    }
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          backgroundColor: Colors.black,
                          flexibleSpace: FlexibleSpaceBar(
                            background: ChipsChoice.single(
                              value: tag,
                              onChanged: (val) {
                                setState(() {
                                  tag = val;
                                  isChipChanged = !isChipChanged;
                                  context.read<ContactBloc>().add(
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
                                      backgroundColor: AppColors.lightGreen,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                            ),
                          ),
                        ),
                        Builder(builder: (context) {
                          if (state.chipChoiceEnum == true) {
                            return Builder(builder: (context) {
                              // if(selectedDate.weekday==7){
                              //   print("selectedDate:${selectedDate.weekday}");
                              //   state.list.length=0;
                              // }
                              return SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    childCount: state.list.length,
                                        (context, index) {
                                      return GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          Navigator.of(context,
                                              rootNavigator: true)
                                              .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  SinglePage(
                                                    id: index,
                                                    isSaved: state
                                                        .list[index].isSaved,
                                                  )));
                                        },
                                        child: ContractItem(
                                          number: state.list[index].number,
                                          status: state.list[index].status,
                                          textColor: getStatusColor(
                                              state.list[index].status),
                                          containerColor: getContainerColor(
                                              state.list[index].status),
                                          name: state.list[index].name,
                                          date:
                                          "${state.list[index].date.day}.${state.list[index].date.month}.${state.list[index].date.year}",
                                        ),
                                      );
                                    },
                                  ));
                            });
                          }
                          return SliverToBoxAdapter(child: Container());
                        }),
                        Builder(builder: (context) {
                          if (state.list.length >= 10) {
                            if (state.list.length % 10 == 0 &&
                                state.chipChoiceEnum == true) {
                              print(
                                  "listttttttt:${state.allContractList.length}");
                              return state.isLoading
                                  ? SliverToBoxAdapter(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                          "Loading${'.' * (_animation.value + 1)}",
                                          style: TextStyle(
                                              color: AppColors.darkGreen),
                                        )),
                                  ))
                                  : SliverToBoxAdapter(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: ()=>_loadMoreData(state.selectedDates),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        width: 105,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          color: AppColors.darkGreen,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Load more",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }

                          return SliverToBoxAdapter(
                            child: Container(),
                          );
                        })
                      ],
                    );
                  }));
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
