// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:t_store/common/images/circular_image.dart';
// import 'package:t_store/common/appbar/main_appbar.dart';
// import 'package:t_store/features/authentication/screens/home/home_screen.dart';
// import 'package:t_store/features/authentication/screens/memberships/memberships.dart';
// import 'package:t_store/features/authentication/screens/profile/profile.dart';
// import 'package:t_store/features/authentication/screens/programmes/programmes.dart';
// import 'package:t_store/features/authentication/screens/fitstore/fitstore.dart';
// import 'package:t_store/features/authentication/screens/training/training.dart';
// import 'package:t_store/features/authentication/screens/inbox/inbox.dart';
// import 'package:t_store/features/personalization/controllers/user_controller.dart';
// import 'package:t_store/features/personalization/screens/settings/settings.dart';
// import 'package:t_store/utils/helpers/helper_functions.dart';

// class NavigationMenu extends StatelessWidget {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   // NavigationMenu({super.key})

//   @override
//   Widget build(BuildContext context) {
//     final UserController controller = Get.put(UserController());
//     final NavigationController navigationController =
//         Get.put(NavigationController());
//     final dark = THelperFunctions.isDarkMode(context);
//     final iconColor =
//         dark ? const Color.fromARGB(255, 255, 255, 255) : Colors.black;

//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Obx(
//           () => Container(
//             decoration: BoxDecoration(
//               boxShadow: navigationController.selectedIndex.value == 2
//                   ? [
//                       BoxShadow(
//                         color:
//                             dark ? Colors.black : Colors.grey.withOpacity(0.3),
//                         offset: const Offset(0, 4),
//                         blurRadius: 8,
//                       ),
//                     ]
//                   : [],
//             ),
//             child: TMainAppBar(
//               scaffoldKey: _scaffoldKey,
//               iconColor: iconColor,
//               titleWidget:
//                   Obx(() => navigationController.getTitleWidget(dark, context)),
//               actions: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.person_add_alt_rounded,
//                     color: dark ? Colors.white : Colors.black,
//                     size: 24,
//                   ),
//                   onPressed: () {
//                     // Handle user icon press
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Obx(
//         () => Column(
//           children: [
//             if (navigationController.selectedIndex.value == 2)
//               Container(
//                 height: 2.0,
//                 decoration: BoxDecoration(
//                   color: dark ? Colors.black : Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 1,
//                       offset: const Offset(0, 1),
//                     ),
//                   ],
//                 ),
//               ),
//             Expanded(
//               child: Obx(() => navigationController
//                   .screens[navigationController.selectedIndex.value]),
//             ),
//           ],
//         ),
//       ),
//       drawer: Drawer(
//         backgroundColor: dark ? Colors.black : Colors.white,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.zero,
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ProfileScreen()),
//                 );
//               },
//               child: UserAccountsDrawerHeader(
//                 accountName: Obx(() {
//                   return Text(
//                     controller.user.value.fullName,
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   );
//                 }),
//                 accountEmail: Obx(() {
//                   return Text(
//                     controller.user.value.email,
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   );
//                 }),
//                 decoration: const BoxDecoration(
//                   color: Colors.transparent,
//                 ),
//                 currentAccountPicture: TCircularImage(
//                   isNetworkImage: true,
//                   image: controller.user.value.profilePicture,
//                   width: 80,
//                   height: 80,
//                 ),
//               ),
//             ),
//             StaggeredSlideAnimation(
//               duration: Duration(milliseconds: 500),
//               children: [
//                 buildListTile(context, navigationController, iconColor,
//                     Icons.timer, 'Training', 0),
//                 buildListTile(context, navigationController, iconColor,
//                     Icons.assignment, 'Programmes', 1),
//                 buildListTile(context, navigationController, iconColor,
//                     Icons.home, 'Home', 2),
//                 buildListTile(context, navigationController, iconColor,
//                     Icons.people, 'Social', 3),
//                 buildListTile(context, navigationController, iconColor,
//                     Icons.accessibility, 'Memberships', 4),
//                 buildListTile(context, navigationController, iconColor,
//                     Icons.bar_chart, 'Activity', 5),
//                 buildListTile(context, navigationController, iconColor,
//                     Icons.inbox, 'Inbox', 6),
//                 const Divider(),
//                 buildListTile(context, navigationController, iconColor,
//                     Icons.settings, 'Settings', 7),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ListTile buildListTile(BuildContext context, NavigationController controller,
//       Color iconColor, IconData icon, String title, int index) {
//     return ListTile(
//       leading: Obx(() => Icon(
//             icon,
//             color: controller.selectedIndex.value == index
//                 ? iconColor
//                 : Colors.grey,
//           )),
//       title: Obx(() => Text(
//             title,
//             style: TextStyle(
//               color: controller.selectedIndex.value == index
//                   ? iconColor
//                   : Colors.grey,
//             ),
//           )),
//       onTap: () {
//         controller.updateTitle(title, index);
//         controller.selectedIndex.value = index;
//         Navigator.pop(context);
//       },
//     );
//   }
// }

// class NavigationController extends GetxController {
//   final Rx<int> selectedIndex = 2.obs;
//   final Rx<Widget> titleWidget = Rx<Widget>(Container());

//   final screens = [
//     const Training(),
//     ProgrammesScreen(),
//     const Home(),
//     const FitStore(),
//     const Memberships(),
//     Container(),
//     NotificationInboxScreen(),
//     const SettingsScreen(),
//   ];

//   void updateTitle(String newTitle, int index) {
//     final textStyle = Get.textTheme.headlineMedium?.copyWith(
//       fontSize: 22,
//       fontWeight: FontWeight.w500,
//     );

//     titleWidget.value = Text(
//       newTitle,
//       style: textStyle,
//     );
//   }

//   Widget getTitleWidget(bool dark, BuildContext context) {
//     final textStyle = Get.textTheme.headlineMedium?.copyWith(
//       fontSize: 24,
//       fontWeight: FontWeight.bold,
//     );

//     return selectedIndex.value == 2
//         ? Row(
//             children: [
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'dopa',
//                       style: textStyle?.copyWith(
//                         color: dark ? Colors.white : Colors.black,
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Mine',
//                       style: textStyle?.copyWith(
//                         color: dark ? Colors.orange : Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Image.asset(
//                 "assets/images/content/download.png",
//                 color: Colors.grey,
//                 height: 55,
//               ),
//             ],
//           )
//         : titleWidget.value;
//   }
// }

// class StaggeredSlideAnimation extends StatefulWidget {
//   final List<Widget> children;
//   final Duration duration;

//   const StaggeredSlideAnimation({
//     Key? key,
//     required this.children,
//     this.duration = const Duration(milliseconds: 500),
//   }) : super(key: key);

//   @override
//   _StaggeredSlideAnimationState createState() =>
//       _StaggeredSlideAnimationState();
// }

// class _StaggeredSlideAnimationState extends State<StaggeredSlideAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late List<Animation<Offset>> _slideAnimations;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       duration: widget.duration,
//       vsync: this,
//     );

//     _slideAnimations = List.generate(
//       widget.children.length,
//       (index) => Tween<Offset>(
//         begin: const Offset(0, 0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _animationController,
//           curve: Interval(
//             index / widget.children.length,
//             (index + 1) / widget.children.length,
//             curve: Curves.easeOut,
//           ),
//         ),
//       ),
//     );

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _animationController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: List.generate(
//         widget.children.length,
//         (index) => SlideTransition(
//           position: _slideAnimations[index],
//           child: widget.children[index],
//         ),
//       ),
//     );
//   }
// }
