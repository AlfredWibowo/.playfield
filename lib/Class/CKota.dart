class Kota {
  String nama;
  String latitude;
  String longitude;

  Kota({
    required this.nama,
    required this.latitude,
    required this.longitude
  });

  factory Kota.fromJson(Map<String, dynamic> json) {
    return Kota(
      nama: json['city'], 
      latitude: json['lat'], 
      longitude: json['lng']
    );
  }
}