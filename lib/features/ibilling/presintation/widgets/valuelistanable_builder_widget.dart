// import 'package:flutter/cupertino.dart';
// import 'package:flutter_portal/flutter_portal.dart';
// import 'package:ibilling/core/utils/enums/entity_enum.dart';
// import 'package:ibilling/features/ibilling/presintation/widgets/custom_drop_down_option.dart';
//
//
// class ValueListanableWidget<T> extends StatelessWidget {
//   final  ValueNotifier<bool> isMenuOpen;
//   final ValueChanged<String> onTap;
//   final String selectedText;
//   final  T enumName;
//   const ValueListanableWidget({Key? key, required this.isMenuOpen, required this.onTap, required this.selectedText, required this.enumName}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  ValueListenableBuilder(
//       valueListenable: isMenuOpen,
//       builder: (context, value, child) => PortalTarget(
//         visible: isMenuOpen.value,
//         anchor: const Aligned(
//           follower: Alignment.topCenter,
//           target: Alignment.bottomCenter,
//         ),
//         portalFollower: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: List.generate(
//             T
//             ,
//                 (index) {
//               final entity = Entities.values[index];
//               return GestureDetector(
//                 onTap: () => onTap(entity.name),
//                 child: CustomDropDownOption(
//                   isSelected: entity.name == selectedText,
//                   name: entity.name,
//                 ),
//               );
//             },
//           ),
//         ),
//         child: Container(
//           width: double.infinity,
//           margin: const EdgeInsets.only(bottom: 4),
//           decoration: ShapeDecoration(
//             shape: RoundedRectangleBorder(
//               side: BorderSide(
//                 strokeAlign: BorderSide.strokeAlignCenter,
//                 color: selectedText.length >= 2
//                     ? AppColors.white
//                     : const Color(0xFFF1F1F1).withOpacity(.6),
//               ),
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//           child: GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: () => isMenuOpen.value = !isMenuOpen.value,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Text(
//                       selectedText,
//                       style: const TextStyle(
//                         color: AppColors.white,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const Spacer(),
//                     SvgPicture.asset(
//                         "assets/icons/arrow_circle.svg",
//                         width: 18,
//                         height: 18)
//                   ],
//                 ),
//               )),
//         ),
//       ),
//     ),
//   }
// }
