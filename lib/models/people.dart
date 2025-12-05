class People {
  final String name;
  final String height;

  People({required this.name, required this.height});

  factory People.fromJson(Map<String, dynamic> json) {
    return People(name: json['name'], height: json['height']);
  }
}
