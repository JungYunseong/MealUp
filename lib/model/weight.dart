class WeightEntry {
  int? id;
  String date;
  double weight;

  WeightEntry({this.id, required this.date, required this.weight});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'weight': weight,
    };
  }

  static WeightEntry fromMap(Map<String, dynamic> map) {
    return WeightEntry(
      id: map['id'],
      date: map['date'],
      weight: map['weight'],
    );
  }
}
