import 'package:flutter/material.dart';
import 'package:t_store/common/appbar/sub_appbar.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/active/active.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/available.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/near_me.dart';

class Memberships extends StatefulWidget {
  const Memberships({super.key});

  @override
  _MembershipsState createState() => _MembershipsState();
}

class _MembershipsState extends State<Memberships>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TSubAppBar(
          tabs: const ['Active', 'Available', 'Near Me'],
          tabController: _tabController,
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            ActiveMembershipsScreen(),
            AvailableMembershipsScreen(),
            NearMeScreen(),
          ],
        ),
      ),
    );
  }
}
