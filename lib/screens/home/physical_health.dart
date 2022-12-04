import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:swastha/Bloc/auth_cubit.dart';
import 'package:swastha/database/sql_helper.dart';
import 'package:swastha/models/data_model.dart';
import 'package:swastha/screens/dashboards/calorie_dashboard.dart';
import 'package:swastha/screens/dashboards/sleep_dashboard.dart';
import 'package:swastha/screens/dashboards/steps_dashboard.dart';
import 'package:swastha/screens/dashboards/water_dashboard.dart';
import 'package:swastha/screens/home/physical/add_sleep.dart';
import 'package:swastha/screens/home/physical/add_water.dart';
import 'package:swastha/screens/home/physical/add_calories.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/dashboard_tile.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

double x = 0.0;
double y = 0.0;
double z = 0.0;

int steps = 0;
double previousDistacne = 0.0;
double distance = 0.0;

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();

  return true;
}

void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually
  SharedPreferences preferences = await SharedPreferences.getInstance();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  double getValue(double x, double y, double z) {
    double magnitude = sqrt(x * x + y * y + z * z);
    double modDistance = magnitude - previousDistacne;
    previousDistacne = magnitude;

    return modDistance;
  }

  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    SensorsPlatform.instance.accelerometerEvents.listen((event) {
      x = event.x;
      y = event.y;
      z = event.z;
      distance = getValue(x, y, z);
      if (distance > 6) {
        steps++;
      }
    });

    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Steps Count $steps",
        content: "Keep Moving",
      );
      service.setAsForegroundService();
    }

    SQLHelper.insertData(DataModel(
        DateFormat('dd/MM/yyyy').format(DateTime.now()),
        DateTime.now().weekday,
        0,
        0,
        0,
        steps));

    /// you can see this log in logcat

    // test using external plugin
  });
}

class PhysicalHealth extends StatefulWidget {
  const PhysicalHealth({Key? key}) : super(key: key);

  @override
  State<PhysicalHealth> createState() => _PhysicalHealthState();
}

class _PhysicalHealthState extends State<PhysicalHealth> {
  @override
  void initState() {
    getData();

    super.initState();
  }

