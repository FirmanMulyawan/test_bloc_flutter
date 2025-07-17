// import 'package:flutter/material.dart';

// class CustomProgressBar extends StatelessWidget {
//   final double value;
//   final Color filledColor;
//   final Color shadowColor;
//   final Color backgroundColor;
//   final double height;
//   final double borderRadius;

//   const CustomProgressBar({
//     super.key,
//     required this.value,
//     this.filledColor = const Color(0xFFF3C769),
//     this.shadowColor = const Color(0xFFF3C769),
//     this.backgroundColor = Colors.white,
//     this.height = 10.0,
//     this.borderRadius = 15.0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(borderRadius),
//         boxShadow: [
//           BoxShadow(
//             color: shadowColor.withOpacity(0.5),
//             offset: const Offset(0, 1),
//             blurRadius: 1,
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(borderRadius),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final double totalWidth = constraints.maxWidth;
//             final double filledWidth = totalWidth * value.clamp(0.0, 1.0);
//             return Stack(
//               children: [
//                 Container(
//                   height: height,
//                   width: totalWidth,
//                   color: backgroundColor,
//                 ),
//                 Container(
//                   width: filledWidth,
//                   height: height,
//                   decoration: BoxDecoration(
//                     color: filledColor,
//                     borderRadius: (value >= 0.999)
//                         ? BorderRadius.circular(borderRadius)
//                         : BorderRadius.horizontal(
//                             left: Radius.circular(borderRadius),
//                             right: Radius.circular(borderRadius),
//                           ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
