import 'dart:convert';

import 'package:project_ambw/class/City.dart';
import 'package:flutter/services.dart';

class LocalService {
  
  String citiesPath = "assets/json/cities.json";

  Future<List<City>> getAllKota() async {
    final String response = await rootBundle.loadString(citiesPath);

    List jsonResponse = await json.decode(response);

    return jsonResponse.map((data) => City.fromJson(data)).toList();
  }
}