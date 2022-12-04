import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastha/Bloc/auth_cubit.dart';
import 'package:swastha/database/sql_helper.dart';
import 'package:swastha/models/graph_data.dart';
import 'package:swastha/utils/constants.dart';
import 'package:swastha/utils/styles.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WaterDashboard extends StatefulWidget {
  const WaterDashboard({Key? key}) : super(key: key);

  @override
  State<WaterDashboard> createState() => _WaterDashboardState();
}

class _WaterDashboardState extends State<WaterDashboard> {
  final List<GraphData> dataList = [];
  int maxTaken = 0;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    final List<Map<String, dynamic>> result = await SQLHelper.getWeeklyData();

    for (int i = 0; i < result.length; i++) {
      if (result[i]['water'] > maxTaken) {
        maxTaken = result[i]['water'];
      }
      dataList.add(GraphData(
          name: weekday[result[i]['day'] % 7],
          id: i,
          y: result[i]['water'] * 1.0,
          color: barColor[i % 7]));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthCubit>(context);
    double taken = blocProvider.waterModel.takenwater;
    taken = taken / 1000;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
          backgroundColor: kWhite,
          mini: true,
          onPressed: (() {
            Navigator.pop(context);
          }),
          child: const Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          )),
      body: Container(
        decoration: const BoxDecoration(color: kPrimaryColor),
        child: SafeArea(
            child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Water Dashboard',
            style: TextStyle(
                color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color: kGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width / 2,
                    width: MediaQuery.of(context).size.width / 2,
                    child: SfRadialGauge(
                        enableLoadingAnimation: true,
                        axes: <RadialAxis>[
                          RadialAxis(
                              startAngle: 90,
                              endAngle: 90,
                              canScaleToFit: false,
                              minimum: 0,
                              maximum:
                                  int.parse(blocProvider.userModel.goalWater) +
                                      0.0,
                              showLabels: false,
                              showTicks: false,
                              axisLineStyle: AxisLineStyle(
                                thickness: 0.2,
                                cornerStyle: CornerStyle.bothCurve,
                                color: Colors.blue.withOpacity(0.3),
                                thicknessUnit: GaugeSizeUnit.factor,
                              ),
                              pointers: <GaugePointer>[
                                RangePointer(
                                  value:
                                      blocProvider.dataModel.water / 1000 + 0.0,
                                  cornerStyle: CornerStyle.bothCurve,
                                  width: 0.2,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: Colors.blue,
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  positionFactor: 0.1,
                                  angle: 90,
                                  widget: Text(
                                      '${blocProvider.dataModel.water / 1000}L/${blocProvider.userModel.goalWater}L',
                                      style: kHeadingTextStyle.copyWith(
                                          color: Colors.blue, fontSize: 24.0)),
                                ),
                              ]),
                        ]),
                  ),
                ),
                const Text(
                  "Weekly Static:",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 300,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    color: const Color(0xff020227),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: BarChart(BarChartData(
                        alignment: BarChartAlignment.center,
                        maxY: maxTaken + 500,
                        minY: 0,
                        groupsSpace: 28,
                        barTouchData: BarTouchData(enabled: true),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: ((value, meta) {
                                    return Text(value.toInt().toString(),
                                        style: const TextStyle(color: kWhite));
                                  }))),
                          bottomTitles: AxisTitles(
                              axisNameSize: 50,
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: ((value, meta) {
                                    return Text(dataList[value.toInt()].name,
                                        style: const TextStyle(color: kWhite));
                                  }))),
                        ),
                        barGroups: dataList.map((data) {
                          return BarChartGroupData(
                            x: data.id,
                            barRods: [
                              BarChartRodData(
                                toY: data.y,
                                width: 12,
                                color: data.color,
                                borderRadius: data.y > 0
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                      )
                                    : const BorderRadius.only(
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6),
                                      ),
                              ),
                            ],
                          );
                        }).toList(),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ])),
      ),
    );
  }
}
