class DataModel {
  String date;
  int day;
  int water;
  int calories;
  int steps;
  int sleep;

  DataModel(
      this.date, this.day, this.water, this.calories, this.sleep, this.steps);
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'day': day,
      'water': water,
      'calories': calories,
      'steps': steps,
      'sleep': sleep
    };
  }
}

DataModel dataModelFromJson(Map<String, dynamic> data) {
  return DataModel(data['date'], data['day'], data['water'], data['calories'],
      data['sleep'], data['steps']);
}
