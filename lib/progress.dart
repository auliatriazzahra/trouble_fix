import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  static const String _materiSelesaiKey = 'trouble_fix_materi_selesai';

  /// Nama tampilan lokal.
  static final ValueNotifier<String> nama = ValueNotifier<String>('Pengguna');

  /// Judul kasus yang sudah selesai -> skor terbaik.
  static final ValueNotifier<Map<String, int>> selesai =
      ValueNotifier<Map<String, int>>({});

  /// Semua percobaan, terbaru di indeks 0.
  static final ValueNotifier<List<RiwayatItem>> riwayat =
      ValueNotifier<List<RiwayatItem>>([]);

  /// ID materi yang sudah ditandai selesai, disimpan di perangkat.
  static final ValueNotifier<Set<String>> materiSelesai =
      ValueNotifier<Set<String>>({});

  static Future<void> muatMateriSelesai() async {
    final preferences = await SharedPreferences.getInstance();
    materiSelesai.value =
        preferences.getStringList(_materiSelesaiKey)?.toSet() ?? <String>{};
  }

  static Future<void> tandaiMateriSelesai(
    String id, {
    required bool selesai,
  }) async {
    final terbaru = Set<String>.from(materiSelesai.value);
    if (selesai) {
      terbaru.add(id);
    } else {
      terbaru.remove(id);
    }

    final preferences = await SharedPreferences.getInstance();
    final tersimpan = await preferences.setStringList(
      _materiSelesaiKey,
      terbaru.toList(),
    );
    if (!tersimpan) {
      throw StateError('Status materi tidak berhasil disimpan di perangkat.');
    }
    materiSelesai.value = terbaru;
  }

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
  static Future<void> reset() async {
    final preferences = await SharedPreferences.getInstance();
    final materiTerhapus = await preferences.setStringList(
      _materiSelesaiKey,
      <String>[],
    );
    if (!materiTerhapus) {
      throw StateError('Status materi tidak berhasil direset.');
    }
    selesai.value = {};
    riwayat.value = [];
    materiSelesai.value = <String>{};
  }
}
