import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastha/Bloc/auth_cubit.dart';
import 'package:swastha/screens/home.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/round_button.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthCubit>(context);
    final controllerName = TextEditingController();
    controllerName.text = blocProvider.userModel.name;
    final controllerBmi = TextEditingController();
    controllerBmi.text = blocProvider.userModel.bmi;
    final controllerWaterG = TextEditingController();
    controllerWaterG.text = blocProvider.userModel.goalWater;
    final controllerStepG = TextEditingController();
    controllerStepG.text = blocProvider.userModel.goalSteps;
    final controllerSleepG = TextEditingController();
    controllerSleepG.text = blocProvider.userModel.goalSleep;
    final controllerCalorieG = TextEditingController();
    controllerCalorieG.text = blocProvider.userModel.goalCalorie;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            child: Form(
          key: formKey,
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'My Account',
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    CircleAvatar(
                      radius: 70.0,
                      backgroundImage:
                          Image.network(blocProvider.userModel.profileURL)
                              .image,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      blocProvider.userModel.name,
                      style: kHeadingTextStyle,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      blocProvider.userModel.mobile,
                      style: kSubHeadingTextStyle,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    RoundedButton(
                        title: "Save Changes",
                        colour: kPrimaryColor,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            showProgressDialog(context);
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(blocProvider.userModel.uid)
                                .update({
                              'name': controllerName.text.toString(),
                              'bmi': controllerBmi.text.toString(),
                              'goalWater': controllerWaterG.text.toString(),
                              'goalSteps': controllerStepG.text.toString(),
                              'goalSleep': controllerSleepG.text.toString(),
                              'goalCalorie': controllerCalorieG.text.toString(),
                            }).then((value) {
                              blocProvider.updateUserDetails(
                                  controllerName.text.toString(),
                                  controllerBmi.text.toString(),
                                  controllerWaterG.text.toString(),
                                  controllerStepG.text.toString(),
                                  controllerSleepG.text.toString(),
                                  controllerCalorieG.text.toString());

                              Navigator.pop(context);

                              changeScreenReplacement(context, const Home());
                            });
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextFormField(
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Name';
                          }
                          if (value.length < 3) {
                            return 'Name should be atleast of 3 letter';
                          }
                          return null;
                        }),
                        controller: controllerName,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your name',
                            label: const Text("Name"),
                            counter: const Offstage()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextFormField(
                        controller: controllerBmi,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Please Enter BMI';
                          }

                          return null;
                        }),
                        keyboardType: TextInputType.phone,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Enter BMI",
                            label: const Text("BMI"),
                            counter: const Offstage()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextFormField(
                        controller: controllerWaterG,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Water Goal';
                          }

                          return null;
                        }),
                        keyboardType: TextInputType.phone,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Enter Water Goal",
                            label: const Text("Water Goal"),
                            counter: const Offstage()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextFormField(
                        controller: controllerStepG,
                        keyboardType: TextInputType.phone,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Step Goal';
                          }

                          return null;
                        }),
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Enter Step Goal",
                            label: const Text("Step Goal"),
                            counter: const Offstage()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextFormField(
                        controller: controllerSleepG,
                        keyboardType: TextInputType.phone,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Sleep Goal';
                          }

                          return null;
                        }),
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Enter Sleep Goal",
                            label: const Text("Sleep Goal"),
                            counter: const Offstage()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextFormField(
                        controller: controllerCalorieG,
                        keyboardType: TextInputType.phone,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Calorie Goal';
                          }

                          return null;
                        }),
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Enter Calorie Goal",
                            label: const Text("Calorie Goal"),
                            counter: const Offstage()),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ]),
        )),
      ),
    );
  }
}

class EditDialog extends StatelessWidget {
  final String title;
  final String tlabel;
  final VoidCallback onupdate;
  const EditDialog(
      {Key? key,
      required this.title,
      required this.tlabel,
      required this.onupdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            decoration: kTextFieldDecoration.copyWith(
                label: Text(tlabel), counter: const Offstage()),
          ),
        ),
        Center(
          child: RoundedButton(
              title: "Update", colour: kPrimaryColor, onPressed: onupdate),
        )
      ],
    );
  }
}
