import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastha/Bloc/auth_cubit.dart';
import 'package:swastha/screens/authentication/bmi_reg.dart';
import 'package:swastha/screens/authentication/verify_otp.dart';
import 'package:swastha/screens/home.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/circular_login_component.dart';
import 'package:swastha/widgets/round_button.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phone = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<AuthCubit, Authstate>(
              listener: ((context, state) {
                if (state == Authstate.loggedIn) {
                  changeScreenReplacement(context, const Home());
                }
                if (state == Authstate.otpSend) {
                  changeScreenReplacement(context, const VerifyOTP());
                } else if (state == Authstate.unRegistered) {
                  changeScreenReplacement(context, const BMIReg());
                } else if (state == Authstate.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Some Error Occured'),
                    ),
                  );
                }
              }),
              builder: (context, state) {
                return Column(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft, child: BackButton()),
                    const SizedBox(
                      height: 18,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Get Into Swastha',
                      style: kHeadingTextStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Get YourSelf In Swastha",
                      style: kSubHeadingTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15.0),
                        child: TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter A Number';
                            }
                            if (value.length < 10) {
                              return 'Phone Number Should be 10';
                            }
                            return null;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: const Icon(
                                Icons.smartphone,
                                color: kPrimaryColor,
                              ),
                              counter: const Offstage(),
                              hintText: 'Enter Your Mobile Number',
                              labelText: 'Enter Your Mobile Number'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      "Sign in with",
                      style: kSubHeadingTextStyle,
                    ),
                    CircularLoginOption(
                      icon: Image.asset('assets/images/google.png'),
                      onTap: () {
                        showProgressDialog(context);

                        BlocProvider.of<AuthCubit>(context).signInWithGoogle();
                      },
                    ),
                    RoundedButton(
                        title: 'Continue',
                        colour: kPrimaryColor,
                        onPressed: () {
                          String phonenum = "+91${phone.text}";
                          if (formKey.currentState!.validate()) {
                            showProgressDialog(context);

                            BlocProvider.of<AuthCubit>(context)
                                .sendOTP(phonenum);
                          }
                        }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
