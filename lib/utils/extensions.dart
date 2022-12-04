extension DurationFormats on Duration {
  /// Converts duration into H:MM:SS format
  String clockFmt() {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = (inSeconds).remainder(60).toString().padLeft(2, '0');

    if (inHours >= 1) {
      return ('$hours:$minutes:$seconds');
    }
    return ('$minutes:$seconds');
  }
}
