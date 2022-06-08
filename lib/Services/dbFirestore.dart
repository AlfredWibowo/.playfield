import 'package:project_ambw/class/CUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference tbUser = FirebaseFirestore.instance.collection('tbUser');
CollectionReference tbTransaksi = FirebaseFirestore.instance.collection('tbTransaksi');

class FirestoreDatabase {
  //user
  static Stream<QuerySnapshot> getDataUser() {
    return tbUser.snapshots();
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
  static Stream<QuerySnapshot> getDataTransaksi() {
    return tbTransaksi.snapshots();
  }

  
}