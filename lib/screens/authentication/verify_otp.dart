import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastha/Bloc/auth_cubit.dart';
import 'package:swastha/screens/home.dart';
import 'package:swastha/screens/authentication/user_detail.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/round_button.dart';

class VerifyOTP extends StatefulWidget {
  static const String id = 'VerifyPassword';
  const VerifyOTP({Key? key}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  @override
  Widget build(BuildContext context) {
    TextEditingController otp = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Align(alignment: Alignment.topLeft, child: BackButton()),
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
                  'Verification',
                  style: kHeadingTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter your OTP code number",
                  style: kSubHeadingTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextFormField(
                    maxLength: 6,
                    keyboardType: TextInputType.phone,
                    decoration: kTextFieldDecoration.copyWith(
                        counter: const Offstage()),
                  ),
                ),
                const SizedBox(
                  height: 18,
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
                    return RoundedButton(
                        title: "Verify",
                        colour: kPrimaryColor,
                        onPressed: () {
                          showProgressDialog(context);

                          BlocProvider.of<AuthCubit>(context)
                              .verifyOTP(otp.text);
                        });
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
