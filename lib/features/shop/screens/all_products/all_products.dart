import 'package:flutter/material.dart';
import 'package:t_store/common/appbar/appbar.dart';
import 'package:t_store/common/widgets/product/sortable/sortable_products.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text("Popular products"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: TSortableProducts(),
        ),
      ),
    );
  }
}
