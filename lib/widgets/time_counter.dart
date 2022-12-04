import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:swastha/models/quote.dart';
import 'package:swastha/screens/home/mental_health/completion_screen.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/extensions.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/utils/utils.dart';
import 'package:swastha/widgets/countdown_circle.dart';
import 'package:swastha/widgets/nash_breathe.dart';
import 'package:swastha/widgets/round_button.dart';

class TimerCountdown extends StatefulWidget {
  /// How many seconds to countdown from
  final Duration duration;
  final bool zenMode;
  final bool playSounds;
  const TimerCountdown(this.duration,
      {required this.zenMode, required this.playSounds, Key? key})
      : super(key: key);

  @override
  State<TimerCountdown> createState() => _TimerCountdown();
}

class _TimerCountdown extends State<TimerCountdown> {
  late Stopwatch _stopwatch;
  // The thing that ticks
  late Timer _timer;
  // Keeps track of how much time has elapsed
  late Duration _elapsedTime;
  // This string that is displayed as the countdown timer
  String _display = 'Be at peace';

  // Play a sound
  void _playSound() {
    if (widget.playSounds) {
      final assetsAudioPlayer = AssetsAudioPlayer();
      assetsAudioPlayer.open(
        Audio("assets/audio/gong.mp3"),
        autoStart: true,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _playSound();
    _elapsedTime = widget.duration;
    _stopwatch = Stopwatch();
    // start();
    start();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _stopwatch.stop();
  }

  // This will start the Timer
  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }
    // if (_timer != null) {
    //   if (_timer.isActive) return;
    // }
    _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
      // update display
      setState(() {
        var diff = (_elapsedTime - _stopwatch.elapsed);
        _display = diff.clockFmt();
        if (diff.inMilliseconds <= 0) {
          _playSound();
          stop(cancelled: false);
        }
      });
    });
  }

  // This will pause the timer
  void pause() {
    if (!_stopwatch.isRunning) {
      return;
    }
    setState(() {
      _stopwatch.stop();
    });
  }

  // This will stop the timer
  void stop({bool cancelled = true}) {
    if (!_stopwatch.isRunning) {
      return;
    }
    setState(() {
      _timer.cancel();
      _stopwatch.stop();
    });

    if (cancelled) {
      Navigator.pop(context);
    } else {
      Quote quote = getQuote();
      changeScreen(context, CompletionScreen(quote: quote));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        widget.zenMode
            ? const Expanded(child: CupertinoBreathe())
            : Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox.expand(
                      child: CountdownCircle(
                        duration: widget.duration,
                      ),
                    ),
                    Text(
                      _display,
                      style: kHeadingTextStyle,
                    ),
                  ],
                ),
              ),
        RoundedButton(
            title: 'End', colour: kPrimaryColor, onPressed: () => stop())
      ],
    );
  }
}
