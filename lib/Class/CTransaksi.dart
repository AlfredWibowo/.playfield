import 'package:project_ambw/class/CLapangan.dart';
import 'package:uuid/uuid.dart';

class TransaksiCls {
  late String id;
  String tanggal;
  Field lapangan;

  TransaksiCls({
    required this.tanggal,
    required this.lapangan,
  }) {
    var uuid = const Uuid();
    id = uuid.v4();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "tanggal": tanggal,
      "isOccupied": lapangan
    };
  }
}