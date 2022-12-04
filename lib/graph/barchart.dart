import 'package:flutter/material.dart';
import 'package:swastha/graph/barchartwidget.dart';
import 'package:swastha/utils/styles.dart';

class BarChartPage extends StatelessWidget {
  const BarChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kWhite,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            color: const Color(0xff020227),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: BarChartWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
