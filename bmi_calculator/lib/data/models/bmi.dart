class Bmi {
  final int? id;
  final DateTime date;
  final String gender;
  final int age;
  final double bmi;
  final double bmiPrime;
  final int categoryNumber;
  final String category;

  const Bmi({
    this.id,
    required this.date,
    required this.gender,
    required this.age,
    required this.bmi,
    required this.bmiPrime,
    required this.categoryNumber,
    required this.category,
  });

  factory Bmi.fromMap(Map<String, dynamic> map) {
    return Bmi(
        id: map['_id'],
        date: DateTime.parse(map['date']),
        gender: map['gender'],
        age: map['age'],
        bmi: map['bmi'],
        bmiPrime: map['bmi_prime'],
        categoryNumber: map['category_number'],
        category: map['category']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (id != null) {
      map['_id'] = id;
    }
    map['date'] = date.toIso8601String();
    map['gender'] = gender;
    map['age'] = age;
    map['bmi'] = bmi;
    map['bmi_prime'] = bmiPrime;
    map['category_number'] = categoryNumber;
    map['category'] = category;

    return map;
  }
}
