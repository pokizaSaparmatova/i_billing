import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/bloc/add_page_bloc.dart';

import '../../../../core/utils/app_colors.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPageBloc,AddPageState>(builder: (context,state){
      return    Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          backgroundColor: AppColors.dark,
          insetPadding: const EdgeInsets.only(left: 24, right: 24),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4.2,
              child: Column(
                children: [
                  Text(
                    "what_do_you_want_to_save".tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<AddPageBloc>()
                          .add(AddContactInitialEvent("contact"));
                      Navigator.pop(context,"contact");

                    },
                    child: Container(
                      width: double.infinity,
                      height: 46,
                      padding: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.grey),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/contact.svg"),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            "Contact",
                            style: TextStyle(
                              color: Color(0xFFE7E7E7),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.17,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<AddPageBloc>()
                          .add(AddInvoiceInitialEvent("invoice"));
                      Navigator.pop(context, "invoice");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 46,
                      padding: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.grey),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/invoice.svg",
                            width: 14,
                            height: 16,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            "Invoce",
                            style: TextStyle(
                              color: Color(0xFFE7E7E7),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.17,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )));
    });

  }
}
