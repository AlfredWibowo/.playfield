class City {
  String name;
  String latitude;
  String longitude;

  City({
    required this.name,
    required this.latitude,
    required this.longitude
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['city'], 
      latitude: json['lat'], 
      longitude: json['lng']
    );
  }
}