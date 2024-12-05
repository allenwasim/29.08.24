import 'package:flutter/material.dart';
import 'package:t_store/common/appbar/sub_appbar.dart';
import 'package:t_store/user_module/features/personalization/screens/training/guidance/guidance_tab.dart';
import 'package:t_store/user_module/features/personalization/screens/training/widgets/foryou_/foryou_tab.dart';
import 'package:t_store/user_module/features/personalization/screens/training/widgets/trainers/trainers.dart';

class Training extends StatefulWidget {
  const Training({super.key});

  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training>
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
          tabs: const ['Discover', 'Guidance', 'Trainers'],
          tabController: _tabController,
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            DiscoverTab(),
            GuidancePage(),
            TrainerListScreen(),
          ],
        ),
      ),
    );
  }
}