  void getData() async {
    final blocProvider = BlocProvider.of<AuthCubit>(context);
    final DataModel data = await blocProvider.getDataFromSQL();
    blocProvider.setDataModel(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthCubit>(context);
    double taken = blocProvider.waterModel.takenwater;
    // ignore: division_optimization
    int overallGoal = ((((blocProvider.dataModel.water / 1000) /
                        int.parse(blocProvider.userModel.goalWater)) *
                    100 +
                (blocProvider.dataModel.sleep /
                        int.parse(blocProvider.userModel.goalSleep)) *
                    100 +
                (blocProvider.dataModel.calories /
                        int.parse(blocProvider.userModel.goalCalorie)) *
                    100 +
                (blocProvider.dataModel.steps /
                        int.parse(blocProvider.userModel.goalSteps)) *
                    100) /
            4)
        .toInt();
    taken = taken / 1000;
    return Scaffold(
      floatingActionButton: SpeedDial(
        closedForegroundColor: kWhite,
        openForegroundColor: kPrimaryColor,
        closedBackgroundColor: kPrimaryColor,
        openBackgroundColor: kWhite,
        labelsBackgroundColor: kPrimaryColor,
        labelsStyle: kSubHeadingTextStyle.copyWith(color: kWhite),
        speedDialChildren: [
          SpeedDialChild(
              child: const Icon(Icons.water_drop),
              foregroundColor: Colors.white,
              backgroundColor: kPrimaryColor,
              label: 'Add Water',
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return const AddWater();
                    });
              }),
          SpeedDialChild(
              child: const Icon(Icons.hotel),
              foregroundColor: Colors.white,
              backgroundColor: kPrimaryColor,
              label: 'Add Sleep',
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return const AddSleep();
                    });
              }),
          SpeedDialChild(
              child: const Icon(Icons.local_dining),
              foregroundColor: Colors.white,
              backgroundColor: kPrimaryColor,
              label: 'Add Calories',
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return const AddCalories();
                    });
              })
        ],
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<AccelerometerEvent>(
          stream: null,
          builder: (context, snapshot) {
            return Container(
              decoration: const BoxDecoration(color: kPrimaryColor),
              child: SafeArea(
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Physical Health',
                    style: TextStyle(
                        color: kWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
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
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                            color: kGrey,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
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
                                            maximum: double.parse(blocProvider
                                                .userModel.goalWater),
                                            showLabels: false,
                                            showTicks: false,
                                            axisLineStyle: AxisLineStyle(
                                              thickness: 0.1,
                                              cornerStyle:
                                                  CornerStyle.bothCurve,
                                              color:
                                                  Colors.blue.withOpacity(0.3),
                                              thicknessUnit:
                                                  GaugeSizeUnit.factor,
                                            ),
                                            pointers: <GaugePointer>[
                                              RangePointer(
                                                value: (blocProvider
                                                            .dataModel.water) /
                                                        1000 +
                                                    0.0,
                                                cornerStyle:
                                                    CornerStyle.bothCurve,
                                                width: 0.1,
                                                sizeUnit: GaugeSizeUnit.factor,
                                                color: Colors.blue,
                                              ),
                                            ],
                                            annotations: <GaugeAnnotation>[
                                              GaugeAnnotation(
                                                positionFactor: 0.1,
                                                angle: 90,
                                                widget: Text('$overallGoal%',
                                                    style: kHeadingTextStyle
                                                        .copyWith(
                                                            color: Colors.red,
                                                            fontSize: 30.0)),
                                              ),
                                            ]),
                                        RadialAxis(
                                          startAngle: 90,
                                          endAngle: 90,
                                          radiusFactor: .83,
                                          canScaleToFit: false,
                                          minimum: 0,
                                          maximum: int.parse(blocProvider
                                                  .userModel.goalSteps) +
                                              0.0,
                                          showLabels: false,
                                          showTicks: false,
                                          axisLineStyle: AxisLineStyle(
                                            thickness: 0.1,
                                            cornerStyle: CornerStyle.bothCurve,
                                            color:
                                                Colors.green.withOpacity(0.3),
                                            thicknessUnit: GaugeSizeUnit.factor,
                                          ),
                                          pointers: <GaugePointer>[
                                            RangePointer(
                                              value:
                                                  blocProvider.dataModel.steps +
                                                      0.0,
                                              cornerStyle:
                                                  CornerStyle.bothCurve,
                                              width: 0.1,
                                              sizeUnit: GaugeSizeUnit.factor,
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                        RadialAxis(
                                          startAngle: 90,
                                          endAngle: 90,
                                          radiusFactor: .73,
                                          canScaleToFit: false,
                                          minimum: 0,
                                          maximum: int.parse(blocProvider
                                                  .userModel.goalSleep) +
                                              0.0,
                                          showLabels: false,
                                          showTicks: false,
                                          axisLineStyle: AxisLineStyle(
                                            thickness: 0.1,
                                            cornerStyle: CornerStyle.bothCurve,
                                            color: Colors.red.withOpacity(0.3),
                                            thicknessUnit: GaugeSizeUnit.factor,
                                          ),
                                          pointers: <GaugePointer>[
                                            RangePointer(
                                              value:
                                                  blocProvider.dataModel.sleep +
                                                      0.0,
                                              cornerStyle:
                                                  CornerStyle.bothCurve,
                                              width: 0.1,
                                              sizeUnit: GaugeSizeUnit.factor,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        RadialAxis(
                                          startAngle: 90,
                                          endAngle: 90,
                                          radiusFactor: .63,
                                          canScaleToFit: false,
                                          minimum: 0,
                                          maximum: double.parse(blocProvider
                                              .userModel.goalCalorie),
                                          showLabels: false,
                                          showTicks: false,
                                          axisLineStyle: AxisLineStyle(
                                            thickness: 0.1,
                                            cornerStyle: CornerStyle.bothCurve,
                                            color: const Color(0xffffdd80)
                                                .withOpacity(0.3),
                                            thicknessUnit: GaugeSizeUnit.factor,
                                          ),
                                          pointers: <GaugePointer>[
                                            RangePointer(
                                              value: blocProvider
                                                      .dataModel.calories +
                                                  0.0,
                                              cornerStyle:
                                                  CornerStyle.bothCurve,
                                              width: 0.1,
                                              sizeUnit: GaugeSizeUnit.factor,
                                              color: const Color(0xffffdd80),
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                                InkWell(
                                  child: DashboardTile(
                                    icon: Icons.water_drop,
                                    title: "Water: ",
                                    rangeTitle:
                                        "${blocProvider.dataModel.water / 1000}L/${int.parse(blocProvider.userModel.goalWater)}L",
                                    maxrange: double.parse(
                                        blocProvider.userModel.goalWater),
                                    interval: double.parse(
                                            blocProvider.userModel.goalWater) /
                                        4,
                                    valuerange:
                                        blocProvider.dataModel.water / 1000,
                                    colorshade1:
                                        Colors.blueAccent.withOpacity(0.4),
                                    colorshade2: Colors.blueAccent,
                                  ),
                                  onTap: () {
                                    changeScreen(
                                        context, const WaterDashboard());
                                  },
                                ),
                                InkWell(
                                  child: DashboardTile(
                                    icon: Icons.directions_run,
                                    title: "Steps: ",
                                    rangeTitle:
                                        "${blocProvider.dataModel.steps}/${int.parse(blocProvider.userModel.goalSteps)}",
                                    maxrange: double.parse(
                                        blocProvider.userModel.goalSteps),
                                    interval: double.parse(
                                            blocProvider.userModel.goalSteps) /
                                        4,
                                    valuerange:
                                        blocProvider.dataModel.steps + 0.0,
                                    colorshade1: Colors.green.withOpacity(0.4),
                                    colorshade2: Colors.green,
                                  ),
                                  onTap: () {
                                    changeScreen(
                                        context, const StepDashboard());
                                  },
                                ),
                                InkWell(
                                  child: DashboardTile(
                                    icon: Icons.hotel,
                                    title: "Sleep: ",
                                    rangeTitle:
                                        "${blocProvider.dataModel.sleep}hr/${int.parse(blocProvider.userModel.goalSleep)}h",
                                    maxrange: double.parse(
                                        blocProvider.userModel.goalSleep),
                                    interval: double.parse(
                                            blocProvider.userModel.goalSleep) /
                                        4,
                                    valuerange: double.parse(blocProvider
                                        .dataModel.sleep
                                        .toString()),
                                    colorshade1: Colors.red.withOpacity(0.4),
                                    colorshade2: Colors.red,
                                  ),
                                  onTap: () {
                                    changeScreen(
                                        context, const SleepDashboard());
                                  },
                                ),
                                InkWell(
                                  child: DashboardTile(
                                    icon: Icons.local_dining,
                                    title: "Calorie: ",
                                    rangeTitle:
                                        "${blocProvider.dataModel.calories}/${blocProvider.userModel.goalCalorie}",
                                    maxrange: double.parse(
                                        blocProvider.userModel.goalCalorie),
                                    interval: double.parse(blocProvider
                                            .userModel.goalCalorie) /
                                        4,
                                    valuerange:
                                        blocProvider.dataModel.calories + 0.0,
                                    colorshade1: Colors.yellow.withOpacity(0.4),
                                    colorshade2: Colors.yellow,
                                  ),
                                  onTap: () {
                                    changeScreen(
                                        context, const CalorieDashboard());
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          }),
    );
  }
}
