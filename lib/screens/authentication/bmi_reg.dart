import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastha/Bloc/auth_cubit.dart';
import 'package:swastha/models/user_model.dart';
import 'package:swastha/screens/authentication/user_detail.dart';
import 'package:swastha/screens/home.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/card.dart';
import 'package:swastha/widgets/circle_button.dart';
import 'package:swastha/widgets/round_button.dart';

class BMIReg extends StatefulWidget {
  final String? name;
  final String? profileURL;
  const BMIReg({Key? key, this.name, this.profileURL}) : super(key: key);

  @override
  State<BMIReg> createState() => _BMIReg();
}

late double _bmi;

class _BMIReg extends State<BMIReg> {
  double newvalue = 10.0;
  Color activeColor = kPrimaryColor;
  bool selectedMale = false;
  bool selectedFemale = false;
  double age = 18.0;
  double weight = 50.0;
  int height = 170;
  @override
  Widget build(BuildContext context) {
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
                            "Height (in cm)",
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
                                    "Weight (in Kg)",
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
                    BlocConsumer<AuthCubit, Authstate>(
                      listener: ((context, state) {
                        if (state == Authstate.loggedIn) {
                          changeScreenReplacement(context, const Home());
                        } else if (state == Authstate.unRegistered) {
                          changeScreenReplacement(context, const UserDetail());
                        } else if (state == Authstate.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Some Error Occured'),
                            ),
                          );
                        }
                      }),
                      builder: ((context, state) {
                        if (state == Authstate.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return RoundedButton(
                            title: "Verify",
                            colour: kPrimaryColor,
                            onPressed: () {
                              showProgressDialog(context);

                              final auth = FirebaseAuth.instance.currentUser;

                              if (widget.name != null) {
                                BlocProvider.of<AuthCubit>(context).register(
                                    UserModel(
                                        auth!.uid,
                                        auth.phoneNumber!,
                                        widget.name!,
                                        widget.profileURL!,
                                        selectedMale ? 'Male' : 'Female',
                                        height.toString(),
                                        weight.toString(),
                                        age.toString(),
                                        calculateBMI(),
                                        '3',
                                        getGaolSteps(),
                                        getGaolSleep(),
                                        getGoalCalorie()));
                              } else {
                                BlocProvider.of<AuthCubit>(context).register(
                                    UserModel(
                                        auth!.uid,
                                        auth.email!,
                                        auth.displayName!,
                                        auth.photoURL!,
                                        selectedMale ? 'Male' : 'Female',
                                        height.toString(),
                                        weight.toString(),
                                        age.toString(),
                                        calculateBMI(),
                                        '3',
                                        getGaolSteps(),
                                        getGaolSleep(),
                                        getGoalCalorie()));
                              }
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

  String getGaolSteps() {
    if (_bmi >= 25) {
      return '9000';
    } else if (_bmi > 18.5) {
      return '6000';
    } else {
      return '4000';
    }
  }

  String getGaolSleep() {
    if (age < 18) {
      return '9';
    } else if (age >= 18 && age <= 30) {
      return '8';
    }
    return '7';
  }

  String getGoalCalorie() {
    if (selectedMale) {
      if (age < 30) {
        return '2600';
      } else if (age >= 30 && age <= 50) {
        return '2400';
      } else {
        return '2200';
      }
    } else {
      if (age < 30) return '2200';
      if (age >= 30 && age <= 50) {
        return '2000';
      } else {
        return '1900';
      }
    }
  }
}
