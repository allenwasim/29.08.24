import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:t_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TCurvedEdges(
      child: Container(
        color: dark ? Colors.black : Colors.green.shade500,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                backgroundColor: dark
                    ? Colors.green.withOpacity(0.5)
                    : Colors.white.withOpacity(.2),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                  backgroundColor: dark
                      ? Colors.green.withOpacity(0.5)
                      : Colors.white.withOpacity(.2)),
            ),
            // New Positioned widgets for text

            // You can include the child widget here if needed

            child
          ],
        ),
      ),
    );
  }
}
