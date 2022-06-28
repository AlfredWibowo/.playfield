import 'package:project_ambw/class/CUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumerFirestoreDatabase {
  //user
  static CollectionReference tbConsumer =
      FirebaseFirestore.instance.collection('tbConsumer');

  static Stream<QuerySnapshot> getData() {
    return tbConsumer.snapshots();
  }

  static Stream<DocumentSnapshot> getDataByEmail(String email) {
    return tbConsumer.doc(email).snapshots();
  }

  static Future<void> addData({required Consumer consumer}) async {
    DocumentReference doc = tbConsumer.doc(consumer.email);
    await doc
        .set(consumer.toJson())
        .whenComplete(() => print('Data Consumer Berhasil di add'))
        .catchError((e) => print(e));
  }

  static Future<void> editData({required Consumer consumer}) async {
    DocumentReference doc = tbConsumer.doc(consumer.email);

    await doc
        .update(consumer.toJson())
        .whenComplete(() => print('Data Consumer Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> editNama({required String email, required String nama}) async {
    DocumentReference doc = tbConsumer.doc(email);
    await doc
        .update({"nama": nama })
        .whenComplete(() => print('Data Consumer Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> editAlamat({required String email, required String alamat}) async {
    DocumentReference doc = tbConsumer.doc(email);
    await doc
        .update({"alamat": alamat })
        .whenComplete(() => print('Data Consumer Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> editTelp({required String email, required String telp}) async {
    DocumentReference doc = tbConsumer.doc(email);
    await doc
        .update({"noTelp": telp })
        .whenComplete(() => print('Data Consumer Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> editPP({required String email, required String fileName}) async {
    DocumentReference doc = tbConsumer.doc(email);
    await doc
        .update({"profilePicture": fileName })
        .whenComplete(() => print('Data Consumer Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData({required Consumer consumer}) async {
    DocumentReference doc = tbConsumer.doc(consumer.email);

    await doc
        .delete()
        .whenComplete(() => print('Data Consumer Berhasil di delete'))
        .catchError((e) => print(e));
  }
}

class AdminFirestoreDatabase {
  //admin
  static CollectionReference tbAdmin =
      FirebaseFirestore.instance.collection('tbAdmin');

  static Stream<QuerySnapshot> getData() {
    return tbAdmin.snapshots();
  }

  static Stream<DocumentSnapshot> getDataByEmail(String email) {
    return tbAdmin.doc(email).snapshots();
  }

  static Future<void> addData({required Admin admin}) async {
    DocumentReference doc = tbAdmin.doc(admin.email);
    await doc
        .set(admin.toJson())
        .whenComplete(() => print('Data Admin Berhasil di add'))
        .catchError((e) => print(e));
  }

  static Future<void> editData({required Admin admin}) async {
    DocumentReference doc = tbAdmin.doc(admin.email);

    await doc
        .update(admin.toJson())
        .whenComplete(() => print('Data Admin Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData({required Admin admin}) async {

    DocumentReference doc = tbAdmin.doc(admin.email);

    await doc
        .delete()
        .whenComplete(() => print('Data Admin Berhasil di delete'))
        .catchError((e) => print(e));
  }

  static Future<void> editNama({required String email, required String nama}) async {
    DocumentReference doc = tbAdmin.doc(email);
    await doc
        .update({"nama": nama })
        .whenComplete(() => print('Data Admin Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> editAlamat({required String email, required String alamat}) async {
    DocumentReference doc = tbAdmin.doc(email);
    await doc
        .update({"alamat": alamat })
        .whenComplete(() => print('Data Admin Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> editTelp({required String email, required String telp}) async {
    DocumentReference doc = tbAdmin.doc(email);
    await doc
        .update({"noTelp": telp })
        .whenComplete(() => print('Data Admin Berhasil di update'))
        .catchError((e) => print(e));
  }

}