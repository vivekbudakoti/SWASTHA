import 'package:flutter_bloc/flutter_bloc.dart';

enum BreathState { init, loaded }

class BreathCubit extends Cubit<BreathState> {
  bool isZenMode = false;
  bool playSounds = false;
  Duration duration = const Duration(minutes: 5);
  BreathCubit() : super(BreathState.init);

  void toggleZenMode() {
    isZenMode = !isZenMode;
    emit(BreathState.loaded);
  }

  void togglePlaySounds() {
    playSounds = !playSounds;
    emit(BreathState.loaded);
  }

  void setDuration(Duration duration) {
    this.duration = duration;
    emit(BreathState.loaded);
  }
}
