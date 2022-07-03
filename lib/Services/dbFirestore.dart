import 'package:aplikasi_booking_lapangan_online/class/Order.dart';
import 'package:aplikasi_booking_lapangan_online/class/SportCentre.dart';
import 'package:aplikasi_booking_lapangan_online/class/SportField.dart';
import 'package:aplikasi_booking_lapangan_online/class/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumerFirestoreDatabase {
  //user
  static CollectionReference tbConsumer =
      FirebaseFirestore.instance.collection('Consumer');

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
      FirebaseFirestore.instance.collection('Admin');

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
}

class SportFieldFirestoreDatabase {
  //sport field
  static CollectionReference tbSportField =
      FirebaseFirestore.instance.collection('SportField');

  static Stream<QuerySnapshot> getData() {
    return tbSportField.snapshots();
  }

  static Stream<QuerySnapshot> getDataBySportCentre(SportCentre sc) {
    return tbSportField
        .where(FieldPath.documentId, whereIn: sc.sportFieldId)
        .snapshots();
  }

  static Stream<DocumentSnapshot> getDataById(String id) {
    return tbSportField.doc(id).snapshots();
  }

  static Future<void> addData({required SportField sf}) async {
    DocumentReference doc = tbSportField.doc(sf.id);
    await doc
        .set(sf.toJson())
        .whenComplete(() => print('Data Sport Field Berhasil di add'))
        .catchError((e) => print(e));
  }

  static Future<void> editData({required SportField sf}) async {
    DocumentReference doc = tbSportField.doc(sf.id);

    await doc
        .update(sf.toJson())
        .whenComplete(() => print('Data Sport Field Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData({required SportField sf}) async {
    DocumentReference doc = tbSportField.doc(sf.id);

    await doc
        .delete()
        .whenComplete(() => print('Data Sport Field Berhasil di delete'))
        .catchError((e) => print(e));
  }
}

class SportCentreFirestoreDatabase {
  //sport centre
  static CollectionReference tbSportCentre =
      FirebaseFirestore.instance.collection('SportCentre');

  static Stream<QuerySnapshot> getData(String nameSC) {
    if (nameSC == "") {
      return tbSportCentre.snapshots();
    } else {
      return tbSportCentre
          //.where('name', isEqualTo: nameSC)
          .orderBy('name')
          .startAt([nameSC]).endAt([nameSC + '\uf8ff']).snapshots();
    }
  }

  static Stream<QuerySnapshot> getDataByAdmin(Admin admin, String nameSC) {
    if (nameSC == "") {
      return tbSportCentre
          .where(FieldPath.documentId, whereIn: admin.sportCentreId)
          .snapshots();
    } else {
      final ref = tbSportCentre;
      final query1 =
          ref.where(FieldPath.documentId, whereIn: admin.sportCentreId);
      final query2 =
          ref.orderBy('name').startAt([nameSC]).endAt([nameSC + '\uf8ff']);

      return query2.snapshots();
    }
  }

  static Stream<DocumentSnapshot> getDataById(String id) {
    return tbSportCentre.doc(id).snapshots();
  }

  static Future<void> addData({required SportCentre sc}) async {
    DocumentReference doc = tbSportCentre.doc(sc.id);
    await doc
        .set(sc.toJson())
        .whenComplete(() => print('Data Sport Centre Berhasil di add'))
        .catchError((e) => print(e));
  }

  static Future<void> editData({required SportCentre sc}) async {
    DocumentReference doc = tbSportCentre.doc(sc.id);

    await doc
        .update(sc.toJson())
        .whenComplete(() => print('Data Sport Centre Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData({required SportCentre sc}) async {
    DocumentReference doc = tbSportCentre.doc(sc.id);

    await doc
        .delete()
        .whenComplete(() => print('Data Sport Centre Berhasil di delete'))
        .catchError((e) => print(e));
  }
}

class OrderFirestoreDatabase {
  //sport centre
  static CollectionReference tbOrder =
      FirebaseFirestore.instance.collection('Order');

  static Stream<QuerySnapshot> getData() {
    return tbOrder.snapshots();
  }

  static Stream<QuerySnapshot> getDataByConsumer(Consumer consumer) {
    return tbOrder
        .where(FieldPath.documentId, whereIn: consumer.orderId)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataByAdmin(Admin admin) {
    return tbOrder
        .where(FieldPath.documentId, whereIn: admin.orderId)
        .snapshots();
  }

  static Stream<DocumentSnapshot> getDataById(String id) {
    return tbOrder.doc(id).snapshots();
  }

  static Future<void> addData({required Order order}) async {
    DocumentReference doc = tbOrder.doc(order.id);
    await doc
        .set(order.toJson())
        .whenComplete(() => print('Data Order Berhasil di add'))
        .catchError((e) => print(e));
  }

  static Future<void> editData({required Order order}) async {
    DocumentReference doc = tbOrder.doc(order.id);

    await doc
        .update(order.toJson())
        .whenComplete(() => print('Data Order Berhasil di update'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData({required Order order}) async {
    DocumentReference doc = tbOrder.doc(order.id);

    await doc
        .delete()
        .whenComplete(() => print('Data Order Berhasil di delete'))
        .catchError((e) => print(e));
  }
}
