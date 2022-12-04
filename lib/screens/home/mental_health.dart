import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swastha/screens/home/mental_health/just_breath.dart';
import 'package:swastha/screens/home/mental_health/resources.dart';
import 'package:swastha/screens/home/mental_health/music_player.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/round_button.dart';

class MentalHealth extends StatelessWidget {
  const MentalHealth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: kPrimaryColor),
      child: SafeArea(
          child: Column(children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Mental health',
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
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                SvgPicture.asset(
                  'assets/images/lotus.svg',
                  semanticsLabel: 'logo logo',
                  color: kPrimaryColor,
                  height: 240,
                ),
                const SizedBox(
                  height: 120,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/meditation.gif',
                                      height: 150,
                                    ),
                                    Text(
                                      'Just Breath',
                                      style: kHeadingTextStyle.copyWith(
                                          fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          changeScreen(context, const JustBreath());
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/upset.png',
                                      height: 150,
                                    ),
                                    Text(
                                      'Relax Music',
                                      style: kHeadingTextStyle.copyWith(
                                          fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          changeScreen(context, const MusicPlayer());
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 60,
                ),
                RoundedButton(
                    title: 'Resources',
                    colour: kPrimaryColor,
                    onPressed: () {
                      changeScreen(context, Resources());
                    })
              ],
            ),
          ),
        )),
      ])),
    );
  }
}
