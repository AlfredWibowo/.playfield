import 'dart:convert';

import 'package:aplikasi_booking_lapangan_online/class/CKota.dart';
import 'package:flutter/services.dart';

class LocalService {
  
  String citiesPath = "assets/json/cities.json";

  Future<List<Kota>> getAllKota() async {
    final String response = await rootBundle.loadString(citiesPath);

    List jsonResponse = await json.decode(response);

    return jsonResponse.map((data) => Kota.fromJson(data)).toList();
  }
}