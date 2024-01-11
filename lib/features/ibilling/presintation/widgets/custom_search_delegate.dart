import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/contact_item_widget.dart';

import '../../../../dependency_injection.dart';
import '../pages/contact_page/bloc/contact_bloc.dart';
import '../pages/new_page/bloc/add_page_bloc.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
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

  final bloc = sl<ContactBloc>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
      // Exit from the search screen.
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read().add(GetSearchListEvent(query));
    return BlocProvider(
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
          bloc: bloc,
          builder: (context, state) {
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
                    style: TextStyle(color: Colors.white.withOpacity(.5)),
                  )
                ],
              ));
            }
            return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return ContractItem(
                      number: state.list[index].number,
                      status: state.list[index].status,
                      textColor: getStatusColor(state.list[index].status),
                      containerColor:
                          getContainerColor(state.list[index].status),
                      name: state.list[index].name,
                      date:
                          "${state.list[index].date.day}.${state.list[index].date.month}.${state.list[index].date.year}");
                });
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.add(GetSearchListEvent(query));
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ContactBloc, ContactState>(
          builder: (BuildContext context, state) {
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
                style: TextStyle(color: Colors.white.withOpacity(.5)),
              )
            ],
          ));
        }
        return ListView.builder(
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              return ContractItem(
                  number: state.list[index].number,
                  status: state.list[index].status,
                  textColor: getStatusColor(state.list[index].status),
                  containerColor: getContainerColor(state.list[index].status),
                  name: state.list[index].name,
                  date:
                      "${state.list[index].date.day}.${state.list[index].date.month}.${state.list[index].date.year}");
            });
      }),
    );
  }
}
