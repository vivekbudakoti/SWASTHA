import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastha/Bloc/breath_cubit.dart';
import 'package:swastha/widgets/time_counter.dart';
class Meditation extends StatelessWidget {
  const Meditation({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
        final blocProvider = BlocProvider.of<BreathCubit>(context);

    return Scaffold(
     
      body: Center(
        child: TimerCountdown(
          blocProvider.duration,
          zenMode: blocProvider.isZenMode,
          playSounds: blocProvider.playSounds,
        ),
      ),
    );
  }
}