import 'package:project_ambw/class/CLapangan.dart';

class TransaksiCls {
  String id;
  String tanggal;
  LapanganCls lapangan;
  String status;

  TransaksiCls({
    required this.id,
    required this.tanggal,
    required this.lapangan,
    required this.status
  });
}