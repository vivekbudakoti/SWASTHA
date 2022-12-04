import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastha/Bloc/auth_cubit.dart';
import 'package:swastha/screens/home.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/card.dart';
import 'package:swastha/widgets/circle_button.dart';
import 'package:swastha/widgets/round_button.dart';

class BMICalculator extends StatefulWidget {
  final String name;
  final String profileURL;
  const BMICalculator({Key? key, required this.name, required this.profileURL})
      : super(key: key);

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

late double _bmi;

class _BMICalculatorState extends State<BMICalculator> {
  double newvalue = 10.0;
  Color activeColor = kPrimaryColor;
  bool selectedMale = false;
  bool selectedFemale = false;
  double age = 18.0;
  double weight = 50.0;
  int height = 170;
  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthCubit>(context);
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
              'BMI Calculator',
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        child: Row(
                      children: <Widget>[
                        Expanded(
                            child: UserCard(
                          colour: selectedMale ? kPrimaryColor : kWhite,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.male,
                                color: selectedMale ? kWhite : kPrimaryColor,
                                size: 40.0,
                              ),
                              Text(
                                "Male",
                                style: TextStyle(
                                    color:
                                        selectedMale ? kWhite : kPrimaryColor,
                                    fontSize: 20.0),
                              )
                            ],
                          ),
                          onPress: () {
                            setState(() {
                              activeColor = kActiveSelect;
                              selectedMale = true;
                              selectedFemale = false;
                            });
                          },
                        )),
                        Expanded(
                            child: UserCard(
                          colour: selectedFemale ? kPrimaryColor : kWhite,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.female,
                                color: selectedFemale ? kWhite : kPrimaryColor,
                                size: 40.0,
                              ),
                              Text(
                                "Female",
                                style: TextStyle(
                                    color:
                                        selectedFemale ? kWhite : kPrimaryColor,
                                    fontSize: 20.0),
                              )
                            ],
                          ),
                          onPress: () {
                            setState(() {
                              activeColor = kActiveSelect;
                              selectedMale = false;
                              selectedFemale = true;
                            });
                          },
                        )),
                      ],
                    )),
                    Expanded(
                        child: UserCard(
                      colour: kWhite,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Height",
                            style:
                                TextStyle(fontSize: 20.0, color: kPrimaryColor),
                          ),
                          Text(
                            height.toString(),
                            style: const TextStyle(
                                fontSize: 15.0, color: kPrimaryColor),
                          ),
                          Slider(
                              activeColor: kPrimaryColor,
                              value: height.toDouble(),
                              min: 120.0,
                              max: 220.0,
                              onChanged: (value) {
                                setState(() {
                                  height = value.round();
                                });
                              })
                        ],
                      ),
                      onPress: () {},
                    )),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: UserCard(
                            colour: kWhite,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Age",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  age.toString(),
                                  style: const TextStyle(
                                      fontSize: 50.0, color: kPrimaryColor),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleButton(
                                          icon: Icons.add,
                                          onpressed: () {
                                            setState(() {
                                              age++;
                                            });
                                          }),
                                      const SizedBox(width: 10),
                                      CircleButton(
                                          icon: Icons.remove,
                                          onpressed: () {
                                            setState(() {
                                              age--;
                                            });
                                          })
                                    ],
                                  ),
                                )
                              ],
                            ),
                            onPress: () {},
                          )),
                          Expanded(
                            child: UserCard(
                              colour: kWhite,
                              cardChild: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "Weight",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    weight.toString(),
                                    style: const TextStyle(
                                        fontSize: 50.0, color: kPrimaryColor),
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CircleButton(
                                            icon: Icons.add,
                                            onpressed: () {
                                              setState(() {
                                                weight++;
                                              });
                                            }),
                                        const SizedBox(width: 10),
                                        CircleButton(
                                          icon: Icons.remove,
                                          onpressed: () {
                                            setState(() {
                                              weight--;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              onPress: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 64.0),
                      child: RoundedButton(
                          title: 'Calculate BMI',
                          colour: kPrimaryColor,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Center(
                                      child: Text(
                                        'Your BMI Is',
                                        style: kHeadingTextStyle,
                                      ),
                                    ),
                                    content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            calculateBMI().toUpperCase(),
                                            style:
                                                kSubHeadingTextStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 36),
                                          ),
                                          Text(
                                            getResult(),
                                            style: kHeadingTextStyle,
                                          ),
                                          Text(
                                            getInterpretation(),
                                            textAlign: TextAlign.center,
                                            style: kNormalTextStyle,
                                          ),
                                          RoundedButton(
                                              title: "Update BMI info.",
                                              colour: kPrimaryColor,
                                              onPressed: () {
                                                showProgressDialog(context);
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(blocProvider
                                                        .userModel.uid)
                                                    .update({
                                                  'bmi': calculateBMI(),
                                                }).then((value) {
                                                  blocProvider.updatebmi(
                                                      calculateBMI());
                                                  changeScreenReplacement(
                                                      context, const Home());
                                                });
                                              })
                                        ]),
                                  );
                                });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    } else if (_bmi >= 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more.';
    }
  }
}
