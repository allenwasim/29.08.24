// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:t_store/trainer_module/features/sections/gym/sub_sections/add_plan/add_plans.dart';

// class GymScreen extends StatelessWidget {
//   final String trainerId; // Add this field to hold the trainerId

//   const GymScreen(
//       {super.key, required this.trainerId}); // Accept trainerId via constructor

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Profile Picture Section
//               CircleAvatar(
//                 radius: 50,
//                 backgroundColor: Colors.grey[300],
//                 child: Icon(Icons.person, size: 50, color: Colors.grey[700]),
//               ),
//               const SizedBox(height: 8),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.camera_alt, color: Colors.teal),
//               ),
//               const SizedBox(height: 16),

//               // User Information
//               const Text(
//                 'Allen',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const Text(
//                 'allen',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//               const Text(
//                 '+91 9188223629',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//               const Text(
//                 'allenwasimk@gmail.com',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//               const SizedBox(height: 24),

//               // Options Section
//               ListTile(
//                 leading: const Icon(Icons.view_list, color: Colors.teal),
//                 title: const Text('Plans'),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                 onTap: () => Get.to(() =>
//                     AddPlanScreen(trainerId: trainerId)), // Pass trainerId here
//               ),
//               ListTile(
//                 leading: const Icon(Icons.settings, color: Colors.teal),
//                 title: const Text('Services'),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.report_problem, color: Colors.teal),
//                 title: const Text('Request A Feature/Report An Issue'),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.phone, color: Colors.teal),
//                 title: const Text('Contact Us'),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.help, color: Colors.teal),
//                 title: const Text('How to Use GymBook?'),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
