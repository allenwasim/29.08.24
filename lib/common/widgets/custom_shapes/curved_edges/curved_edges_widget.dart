import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

class TCurvedEdges extends StatelessWidget {
  const TCurvedEdges({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: TCustomeCurvedEdges(), child: child);
  }
}
