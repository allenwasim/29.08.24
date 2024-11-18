import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/screens/fitstore/widgets/fitstore_home/home.dart';
import 'package:t_store/features/shop/screens/fitstore/widgets/store/store.dart';
import 'package:t_store/features/shop/screens/fitstore/widgets/settings/settings.dart';
import 'package:t_store/features/shop/screens/wish_list/wish_list.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class FitStore extends StatefulWidget {
  const FitStore({super.key});

  @override
  _FitStoreState createState() => _FitStoreState();
}

class _FitStoreState extends State<FitStore> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Home(),
    Store(),
    FavourateItemScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.heart5),
            label: 'WishList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        selectedItemColor: dark ? Colors.white : Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
      ),
    );
  }
}
