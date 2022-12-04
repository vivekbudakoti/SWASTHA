import 'package:flutter/material.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/round_button.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({Key? key}) : super(key: key);

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  @override
  Widget build(BuildContext context) {
    int goal = 3;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            title: const Text("Select Goal: "),
                            actions: [
                              TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: "Enter your goal"),
                              ),
                              Center(
                                child: RoundedButton(
                                    title: "Done",
                                    colour: kPrimaryColor,
                                    onPressed: () {
                                      setState(() {
                                        goal = 3;
                                      });
                                      Navigator.pop(context);
                                    }),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 142, 120, 255),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: 100,
                    width: 200,
                    child: Center(
                        child: Text(
                      'Goal : ${goal}L',
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    )),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                  child: SizedBox(
                child: SfRadialGauge(
                    enableLoadingAnimation: true,
                    axes: <RadialAxis>[
                      RadialAxis(
                          canScaleToFit: false,
                          minimum: 0,
                          maximum: 100,
                          showLabels: false,
                          showTicks: false,
                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color: Color.fromARGB(255, 218, 216, 230),
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          pointers: const <GaugePointer>[
                            RangePointer(
                              value: 85.0,
                              cornerStyle: CornerStyle.bothCurve,
                              width: 0.2,
                              sizeUnit: GaugeSizeUnit.factor,
                            ),
                          ],
                          annotations: const <GaugeAnnotation>[
                            GaugeAnnotation(
                              positionFactor: 0.1,
                              angle: 90,
                              widget: Text('2.5 L left to drink',
                                  style: TextStyle(fontSize: 24)),
                            )
                          ])
                    ]),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
