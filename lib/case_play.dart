import 'package:flutter/material.dart';

import 'progress.dart';

class CaseStep {
  final String pertanyaan;
  final List<String> pilihan;
  final int benar;
  final String penjelasan;

  const CaseStep({
    required this.pertanyaan,
    required this.pilihan,
    required this.benar,
    required this.penjelasan,
  });
}

const Map<String, List<CaseStep>> caseSteps = {
  'Komputer tidak menyala': [
    CaseStep(
      pertanyaan: 'Komputer sama sekali tidak menyala. Apa yang pertama kali harus dicek?',
      pilihan: [
        'Ganti prosesor',
        'Pastikan kabel power tertancap dan stopkontak ada listrik',
        'Install ulang Windows',
        'Ganti RAM',
      ],
      benar: 1,
      penjelasan: 'Selalu mulai dari yang paling sederhana: sumber listrik dan kabel power.',
    ),
    CaseStep(
      pertanyaan: 'Kabel dan stopkontak normal, tapi komputer tetap mati total. Komponen yang paling mungkin bermasalah?',
      pilihan: ['Keyboard', 'Power Supply (PSU)', 'Mouse', 'Speaker'],
      benar: 1,
      penjelasan: 'PSU yang rusak tidak mengalirkan daya ke motherboard, sehingga komputer tidak bereaksi sama sekali.',
    ),
    CaseStep(
      pertanyaan: 'Kipas berputar sebentar lalu mati. Langkah yang tepat?',
      pilihan: [
        'Langsung beli komputer baru',
        'Cabut semua perangkat tambahan, lalu cek RAM dan kabel power ke motherboard',
        'Mengganti wallpaper',
        'Menunggu sampai sendirinya hidup',
      ],
      benar: 1,
      penjelasan: 'Isolasi masalah dengan melepas perangkat tambahan, lalu cek komponen inti seperti RAM dan sambungan power.',
    ),
  ],
  'Monitor tidak menampilkan gambar': [
    CaseStep(
      pertanyaan: 'Komputer menyala tapi layar hitam. Apa yang dicek pertama?',
      pilihan: [
        'Kabel video (HDMI/VGA) dan kabel power monitor',
        'Ganti motherboard',
        'Format hard disk',
        'Update BIOS',
      ],
      benar: 0,
      penjelasan: 'Kabel longgar adalah penyebab paling umum layar tidak menampilkan gambar.',
    ),
    CaseStep(
      pertanyaan:
          'Kabel sudah benar. Monitor menampilkan "No Signal". Artinya?',
      pilihan: [
        'Monitor menerima sinyal normal',
        'Monitor tidak menerima sinyal video, cek input source dan VGA/GPU',
        'Hard disk penuh',
        'Internet terputus',
      ],
      benar: 1,
      penjelasan: '"No Signal" berarti monitor hidup tapi tidak ada sinyal masuk. Cek pilihan input dan kartu grafis.',
    ),
    CaseStep(
      pertanyaan: 'Ada bunyi beep berulang saat komputer dinyalakan dan layar hitam. Kemungkinan terbesar?',
      pilihan: [
        'Mouse rusak',
        'Masalah pada RAM atau VGA',
        'Printer macet',
        'Wi-Fi mati',
      ],
      benar: 1,
      penjelasan: 'Kode beep dari BIOS sering menandakan masalah RAM atau kartu grafis. Coba cabut dan pasang ulang.',
    ),
  ],
  'Komputer sering restart': [
    CaseStep(
      pertanyaan: 'Komputer restart sendiri saat dipakai berat. Penyebab yang paling mungkin?',
      pilihan: [
        'Overheating (suhu terlalu panas)',
        'Warna wallpaper',
        'Ukuran font',
        'Volume speaker',
      ],
      benar: 0,
      penjelasan: 'Suhu berlebih memicu proteksi otomatis yang me-restart atau mematikan komputer.',
    ),
    CaseStep(
      pertanyaan: 'Cara paling tepat untuk mengatasi overheating?',
      pilihan: [
        'Menutup ventilasi',
        'Bersihkan debu pada kipas/heatsink dan ganti thermal paste bila perlu',
        'Menambah wallpaper',
        'Mematikan antivirus',
      ],
      benar: 1,
      penjelasan: 'Debu dan thermal paste kering menghambat pembuangan panas.',
    ),
    CaseStep(
      pertanyaan:
          'Suhu normal tapi restart tetap terjadi. Apa yang dicek berikutnya?',
      pilihan: [
        'Kapasitas PSU dan kondisi RAM',
        'Merek mouse',
        'Ukuran monitor',
        'Jenis keyboard',
      ],
      benar: 0,
      penjelasan:
          'PSU yang lemah atau RAM bermasalah sering menyebabkan restart acak.',
    ),
  ],
  'Tidak ada koneksi internet': [
    CaseStep(
      pertanyaan: 'Perangkat tidak bisa membuka internet. Langkah pertama?',
      pilihan: [
        'Install ulang sistem operasi',
        'Cek apakah Wi-Fi/kabel LAN terhubung dan router menyala',
        'Ganti prosesor',
        'Hapus semua file',
      ],
      benar: 1,
      penjelasan:
          'Mulai dari lapisan fisik: koneksi perangkat dan kondisi router.',
    ),
    CaseStep(
      pertanyaan: 'Terhubung ke Wi-Fi tapi tidak bisa browsing. Perintah untuk menguji koneksi ke gateway/internet?',
      pilihan: ['ping', 'format', 'shutdown', 'notepad'],
      benar: 0,
      penjelasan: 'Ping menguji apakah paket bisa sampai ke gateway atau server tujuan.',
    ),
    CaseStep(
      pertanyaan:
          'Ping ke 8.8.8.8 berhasil, tapi ke google.com gagal. Masalahnya di?',
      pilihan: ['Kabel LAN putus', 'DNS', 'Kartu grafis', 'RAM'],
      benar: 1,
      penjelasan: 'IP bisa dijangkau tapi nama domain tidak: berarti resolusi DNS yang bermasalah.',
    ),
  ],
  'Printer tidak terdeteksi': [
    CaseStep(
      pertanyaan: 'Printer tidak muncul di komputer. Apa yang dicek pertama?',
      pilihan: [
        'Printer menyala dan kabel USB/jaringan terhubung',
        'Ganti monitor',
        'Ganti keyboard',
        'Beli printer baru',
      ],
      benar: 0,
      penjelasan: 'Pastikan koneksi fisik dan daya printer lebih dulu.',
    ),
    CaseStep(
      pertanyaan: 'Koneksi sudah benar tapi tetap tidak terdeteksi. Langkah selanjutnya?',
      pilihan: [
        'Install atau update driver printer',
        'Mematikan monitor',
        'Menghapus browser',
        'Mengganti mouse',
      ],
      benar: 0,
      penjelasan: 'Driver yang hilang atau rusak adalah penyebab umum printer tidak dikenali.',
    ),
    CaseStep(
      pertanyaan:
          'Printer terdeteksi tapi dokumen tertahan di antrean. Solusinya?',
      pilihan: [
        'Hapus antrean cetak / restart Print Spooler',
        'Format komputer',
        'Ganti RAM',
        'Cabut kabel monitor',
      ],
      benar: 0,
      penjelasan: 'Antrean yang macet bisa dibersihkan dengan restart layanan Print Spooler.',
    ),
  ],
};

