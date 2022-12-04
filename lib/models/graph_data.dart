import 'package:flutter/material.dart';

class GraphData {
  // for ordering in the graph
  final int id;
  final String name;
  final double y;
  final Color color;

  const GraphData({
    required this.name,
    required this.id,
    required this.y,
    required this.color,
  });
}
