class UserCls {
  String email;
  String nama;
  String alamat;
  String noTelp;
  // bool isAdmin;

  UserCls({
    required this.email,
    required this.nama,
    required this.alamat,
    required this.noTelp,
    // required this.isAdmin
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "nama": nama,
      "alamat": alamat,
      "noTelp": noTelp,
      // "isAdmin": isAdmin
    };
  }

  factory UserCls.fromJson(Map<String, dynamic> json) {
    return UserCls(
      email: json['email'],
      nama: json['nama'],
      alamat: json['alamat'],
      noTelp: json['noTelp'],
      // isAdmin: json['isAdmin']
    );
  }
}