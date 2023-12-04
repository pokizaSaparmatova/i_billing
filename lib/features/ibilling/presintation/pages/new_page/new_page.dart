import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/bloc/add_page_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/appbar_widget.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/language_dialog.dart';

import '../../../../../core/utils/app_colors.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPageBloc, AddPageState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: state.title == "contact"
              ? const Text(
                  "New contact",
                  style: TextStyle(color: Colors.white),
                )
              : const Text(
                  "New invoice",
                  style: TextStyle(color: Colors.white),
                ),
          backgroundColor: AppColors.darkest,
          titleSpacing: 0,
          leading: Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset(
              "assets/icons/ellipse.svg",
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Builder(
          builder: (context) {
            if(state.title=="contact"){

            }
            else{
              return Container();
            }
            return Container();
          }
        ),
      );
    });
  }

}
