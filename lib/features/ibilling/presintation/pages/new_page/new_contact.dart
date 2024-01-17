import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/assets/app_colors.dart';
import 'package:ibilling/core/utils/enums/entity_enum.dart';
import 'package:ibilling/core/utils/enums/status_contact_enum.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/bloc/add_page_bloc.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/entity_widget.dart';
import 'package:ibilling/features/ibilling/presintation/widgets/status_widget.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class NewContact extends StatefulWidget {
  final Function() onTapSave;

  const NewContact({Key? key, required this.onTapSave}) : super(key: key);

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  late final TextEditingController nameController;
  late final TextEditingController addressController;
  late final TextEditingController innController;
  late final ValueNotifier<bool> isEntityOpened;
  late final ValueNotifier<bool> isStatusOpened;
  String selectedText = "";
  String selectedStatus = "";
  String selectedInvoice = "";
  bool isColorChangedName = false;
  bool isColorChangedAddress = false;
  bool isColorChangedINN = false;
  bool isColorChangedXizmatNomi = false;
  bool isColorChangedInvoiceSumma = false;
  int maxLength = 40;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    addressController = TextEditingController();
    innController = TextEditingController();
    isEntityOpened = ValueNotifier(false);
    isStatusOpened = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: BlocBuilder<AddPageBloc, AddPageState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text("newContact".tr(),
                    style: const TextStyle(color: AppColors.white)),
                backgroundColor: AppColors.darkest,
                titleSpacing: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset(
                    "assets/icons/ellipse.svg",
                  ),
                ),
              ),
              backgroundColor: AppColors.black,
              body: Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  left: 16,
                  top: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EntityWidget(
                        title: "Entity",
                        isMenuOpen: isEntityOpened,
                        selectedText: selectedText,
                        onTap: (entityName) {
                          isEntityOpened.value = false;
                          selectedText = entityName;
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Fisher's full name",
                        style: TextStyle(
                          color: AppColors.whiteWithOpacity.withOpacity(.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.17,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        maxLength: maxLength,
                        cursorColor: AppColors.white,
                        onTapOutside: (v) => FocusScope.of(context).unfocus(),
                        onChanged: (value) {},
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                        //  showCursor: false,
                        decoration: InputDecoration(
                          counterText: "",
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.white)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          focusColor: AppColors.white,
                          contentPadding: const EdgeInsets.all(16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: nameController.text.isNotEmpty
                                  ? AppColors.white
                                  : AppColors.whiteWithOpacity.withOpacity(.6),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Address of the organizations",
                        style: TextStyle(
                          color: const Color(0xFFF1F1F1).withOpacity(.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.17,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        maxLines: null,
                        maxLength: 100,
                        cursorColor: AppColors.white,
                        onTapOutside: (v) => FocusScope.of(context).unfocus(),
                        onChanged: (value) {},
                        keyboardType: TextInputType.text,
                        controller: addressController,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                        //  showCursor: false,
                        decoration: InputDecoration(
                          counterText: "",
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.white)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          focusColor: AppColors.white,
                          contentPadding: const EdgeInsets.all(16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: addressController.text.isNotEmpty
                                  ? AppColors.white
                                  : AppColors.whiteWithOpacity.withOpacity(.6),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "INN",
                        style: TextStyle(
                          color: const Color(0xFFF1F1F1).withOpacity(.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.17,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextField(
                        maxLength: 10,
                        cursorColor: AppColors.white,
                        onTapOutside: (v) => FocusScope.of(context).unfocus(),
                        onChanged: (value) {},
                        keyboardType: TextInputType.number,
                        controller: innController,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                        //  showCursor: false,
                        decoration: InputDecoration(
                          counterText: "",
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.white)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          focusColor: AppColors.white,
                          contentPadding: const EdgeInsets.all(16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: innController.text.isNotEmpty
                                  ? AppColors.white
                                  : AppColors.whiteWithOpacity.withOpacity(.6),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      StatusWidget(
                          onTap: (statusName){
                            isStatusOpened.value = false;
                            selectedStatus = statusName;
                            setState(() {});
                          },
                          isStatusOpened: isStatusOpened,
                          selectedStatus: selectedStatus,
                          title: "Status of the contract"),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Builder(builder: (context){
                        if (selectedText.isNotEmpty &&
                            selectedStatus.isNotEmpty &&
                            nameController
                                .text.isNotEmpty &&
                            addressController
                                .text.isNotEmpty &&
                            innController
                                .text.isNotEmpty) {
                          return GestureDetector(
                            // onTap: widget.onTapSave,
                            onTap: () {
                              widget.onTapSave();
                              context.read<AddPageBloc>().add(
                                AddContactEvent(
                                  entities: selectedText,
                                  name:
                                  nameController
                                      .text,
                                  organization:
                                  addressController
                                      .text,
                                  inn:
                                  innController
                                      .text,
                                  status: selectedStatus,
                                  date: DateTime.now(), onSuccess: () {
                                  selectedText = "";
                                  selectedStatus = "";
                                  selectedInvoice = "";
                                  innController.clear();
                                  addressController.clear();
                                  nameController.clear();
                                  isColorChangedName = false;
                                  isColorChangedAddress = false;
                                  isColorChangedINN = false;
                                  isColorChangedXizmatNomi = false;
                                  isColorChangedInvoiceSumma = false;
                                },),);
                            },
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  bottom: 4),
                              decoration: ShapeDecoration(
                                color: AppColors.darkGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(6),
                                ),
                              ),
                              child: GestureDetector(
                                  child: const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                        child: Text(
                                          "Save Contact",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFFCFCFC),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                            letterSpacing: -0.17,
                                          ),
                                        )),
                                  )),
                            ),
                          );
                        }
                        return const SizedBox();
                      })
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}
