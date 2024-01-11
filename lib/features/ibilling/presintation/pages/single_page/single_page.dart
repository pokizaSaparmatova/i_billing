import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/features/ibilling/data/datasource/local_datasource/local_datasource.dart';
import 'package:ibilling/features/ibilling/data/models/contact_model.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/contact_item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../assets/app_colors.dart';
import '../../../../../dependency_injection.dart';
import '../contact_page/bloc/contact_bloc.dart';

class SinglePage extends StatefulWidget {
  final int id;

  final bool isSaved;

  const SinglePage({super.key, required this.id, required this.isSaved});

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
 late bool isSaved;

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
  void initState() {
    isSaved = widget.isSaved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        String monthFormat =
            DateFormat('MMMM').format(state.list[widget.id].date);
        String name = state.list[widget.id].name;
        List<ContactModel> newList = state.list;

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text('№ ${state.list[widget.id].number}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 0,
                  letterSpacing: -0.17,
                )),
            backgroundColor: AppColors.darkest,
            titleSpacing: 0,
            leading: Padding(
              padding: const EdgeInsets.all(15),
              child: SvgPicture.asset(
                "assets/icons/contact.svg",
              ),
            ),
            // leadingWidth: 24,
            actions: [
              GestureDetector(
                  onTap: () {
                setState(() {
                  isSaved=!isSaved;
                });
                    context.read<ContactBloc>().add(SavedContractEvent(
                        id: state.list[widget.id].number, isSaved: isSaved,contactModel:state.list[widget.id] ));
                  },
                  child:isSaved
                      ? SvgPicture.asset("assets/icons/sel_saved.svg")
                      : SvgPicture.asset("assets/icons/saved.svg")),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Container(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, top: 14, bottom: 14),
                    // width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.dark),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Fisher’s full name:',
                              style: TextStyle(
                                color: Color(0xFFE6E6E6),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              state.list[widget.id].name,
                              style: const TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Status of the contract:',
                              style: TextStyle(
                                color: Color(0xFFE6E6E6),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              state.list[widget.id].status,
                              style: const TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Amount:',
                              style: TextStyle(
                                color: Color(0xFFE6E6E6),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '1,200,000 UZS',
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Last invoice:',
                              style: TextStyle(
                                color: Color(0xFFE6E6E6),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '№ 156',
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Number of invoices:',
                              style: TextStyle(
                                color: Color(0xFFE6E6E6),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '6',
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Address of the organization: ',
                              style: TextStyle(
                                color: Color(0xFFE6E6E6),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              state.list[widget.id].organization,
                              style: const TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Row(
                          children: [
                            Text(
                              'ITN/IEC of the organization:',
                              style: TextStyle(
                                color: Color(0xFFE6E6E6),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '5647520318',
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Created at:',
                              style: TextStyle(
                                color: Color(0xFFE6E6E6),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              " ${state.list[widget.id].date.hour}:${state.list[widget.id].date.minute}, ${state.list[widget.id].date.day} $monthFormat , ${state.list[widget.id].date.year}",
                              style: const TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("iddddddd:${state.list[widget.id].number}");
                        context.read<ContactBloc>().add(DeleteContractEvent(
                            id: state.list[widget.id].number));
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Container(
                          width: 164,
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFF426D).withOpacity(.3),
                              borderRadius: BorderRadius.circular(6)),
                          child: const Center(
                              child: Text(
                            textAlign: TextAlign.center,
                            "Delete contract",
                            style: TextStyle(
                              color: Color(0xFFFF426D),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Container(
                          width: 164,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.darkGreen,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Center(
                              child: Text(
                            textAlign: TextAlign.center,
                            "Create contract",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Text(
                    '''Other contracts with
${state.list[widget.id].name}''',
                    style: const TextStyle(
                      color: Color(0xFFE7E7E7),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocProvider(
                  create: (context) => ContactBloc(
                    getContactUsecase: sl(),
                    getNextContract: sl(),
                    getAllContract: sl(),
                    getSearchList: sl(),
                    removeContract: sl(),
                    getSingleListContract: sl(),
                    localDataSource: sl(),
                    savedContract: sl(),

                  ),
                  child: BlocBuilder<ContactBloc, ContactState>(
                    builder: (context, state) {
                      context
                          .read<ContactBloc>()
                          .add(GetSingleListContractEvent(name));

                      List<ContactModel> filteredList = state.list
                          .where((item) =>
                              item.number != newList[widget.id].number)
                          .toList();
                      print("listkkkk:${state.list.length}");
                      print("listkkkk:${newList.length}");
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            return ContractItem(
                              number: filteredList[index].number,
                              status: filteredList[index].status,
                              textColor:
                                  getStatusColor(filteredList[index].status),
                              containerColor:
                                  getContainerColor(filteredList[index].status),
                              name: filteredList[index].name,
                              date:
                                  "${filteredList[index].date.day}.${filteredList[index].date.month}.${filteredList[index].date.year}",
                            );
                          });
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
