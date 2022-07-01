class City {
  String nama;
  String latitude;
  String longitude;

  City({
    required this.nama,
    required this.latitude,
    required this.longitude
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      nama: json['city'], 
      latitude: json['lat'], 
      longitude: json['lng']
    );
  }
}