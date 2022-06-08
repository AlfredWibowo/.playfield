class UserCls {
  String email;
  String nama;
  String alamat;
  String noTelp;

  UserCls({
    required this.email,
    required this.nama,
    required this.alamat,
    required this.noTelp,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "nama": nama,
      "alamat": alamat,
      "noTelp": noTelp
    };
  }

  factory UserCls.fromJson(Map<String, dynamic> json) {
    return UserCls(
      email: json['email'],
      nama: json['nama'],
      alamat: json['alamat'],
      noTelp: json['noTelp']
    );
  }
}