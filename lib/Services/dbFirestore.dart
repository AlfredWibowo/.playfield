import 'package:project_ambw/class/CUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {

  //user
    static CollectionReference tbUser = FirebaseFirestore.instance.collection('tbUser');

  static Stream<QuerySnapshot> getDataUser() {
    return tbUser.snapshots();
  }

  static Stream<DocumentSnapshot> getUserByEmail(String email) {
    return tbUser.doc(email).snapshots();
  }

  static Future<void> addDataUser({required UserCls user}) async {
    DocumentReference doc = tbUser.doc(user.email);

    await doc
        .set(user.toJson())
        .whenComplete(() => print('Data User Berhasil di add'))
        .catchError((e) => print(e));
  }

  static Future<void> editDataUser({required UserCls user}) async {
    DocumentReference doc = tbUser.doc(user.email);

    await doc
        .update(user.toJson())
        .whenComplete(() => print('Data User Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteDataUser({required UserCls user}) async {
    DocumentReference doc = tbUser.doc(user.email);

    await doc
        .delete()
        .whenComplete(() => print('Data User Berhasil di add'))
        .catchError((e) => print(e));
  }

  //transaksi
  static CollectionReference tbTransaksi =
    FirebaseFirestore.instance.collection('tbTransaksi');

  static Stream<QuerySnapshot> getDataTransaksi() {
    return tbTransaksi.snapshots();
  }

  //lapangan
  static CollectionReference tbLapangan =
    FirebaseFirestore.instance.collection('tbLapangan');

  static Stream<QuerySnapshot> getDataLapangan() {
    return tbLapangan.snapshots();
  }

  static Stream<QuerySnapshot> getDataLapanganBy(String field, String value) {
    if (field == 'kota') {
      return tbLapangan
        .where('kota', isEqualTo: value)
        .snapshots();
    }
    return tbLapangan.snapshots();
  }
}
