import 'package:flutter/material.dart';

import 'progress.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  static const _biru = Color(0xFF2563EB);
  static const _tinta = Color(0xFF172033);
  static const _latar = Color(0xFFF5F8FC);
  static const _garis = Color(0xFFE2E8F0);
  static const _redup = Color(0xFF64748B);

  Future<void> _ubahNama(BuildContext context) async {
    final hasil = await showDialog<String>(
      context: context,
      builder: (context) => _DialogNama(namaAwal: ProgressStore.nama.value),
    );

    if (hasil != null && hasil.isNotEmpty) {
      ProgressStore.nama.value = hasil;
    }
  }

  Future<void> _reset(BuildContext context) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Progress?'),
        content: const Text(
          'Semua skor, kasus yang selesai, dan riwayat akan dihapus. '
          'Tindakan ini tidak bisa dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFDC2626),
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (yakin == true) {
      try {
        await ProgressStore.reset();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Progress berhasil direset.')),
          );
        }
      } catch (error, stackTrace) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stackTrace,
            library: 'TroubleFix',
            context: ErrorDescription('while resetting learning progress'),
          ),
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Progress gagal direset. Coba lagi.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pengaturan',
          style: TextStyle(color: _tinta, fontWeight: FontWeight.w800),
        ),
        iconTheme: const IconThemeData(color: _tinta),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PROFIL
                ValueListenableBuilder<String>(
                  valueListenable: ProgressStore.nama,
                  builder: (context, nama, _) {
                    final tampil = nama.trim().isEmpty ? 'Pengguna' : nama;
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: _garis),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: const Color(0xFFDBEAFE),
                            child: Text(
                              tampil[0].toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tampil,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF172033),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Nama tampilan lokal, tanpa akun',
                                  style: TextStyle(color: _redup),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: 'Ubah nama',
                            onPressed: () => _ubahNama(context),
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),
                const _Judul('Progress lokal'),

                _Baris(
                  ikon: Icons.delete_outline_rounded,
                  judul: 'Reset Progress',
                  subjudul: 'Hapus skor, riwayat, dan status materi',
                  onTap: () => _reset(context),
                  merah: true,
                ),

                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _garis),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded, color: _biru),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'TroubleFix berjalan tanpa login atau database. '
                          'Skor dan riwayat tersimpan selama sesi; status '
                          'materi disimpan secara lokal di perangkat.',
                          style: TextStyle(
                            color: _redup,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Center(
                  child: Text(
                    'TroubleFix  •  Versi 1.0.0',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Judul extends StatelessWidget {
  final String teks;

  const _Judul(this.teks);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        teks,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }
}

class _DialogNama extends StatefulWidget {
  final String namaAwal;

  const _DialogNama({required this.namaAwal});

  @override
  State<_DialogNama> createState() => _DialogNamaState();
}

class _DialogNamaState extends State<_DialogNama> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.namaAwal);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ubah Nama Tampilan'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          hintText: 'Masukkan nama tampilan (opsional)',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _controller.text.trim()),
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}

class _Baris extends StatelessWidget {
  final IconData ikon;
  final String judul;
  final String subjudul;
  final VoidCallback? onTap;
  final bool merah;

  const _Baris({
    required this.ikon,
    required this.judul,
    required this.subjudul,
    this.onTap,
    this.merah = false,
  });

  @override
  Widget build(BuildContext context) {
    final warna = merah ? const Color(0xFFDC2626) : const Color(0xFF2563EB);
    final bg = merah ? const Color(0xFFFEF2F2) : const Color(0xFFEFF6FF);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(ikon, color: warna),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: merah
                          ? const Color(0xFFDC2626)
                          : const Color(0xFF172033),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subjudul,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }
}
