import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibilling/core/utils/enums/entity_enum.dart';
import 'package:ibilling/core/utils/enums/status_contact_enum.dart';
import 'package:ibilling/core/utils/enums/status_contact_enum.dart';
import 'package:ibilling/features/ibilling/presintation/pages/contact_page/contact_page.dart';
import 'package:ibilling/features/ibilling/presintation/pages/new_page/bloc/add_page_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../../../assets/app_colors.dart';
import '../../../../../dependency_injection.dart';

class NewPage extends StatefulWidget {
  final Function() onTapSave;

  const NewPage({Key? key, required this.onTapSave}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  TextEditingController _textEditingController3 = TextEditingController();
  TextEditingController _textControllerXizmatNomi = TextEditingController();
  TextEditingController _textContrallerInvoiceSumma = TextEditingController();

  ValueNotifier<bool> isMenuOpen = ValueNotifier(false);
  ValueNotifier<bool> isMenuOpen2 = ValueNotifier(false);
  ValueNotifier<bool> isMenuOpenInvoice = ValueNotifier(false);
  String selectedText = "";
  String selectedStatus = "";
  String selectedInvoice = "";
  bool isColorChangedName = false;
  bool isColorChangedAddress = false;
  bool isColorChangedINN = false;
  bool isColorChangedXizmatNomi = false;
  bool isColorChangedInvoiceSumma = false;

  @override
  void dispose() {
    super.dispose();
    context.read().add(InitialEvent(""));
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: BlocBuilder<AddPageBloc, AddPageState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => isMenuOpen.value == false,
              child: Builder(builder: (context) {
                print("newttttitle:${state.title}");
                return Scaffold(
                  appBar: AppBar(
                    title: state.title == "contact"
                        ? const Text(
                            "New contact",
                            style: TextStyle(color: Colors.white),
                          )
                        : (state.title == "invoice"
                            ? const Text(
                                "New invoice",
                                style: TextStyle(color: Colors.white),
                              )
                            : const Text(
                                "Contact",
                                style: TextStyle(color: Colors.white),
                              )),
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
                  body: Builder(builder: (context) {
                    print("stateeeee:${state.title}");
                    if (state.title == "contact") {
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                          left: 16,
                          top: 20,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Entity",
                                    style: TextStyle(
                                      color: const Color(0xFFF1F1F1)
                                          .withOpacity(.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: isMenuOpen,
                                        builder: (context, value, child) =>
                                            PortalTarget(
                                          visible: isMenuOpen.value,
                                          anchor: const Aligned(
                                            follower: Alignment.topCenter,
                                            target: Alignment.bottomCenter,
                                          ),
                                          portalFollower: Material(
                                            elevation: 0,
                                            child: IntrinsicWidth(
                                              stepHeight: 4,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ...Entities.values
                                                      .map((e) =>
                                                          GestureDetector(
                                                            onTap: () {
                                                              isMenuOpen.value =
                                                                  false;
                                                              selectedText =
                                                                  e.name;
                                                              print(
                                                                  "PPPPPP:${e.name}");
                                                              print(
                                                                  "PPPPPP:${selectedText}");
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.92,
                                                              color: AppColors
                                                                  .dark,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          24,
                                                                      vertical:
                                                                          15),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    e.name,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color(
                                                                          0xFFF1F1F1),
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                 SvgPicture
                                                                        .asset(
                                                                      "assets/icons/radio.svg",
                                                                      colorFilter: ColorFilter.mode(
                                                                          e.name==selectedText
                                                                              ? AppColors.lightGreen
                                                                              : Colors.grey,
                                                                         BlendMode.srcIn
                                                                         ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ))
                                                      .toList()
                                                ],
                                              ),
                                            ),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                bottom: 4),
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  strokeAlign: BorderSide
                                                      .strokeAlignCenter,
                                                  color: selectedText.length >=
                                                          2
                                                      ? Colors.white
                                                      : const Color(0xFFF1F1F1)
                                                          .withOpacity(.6),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () => isMenuOpen.value =
                                                    !isMenuOpen.value,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        selectedText,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(
                                                          "assets/icons/arrow_circle.svg",
                                                          width: 18,
                                                          height: 18)
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Fisher's full name",
                                    style: TextStyle(
                                      color: const Color(0xFFF1F1F1)
                                          .withOpacity(.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: isColorChangedName
                                              ? Colors.white
                                              : Color(0xFFF1F1F1)
                                                  .withOpacity(.6),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: TextField(
                                      onTapOutside: (v) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _textEditingController1.text = value;
                                        });
                                      },
                                      onTap: () {
                                        setState(() {
                                          isColorChangedName = true;
                                        });
                                      },
                                      textCapitalization:
                                          TextCapitalization.words,
                                      keyboardType: TextInputType.name,
                                      controller: _textEditingController1,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                      showCursor: false,
                                      decoration: const InputDecoration(
                                          focusColor: Colors.white,
                                          contentPadding: EdgeInsets.all(16),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Address of the organizations",
                                    style: TextStyle(
                                      color: const Color(0xFFF1F1F1)
                                          .withOpacity(.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: isColorChangedAddress
                                              ? Colors.white
                                              : Color(0xFFF1F1F1)
                                                  .withOpacity(.6),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          _textEditingController2.text = value;
                                        });
                                      },
                                      onTap: () {
                                        setState(() {
                                          isColorChangedAddress = true;
                                        });
                                      },
                                      maxLines: null,
                                      keyboardType: TextInputType.text,
                                      controller: _textEditingController2,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                      showCursor: false,
                                      decoration: const InputDecoration(
                                          focusColor: Colors.white,
                                          contentPadding: EdgeInsets.all(16),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "INN",
                                    style: TextStyle(
                                      color: const Color(0xFFF1F1F1)
                                          .withOpacity(.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: isColorChangedINN
                                              ? Colors.white
                                              : Color(0xFFF1F1F1)
                                                  .withOpacity(.6),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          _textEditingController3.text = value;
                                        });
                                      },
                                      onTap: () {
                                        setState(() {
                                          isColorChangedINN = true;
                                        });
                                      },
                                      controller: _textEditingController3,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                      showCursor: false,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: SvgPicture.asset(
                                                "assets/icons/help_circle.svg"),
                                          ),
                                          focusColor: Colors.white,
                                          contentPadding: EdgeInsets.all(16),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status of the contact",
                                    style: TextStyle(
                                      color: const Color(0xFFF1F1F1)
                                          .withOpacity(.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: isMenuOpen2,
                                        builder: (context, value, child) =>
                                            PortalTarget(
                                          visible: isMenuOpen2.value,
                                          anchor: const Aligned(
                                            follower: Alignment.topCenter,
                                            target: Alignment.bottomCenter,
                                          ),
                                          portalFollower: Material(
                                            elevation: 8,
                                            child: IntrinsicWidth(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ...StatusContactEnum.values
                                                      .map(
                                                          (e) =>
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    isMenuOpen2
                                                                            .value =
                                                                        false;
                                                                    selectedStatus =
                                                                        e.name;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.92,
                                                                  color:
                                                                      AppColors
                                                                          .dark,
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          24,
                                                                      vertical:
                                                                          15),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        e.name,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Color(0xFFF1F1F1),
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                      const Spacer(),
                                                                      SvgPicture
                                                                          .asset(
                                                                        "assets/icons/radio.svg",
                                                                        colorFilter: ColorFilter.mode(
                                                                            e.name==selectedStatus
                                                                                ? AppColors.lightGreen
                                                                                : Colors.grey,
                                                                            BlendMode.srcIn),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ))
                                                      .toList()
                                                ],
                                              ),
                                            ),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                bottom: 4),
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  strokeAlign: BorderSide
                                                      .strokeAlignCenter,
                                                  color: selectedStatus
                                                              .length >=
                                                          2
                                                      ? Colors.white
                                                      : const Color(0xFFF1F1F1)
                                                          .withOpacity(.6),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () => isMenuOpen2.value =
                                                    !isMenuOpen2.value,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        selectedStatus,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(
                                                          "assets/icons/arrow_circle.svg",
                                                          width: 18,
                                                          height: 18)
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      Builder(builder: (context) {
                                        if (selectedText.isNotEmpty &&
                                            selectedStatus.isNotEmpty &&
                                            _textEditingController1
                                                .text.isNotEmpty &&
                                            _textEditingController2
                                                .text.isNotEmpty &&
                                            _textEditingController3
                                                .text.isNotEmpty) {
                                          return GestureDetector(
                                            // onTap: widget.onTapSave,
                                            onTap: () {
                                              widget.onTapSave();
                                              print(
                                                  "resulttttttttttttt:${selectedText + " " + _textEditingController1.text + " " + _textEditingController2.text + " " + _textEditingController3.text + " " + selectedStatus}");
                                              context.read<AddPageBloc>().add(
                                                  AddContactEvent(
                                                      entities: selectedText,
                                                      name:
                                                          _textEditingController1
                                                              .text,
                                                      organization:
                                                          _textEditingController2
                                                              .text,
                                                      inn:
                                                          _textEditingController3
                                                              .text,
                                                      status: selectedStatus,
                                                      date: DateTime.now(), onSuccess: () {  }));
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
                                        return Container();
                                      })
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    else if (state.title == "invoice") {
                      return Padding(
                        padding:
                            const EdgeInsets.only(right: 16, left: 16, top: 20),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Xizmat nomi",
                                  style: TextStyle(
                                    color:
                                        const Color(0xFFF1F1F1).withOpacity(.6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.17,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 4),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: isColorChangedXizmatNomi
                                            ? Colors.white
                                            : Color(0xFFF1F1F1).withOpacity(.6),
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _textControllerXizmatNomi.text = value;
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        isColorChangedXizmatNomi = true;
                                      });
                                    },
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.name,
                                    controller: _textControllerXizmatNomi,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    showCursor: false,
                                    decoration: const InputDecoration(
                                        focusColor: Colors.white,
                                        contentPadding: EdgeInsets.all(16),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Invoice Summasi",
                                  style: TextStyle(
                                    color:
                                        const Color(0xFFF1F1F1).withOpacity(.6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.17,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 4),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: isColorChangedInvoiceSumma
                                            ? Colors.white
                                            : Color(0xFFF1F1F1).withOpacity(.6),
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _textContrallerInvoiceSumma.text =
                                            value;
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        isColorChangedInvoiceSumma = true;
                                      });
                                    },
                                    controller: _textContrallerInvoiceSumma,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    showCursor: false,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        focusColor: Colors.white,
                                        contentPadding: EdgeInsets.all(16),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status of the invoice",
                                  style: TextStyle(
                                    color:
                                        const Color(0xFFF1F1F1).withOpacity(.6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.17,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: isMenuOpenInvoice,
                                      builder: (context, value, child) =>
                                          PortalTarget(
                                        visible: isMenuOpenInvoice.value,
                                        anchor: const Aligned(
                                          follower: Alignment.topCenter,
                                          target: Alignment.bottomCenter,
                                        ),
                                        portalFollower: Material(
                                          elevation: 8,
                                          child: IntrinsicWidth(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ...StatusContactEnum.values
                                                    .map((e) => GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              isMenuOpenInvoice
                                                                      .value =
                                                                  false;
                                                              selectedInvoice =
                                                                  e.name;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.92,
                                                            color:
                                                                AppColors.dark,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        24,
                                                                    vertical:
                                                                        15),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  e.name,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFFF1F1F1),
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/icons/radio.svg",
                                                                  colorFilter: ColorFilter.mode(
                                                                      e.name.contains(
                                                                              selectedInvoice)
                                                                          ? AppColors
                                                                              .lightGreen
                                                                          : Colors
                                                                              .grey,
                                                                      BlendMode
                                                                          .srcIn),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ))
                                                    .toList()
                                              ],
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          margin:
                                              const EdgeInsets.only(bottom: 4),
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                                color: selectedInvoice.length >=
                                                        2
                                                    ? Colors.white
                                                    : const Color(0xFFF1F1F1)
                                                        .withOpacity(.6),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          child: GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () =>
                                                  isMenuOpenInvoice.value =
                                                      !isMenuOpenInvoice.value,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      selectedInvoice,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    SvgPicture.asset(
                                                        "assets/icons/arrow_circle.svg",
                                                        width: 18,
                                                        height: 18)
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Builder(builder: (context) {
                                      if (_textContrallerInvoiceSumma
                                              .text.isNotEmpty &&
                                          _textControllerXizmatNomi
                                              .text.isNotEmpty &&
                                          selectedInvoice.isNotEmpty) {
                                        return Container(
                                          width: double.infinity,
                                          margin:
                                              const EdgeInsets.only(bottom: 4),
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
                                              "Save Invoice",
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
                                        );
                                      }
                                      return Container();
                                    })
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }

                    return Container();
                  }),
                );
              }),
            );
          },
        ),
      );
}
