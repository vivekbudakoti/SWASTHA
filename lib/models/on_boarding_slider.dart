class SliderModel {
  String imageAssetPath;
  String title;
  String description;

  SliderModel(
      {required this.imageAssetPath,
      required this.title,
      required this.description});
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = [];
  slides.add(SliderModel(
      imageAssetPath: 'assets/images/upset.png',
      title: 'Mental Health',
      description: 'Never be a slave of your own thoughts'));
  slides.add(SliderModel(
      imageAssetPath: 'assets/images/exercise.gif',
      title: 'Physical Health',
      description: 'Just Keep Moving'));
  slides.add(SliderModel(
      imageAssetPath: 'assets/images/meditation.gif',
      title: 'Swastha',
      description: 'Physical and Mental Health Companion'));

  return slides;
}
