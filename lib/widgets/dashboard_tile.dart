import 'package:flutter/material.dart';
import 'package:swastha/utils/styles.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DashboardTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String rangeTitle;
  final double maxrange;
  final double interval;
  final double valuerange;
  final Color colorshade1;
  final Color colorshade2;
  const DashboardTile(
      {Key? key,
      required this.icon,
      required this.title,
      required this.rangeTitle,
      required this.maxrange,
      required this.interval,
      required this.valuerange,
      required this.colorshade1,
      required this.colorshade2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: const BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.blueAccent,
                    size: 30,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            rangeTitle,
                            style: const TextStyle(
                                color: kPrimaryColor, fontSize: 20),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: valuerange >= maxrange
                                    ? Colors.green
                                    : valuerange <= maxrange / 3
                                        ? Colors.red
                                        : Colors.orange,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            height: 20,
                            width: 50,
                            child: Center(
                                child: Text(
                              valuerange >= maxrange
                                  ? "Done"
                                  : valuerange <= maxrange / 3
                                      ? "Alert"
                                      : "Good",
                              style: const TextStyle(color: kWhite),
                            )),
                          )
                        ],
                      ),
                      Container(
                        // ignore: sort_child_properties_last
                        child: SfLinearGauge(
                            showTicks: false,
                            interval: interval,
                            minimum: 0.0,
                            maximum: maxrange,
                            orientation: LinearGaugeOrientation.horizontal,
                            animateAxis: true,
                            animateRange: true,
                            markerPointers: [
                              LinearShapePointer(
                                value: valuerange,
                                color: colorshade2,
                              ),
                            ],
                            // barPointers: [
                            //   LinearBarPointer(
                            //     thickness: 12,
                            //     value: valuerange,
                            //     color: Colors.green,
                            //     edgeStyle: LinearEdgeStyle.bothCurve,
                            //   )
                            // ],
                            majorTickStyle: const LinearTickStyle(length: 10),
                            axisLabelStyle: const TextStyle(
                                fontSize: 12.0, color: Colors.black),
                            // ignore: prefer_const_constructors
                            axisTrackStyle: LinearAxisTrackStyle(
                                gradient: LinearGradient(colors: [
                                  colorshade1,
                                  colorshade2,
                                ]),
                                color: kGrey,
                                edgeStyle: LinearEdgeStyle.bothCurve,
                                thickness: 15.0,
                                borderColor: Colors.grey)),
                        margin: const EdgeInsets.all(10),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
