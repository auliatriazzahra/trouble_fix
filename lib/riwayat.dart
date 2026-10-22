import 'package:flutter/material.dart';

import 'progress.dart';

String _formatWaktu(DateTime t) {
  const bulan = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  final jam = t.hour.toString().padLeft(2, '0');
  final menit = t.minute.toString().padLeft(2, '0');
  return '${t.day} ${bulan[t.month - 1]} ${t.year}, $jam:$menit';
}

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Riwayat Saya',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF172033)),
      ),
      body: ValueListenableBuilder<List<RiwayatItem>>(
        valueListenable: ProgressStore.riwayat,
        builder: (context, daftar, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: daftar.isEmpty
                    ? const _KosongRiwayat()
                    : _Isi(daftar: daftar),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Isi extends StatelessWidget {
  final List<RiwayatItem> daftar;

  const _Isi({required this.daftar});

  @override
  Widget build(BuildContext context) {
    final totalBenar = daftar.fold<int>(0, (a, b) => a + b.benar);
    final totalSoal = daftar.fold<int>(0, (a, b) => a + b.total);
    final akurasi = totalSoal == 0 ? 0 : (totalBenar * 100 / totalSoal).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ringkasan belajar',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            color: Color(0xFF172033),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Lihat kembali latihan dan hasil yang sudah kamu raih.',
          style: TextStyle(color: Color(0xFF64748B), height: 1.4),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _Ringkasan(
                ikon: Icons.history,
                nilai: '${daftar.length}',
                label: 'Percobaan',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _Ringkasan(
                ikon: Icons.track_changes_rounded,
                nilai: '$akurasi%',
                label: 'Akurasi jawaban',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Aktivitas terbaru',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF172033),
          ),
        ),
        const SizedBox(height: 14),
        for (final item in daftar)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _RiwayatCard(item: item),
          ),
      ],
    );
  }
}

class _Ringkasan extends StatelessWidget {
  final IconData ikon;
  final String nilai;
  final String label;

  const _Ringkasan({
    required this.ikon,
    required this.nilai,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(ikon, color: const Color(0xFF2563EB)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nilai,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RiwayatCard extends StatelessWidget {
  final RiwayatItem item;

  const _RiwayatCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final lulus = item.lulus;
    final warna = lulus ? const Color(0xFF059669) : const Color(0xFFD97706);
    final bg = lulus ? const Color(0xFFECFDF5) : const Color(0xFFFEF3C7);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              lulus ? Icons.check_circle_rounded : Icons.refresh_rounded,
              color: warna,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.judul,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.benar}/${item.total} benar  •  ${_formatWaktu(item.waktu)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+${item.skor}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                ),
              ),
              const Text(
                'poin',
                style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KosongRiwayat extends StatelessWidget {
  const _KosongRiwayat();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        children: const [
          Icon(Icons.history_rounded, size: 72, color: Color(0xFFCBD5E1)),
          SizedBox(height: 16),
          Text(
            'Belum ada riwayat',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172033),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Selesaikan kasus pertamamu dan hasilnya akan muncul di sini.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}