List<CaseStep> _stepsFor(String title) =>
    caseSteps[title] ?? caseSteps.values.first;

class CasePlayPage extends StatefulWidget {
  final String title;
  final int score;

  const CasePlayPage({super.key, required this.title, required this.score});

  @override
  State<CasePlayPage> createState() => _CasePlayPageState();
}

class _CasePlayPageState extends State<CasePlayPage> {
  late final List<CaseStep> steps = _stepsFor(widget.title);

  int index = 0;
  int jumlahBenar = 0;
  int? dipilih;
  bool sudahJawab = false;
  bool selesai = false;

  int get skorDapat => (widget.score * jumlahBenar / steps.length).round();

  void pilih(int i) {
    if (sudahJawab) return;
    setState(() {
      dipilih = i;
      sudahJawab = true;
      if (i == steps[index].benar) jumlahBenar++;
    });
  }

  void lanjut() {
    if (index < steps.length - 1) {
      setState(() {
        index++;
        dipilih = null;
        sudahJawab = false;
      });
    } else {
      ProgressStore.simpan(
        widget.title,
        skorDapat,
        maks: widget.score,
        benar: jumlahBenar,
        total: steps.length,
      );
      setState(() => selesai = true);
    }
  }

  void ulang() {
    setState(() {
      index = 0;
      jumlahBenar = 0;
      dipilih = null;
      sudahJawab = false;
      selesai = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF172033)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: selesai ? _buildHasil() : _buildSoal(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSoal() {
    final step = steps[index];
    final bool benarDipilih = sudahJawab && dipilih == step.benar;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Soal ${index + 1} dari ${steps.length}',
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          sudahJawab
              ? 'Jawaban sudah diperiksa. Baca pembahasannya sebelum lanjut.'
              : 'Pilih satu jawaban yang menurutmu paling tepat.',
          style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: (index + (sudahJawab ? 1 : 0)) / steps.length,
            minHeight: 8,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Text(
            step.pertanyaan,
            style: const TextStyle(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
        ),
        const SizedBox(height: 18),
        for (int i = 0; i < step.pilihan.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _OptionTile(
              teks: step.pilihan[i],
              state: _stateOption(i, step),
              onTap: () => pilih(i),
            ),
          ),
        if (sudahJawab) ...[
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: benarDipilih
                  ? const Color(0xFFECFDF5)
                  : const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  benarDipilih
                      ? Icons.check_circle_rounded
                      : Icons.cancel_rounded,
                  color: benarDipilih
                      ? const Color(0xFF059669)
                      : const Color(0xFFDC2626),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        benarDipilih ? 'Benar!' : 'Kurang tepat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: benarDipilih
                              ? const Color(0xFF059669)
                              : const Color(0xFFDC2626),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        step.penjelasan,
                        style: const TextStyle(
                          height: 1.5,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: lanjut,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                index == steps.length - 1 ? 'LIHAT HASIL' : 'LANJUTKAN',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ],
    );
  }

  _OptionState _stateOption(int i, CaseStep step) {
    if (!sudahJawab) return _OptionState.normal;
    if (i == step.benar) return _OptionState.benar;
    if (i == dipilih) return _OptionState.salah;
    return _OptionState.normal;
  }

  Widget _buildHasil() {
    final bool lulus = jumlahBenar >= (steps.length * 2 / 3).ceil();

    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: lulus ? const Color(0xFFECFDF5) : const Color(0xFFFEF3C7),
            shape: BoxShape.circle,
          ),
          child: Icon(
            lulus ? Icons.emoji_events_rounded : Icons.refresh_rounded,
            size: 52,
            color: lulus ? const Color(0xFF059669) : const Color(0xFFD97706),
          ),
        ),
        const SizedBox(height: 22),
        Text(
          lulus ? 'Kasus Selesai!' : 'Coba Lagi Ya',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF172033),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Kamu menjawab $jumlahBenar dari ${steps.length} langkah dengan benar.',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final rapat = constraints.maxWidth < 390;
            final ringkasan = [
              _HasilStat(
                label: 'Jawaban benar',
                value: '$jumlahBenar/${steps.length}',
              ),
              _HasilStat(
                label: 'Poin didapat',
                value: '$skorDapat/${widget.score}',
              ),
            ];
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: rapat
                  ? Column(
                      children: [
                        for (final item in ringkasan) ...[
                          if (item != ringkasan.first)
                            const Divider(height: 20),
                          _BarisHasil(stat: item),
                        ],
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(child: _BarisHasil(stat: ringkasan[0])),
                        Container(
                          width: 1,
                          height: 44,
                          color: const Color(0xFFBFDBFE),
                        ),
                        Expanded(child: _BarisHasil(stat: ringkasan[1])),
                      ],
                    ),
            );
          },
        ),
        const SizedBox(height: 26),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'KEMBALI KE DASHBOARD',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: ulang,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2563EB),
              side: const BorderSide(color: Color(0xFFBFDBFE)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'ULANGI KASUS',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class _HasilStat {
  final String label;
  final String value;

  const _HasilStat({required this.label, required this.value});
}

class _BarisHasil extends StatelessWidget {
  final _HasilStat stat;

  const _BarisHasil({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          stat.label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
        ),
        const SizedBox(height: 5),
        Text(
          stat.value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF2563EB),
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

enum _OptionState { normal, benar, salah }

class _OptionTile extends StatelessWidget {
  final String teks;
  final _OptionState state;
  final VoidCallback onTap;

  const _OptionTile({
    required this.teks,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color border = const Color(0xFFE2E8F0);
    Color bg = Colors.white;
    IconData? ikon;
    Color ikonWarna = Colors.transparent;

    if (state == _OptionState.benar) {
      border = const Color(0xFF059669);
      bg = const Color(0xFFECFDF5);
      ikon = Icons.check_circle_rounded;
      ikonWarna = const Color(0xFF059669);
    } else if (state == _OptionState.salah) {
      border = const Color(0xFFDC2626);
      bg = const Color(0xFFFEF2F2);
      ikon = Icons.cancel_rounded;
      ikonWarna = const Color(0xFFDC2626);
    }

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: 1.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                teks,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Color(0xFF172033),
                ),
              ),
            ),
            if (ikon != null) ...[
              const SizedBox(width: 10),
              Icon(ikon, color: ikonWarna),
            ],
          ],
        ),
      ),
    );
  }
}
