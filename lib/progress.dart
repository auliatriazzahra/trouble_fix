import 'package:flutter/foundation.dart';

/// Satu percobaan mengerjakan kasus.
class RiwayatItem {
  final String judul;
  final int skor;
  final int maks;
  final int benar;
  final int total;
  final DateTime waktu;

  const RiwayatItem({
    required this.judul,
    required this.skor,
    required this.maks,
    required this.benar,
    required this.total,
    required this.waktu,
  });

  bool get lulus => total > 0 && benar >= (total * 2 / 3).ceil();
}

/// Penyimpanan progress dan pengaturan lokal di memori aplikasi.
class ProgressStore {
  ProgressStore._();

  static const int totalKasus = 5;

  /// Nama tampilan lokal.
  static final ValueNotifier<String> nama = ValueNotifier<String>('Pengguna');

  /// Judul kasus yang sudah selesai -> skor terbaik.
  static final ValueNotifier<Map<String, int>> selesai =
      ValueNotifier<Map<String, int>>({});

  /// Semua percobaan, terbaru di indeks 0.
  static final ValueNotifier<List<RiwayatItem>> riwayat =
      ValueNotifier<List<RiwayatItem>>([]);

  static int get jumlahSelesai => selesai.value.length;

  static int get skorTotal => selesai.value.values.fold(0, (a, b) => a + b);

  static double get persen => totalKasus == 0 ? 0 : jumlahSelesai / totalKasus;

  /// Simpan hasil kasus. Skor terbaik yang dipakai untuk skor total.
  static void simpan(
    String judul,
    int skor, {
    int maks = 0,
    int benar = 0,
    int total = 0,
  }) {
    final baru = Map<String, int>.from(selesai.value);
    final lama = baru[judul] ?? 0;
    baru[judul] = skor > lama ? skor : lama;
    selesai.value = baru;

    riwayat.value = [
      RiwayatItem(
        judul: judul,
        skor: skor,
        maks: maks,
        benar: benar,
        total: total,
        waktu: DateTime.now(),
      ),
      ...riwayat.value,
    ];
  }

  /// Hapus semua progress dan riwayat.
  static void reset() {
    selesai.value = {};
    riwayat.value = [];
  }
}
