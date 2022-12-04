class AudioModel {
  String audioPath;
  String title;
  String description;
  String duration;
  String cover;

  AudioModel(
      this.audioPath, this.title, this.description, this.duration, this.cover);
}

List<AudioModel> songList = [
  AudioModel('assets/audio/piano.mp3', 'Piano', 'Relaxation Piano', '2:38',
      'https://i.ytimg.com/vi/3oGCMGfHVaY/maxresdefault.jpg'),
  AudioModel('assets/audio/nature.mp3', 'Nature', 'Relaxation Piano', '1:48',
      'https://th.bing.com/th/id/OIP.dh9AWBD2vmtsJF6MLwxFdwE9DE?pid=ImgDet&rs=1'),
  AudioModel(
      'assets/audio/acousticMotivation.mp3',
      'Acoustic Motivation',
      'Relaxation Piano',
      '1:45',
      'https://th.bing.com/th/id/OIP.PtWo287dWmehtXWUehUSRgHaE7?pid=ImgDet&rs=1'),
  AudioModel('assets/audio/sweetly.mp3', 'Sweetly', 'Relaxation Piano', '1:44',
      'https://th.bing.com/th/id/OIP.r_eF4DYWOo6OU4YCqvmZ3AHaHa?w=214&h=214&c=7&r=0&o=5&pid=1.7'),
  AudioModel(
      'assets/audio/InTheForest.mp3',
      'In The Forest',
      'Relaxation Piano',
      '1:59',
      'https://th.bing.com/th/id/OIP.peQquo_7TOWOgN_c1CDHPAHaER?w=312&h=180&c=7&r=0&o=5&pid=1.7'),
  AudioModel(
      'assets/audio/UpliftingPianoIs.mp3',
      'Uplifting Piano Is',
      'Relaxation Piano',
      '1:10',
      'https://th.bing.com/th?q=Uplifting+Paintings')
];
