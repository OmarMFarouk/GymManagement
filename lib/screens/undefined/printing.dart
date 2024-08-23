// import 'package:flutter/material.dart';

// class PrintingScreen extends StatelessWidget {
//   const PrintingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.grey[200],
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Spacer(),
//             const Text(
//               'طباعة',
//               style: TextStyle(
//                   color: AppColors.white, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         backgroundColor: AppColors.teal[800],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.grey.withOpacity(0.3),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: const [
//                       Icon(Icons.qr_code_rounded, color: AppColors.teal, size: 28),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             label: Row(
//                               children: [Spacer(), Text('الكود')],
//                             ),
//                             labelStyle: TextStyle(color: AppColors.teal),
//                             border: OutlineInputBorder(),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.teal),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: const [
//                       Icon(Icons.shopping_bag_rounded,
//                           color: AppColors.teal, size: 28),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             label: Row(
//                               children: [Spacer(), Text('الاسم')],
//                             ),
//                             labelStyle: TextStyle(color: AppColors.teal),
//                             border: OutlineInputBorder(),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.teal),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: const [
//                       Icon(Icons.attach_money_rounded,
//                           color: AppColors.teal, size: 28),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             label: Row(
//                               children: [Spacer(), Text('سعر')],
//                             ),
//                             labelStyle: TextStyle(color: AppColors.teal),
//                             border: OutlineInputBorder(),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.teal),
//                             ),
//                           ),
//                           textDirection: TextDirection.rtl,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         // Implement print functionality here
//                       },
//                       icon: const Icon(
//                         Icons.print_rounded,
//                         color: AppColors.white,
//                       ),
//                       label: const Text(
//                         'طباعة',
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         backgroundColor: AppColors.teal[800],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
