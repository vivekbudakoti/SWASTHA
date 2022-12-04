class WaterModel {
  double goalwater;
  double takenwater;

  WaterModel(this.goalwater, this.takenwater);
  Map<String, dynamic> toMap() {
    return {'goalwater': goalwater, 'takenwater': takenwater};
  }
}
