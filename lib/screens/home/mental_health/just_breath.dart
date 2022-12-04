import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swastha/Bloc/breath_cubit.dart';
import 'package:swastha/screens/home/mental_health/meditaion.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/constants.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/round_button.dart';
import 'package:swastha/widgets/setting_card.dart';

class JustBreath extends StatefulWidget {
  const JustBreath({Key? key}) : super(key: key);

  @override
  State<JustBreath> createState() => _JustBreathState();
}

class _JustBreathState extends State<JustBreath> with TickerProviderStateMixin {
  late AnimationController _scaffold;
  late AnimationController _logo;
  late Animation<Offset> _animation;
  late Animation<Offset> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _scaffold = AnimationController(
        vsync: this, value: 0.0, duration: const Duration(milliseconds: 1800));
    _logo = AnimationController(
        vsync: this, value: 0.0, duration: const Duration(milliseconds: 1800));
    _animation =
        Tween<Offset>(begin: const Offset(0, 0.25), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(parent: _scaffold, curve: Curves.easeOutQuart),
    );

    _logoAnimation =
        Tween<Offset>(begin: const Offset(0, 0.65), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: _logo,
        curve: const Interval(
          0.25,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    if (true) {
      _scaffold.forward();
      _logo.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<BreathCubit>(context);

    return SlideTransition(
      position: _animation,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.arrow_back),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 3,
                child: SlideTransition(
                  position: _logoAnimation,
                  child: SvgPicture.asset(
                    'assets/images/lotus.svg',
                    semanticsLabel: 'logo logo',
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Just Breath",
                textAlign: TextAlign.center,
                style: kHeadingTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Take time to breathe",
                textAlign: TextAlign.center,
                style: kSubHeadingTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  SettingsCard(
                      start: true,
                      title: Text(
                        'Duration',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      leading: const Icon(Icons.hourglass_bottom,
                          color: kPrimaryColor),
                      trailing: DropdownButton<Duration>(
                        underline: Container(),
                        items: kPresetTimers.map((preset) {
                          return DropdownMenuItem<Duration>(
                            value: preset,
                            child: Text(
                              "${preset.inMinutes} minutes",
                              textAlign: TextAlign.right,
                              style: kSubHeadingTextStyle,
                            ),
                          );
                        }).toList(),
                        value: blocProvider.duration,
                        onChanged: (value) {
                          blocProvider.setDuration(value as Duration);
                          setState(() {});
                        },
                      )),
                  SettingsCard(
                    title: Text(
                      'Play Sounds',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    leading: const Icon(Icons.music_note, color: kPrimaryColor),
                    trailing: cupertino.CupertinoSwitch(
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        blocProvider.togglePlaySounds();
                        setState(() {});
                      },
                      value: blocProvider.playSounds,
                    ),
                  ),
                  SettingsCard(
                    end: true,
                    title: Text(
                      'Zen Mode',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    leading: const Icon(
                      Icons.favorite,
                      color: kPrimaryColor,
                    ),
                    // ignore: missing_required_param
                    trailing: cupertino.CupertinoSwitch(
                      activeColor: kPrimaryColor,
                      onChanged: (_) {
                        blocProvider.toggleZenMode();
                        setState(() {});
                      },
                      value: blocProvider.isZenMode,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RoundedButton(
                    title: 'Begin',
                    colour: kPrimaryColor,
                    onPressed: () {
                      changeScreen(context, const Meditation());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
