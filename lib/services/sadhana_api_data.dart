class Sadhana {
  String fromDate;
  String toDate;
  List<Map<String, dynamic>> sadhanaData;

  Sadhana(
      {required this.fromDate,
      required this.toDate,
      required this.sadhanaData});

  factory Sadhana.fromJson(Map<String, dynamic> json) {
    return Sadhana(
        fromDate: json['from_date'],
        toDate: json['to_date'],
        sadhanaData: List<Map<String, dynamic>>.from(json['sadhana']));
  }
}
