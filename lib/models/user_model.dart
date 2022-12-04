class UserModel {
  final String uid;
  final String mobile;
  String name;
  final String profileURL;
  final String gender;
  final String height;
  final String weight;
  final String age;
  String bmi;
  String goalWater;
  String goalSteps;
  String goalSleep;
  String goalCalorie;

  UserModel(
      this.uid,
      this.mobile,
      this.name,
      this.profileURL,
      this.gender,
      this.height,
      this.weight,
      this.age,
      this.bmi,
      this.goalWater,
      this.goalSteps,
      this.goalSleep,
      this.goalCalorie);

  Map<String, String> toJSON() {
    return {
      'uid': uid,
      'mobile': mobile,
      'name': name,
      'profileURL': profileURL,
      'gender': gender,
      'height': height,
      'weight': weight,
      'age': age,
      'bmi': bmi,
      'goalWater': goalWater,
      'goalSteps': goalSteps,
      'goalSleep': goalSleep,
      'goalCalorie': goalCalorie,
    };
  }
}

UserModel userModelFromJSON(Map<String, dynamic> data) {
  return UserModel(
    data['uid'],
    data['mobile'],
    data['name'],
    data['profileURL'],
    data['gender'],
    data['height'],
    data['weight'],
    data['age'],
    data['bmi'],
    data['goalWater'],
    data['goalSteps'],
    data['goalSleep'],
    data['goalCalorie'],
  );
}
