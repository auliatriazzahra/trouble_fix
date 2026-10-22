import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'case_play.dart';
import 'materi.dart';
import 'materi_data.dart';
import 'progress.dart';

const _biru = Color(0xFF2563EB);
const _tinta = Color(0xFF172033);
const _latar = Color(0xFFF5F8FC);
const _garis = Color(0xFFE2E8F0);
const _redup = Color(0xFF64748B);

class CasesPage extends StatefulWidget {
  const CasesPage({super.key});

  static final List<Map<String, dynamic>> cases = [
    {
      'title': 'Komputer tidak menyala',
      'description': 'Telusuri masalah daya dari sumber listrik hingga komponen utama komputer.',
      'category': 'Hardware',
      'difficulty': 'Mudah',
      'score': 100,
      'icon': Icons.power_settings_new_rounded,
    },
    {
      'title': 'Monitor tidak menampilkan gambar',
      'description': 'Periksa sambungan dan penyebab layar tetap hitam atau menampilkan No Signal.',
      'category': 'Hardware',
      'difficulty': 'Sedang',
      'score': 120,
      'icon': Icons.monitor_rounded,
    },
    {
      'title': 'Komputer sering restart',
      'description':
          'Identifikasi penyebab komputer memulai ulang saat digunakan.',
      'category': 'Hardware',
      'difficulty': 'Sedang',
      'score': 120,
      'icon': Icons.restart_alt_rounded,
    },
    {
      'title': 'Tidak ada koneksi internet',
      'description': 'Periksa koneksi jaringan dan cari tahu apakah masalahnya ada pada DNS.',
      'category': 'Jaringan',
      'difficulty': 'Sedang',
      'score': 120,
      'icon': Icons.wifi_off_rounded,
    },
    {
      'title': 'Printer tidak terdeteksi',
      'description':
          'Cari penyebab printer tidak dikenali dan antrean cetak yang macet.',
      'category': 'Software',
      'difficulty': 'Mudah',
      'score': 80,
      'icon': Icons.print_disabled_rounded,
    },
  ];

  static void openCase(
    BuildContext context,
    String title, {
    bool replaceCurrentRoute = false,
  }) {
    final item = cases.firstWhere((item) => item['title'] == title);
    final route = MaterialPageRoute<void>(
      builder: (_) => CaseDetailPage(
        title: item['title'] as String,
        description: item['description'] as String,
        category: item['category'] as String,
        difficulty: item['difficulty'] as String,
        score: item['score'] as int,
      ),
    );

    if (replaceCurrentRoute) {
      Navigator.pushReplacement(context, route);
    } else {
      Navigator.push(context, route);
    }
  }

  @override
  State<CasesPage> createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {
  String selectedCategory = 'Semua';
  String query = '';

  @override
  Widget build(BuildContext context) {
    final hasilCari = CasesPage.cases.where((item) {
      final cocokKategori =
          selectedCategory == 'Semua' || item['category'] == selectedCategory;
      final cocokTeks =
          ('${item['title']} ${item['description']} '
                  '${item['category']}')
              .toLowerCase()
              .contains(query.trim().toLowerCase());
      return cocokKategori && cocokTeks;
    }).toList();

    return Scaffold(
      backgroundColor: _latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Daftar Kasus',
          style: TextStyle(color: _tinta, fontWeight: FontWeight.w800),
        ),
        iconTheme: const IconThemeData(color: _tinta),
      ),
      body: ValueListenableBuilder<Map<String, int>>(
        valueListenable: ProgressStore.selesai,
        builder: (context, selesai, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 960),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latihan troubleshooting',
                      style: AppTextStyles.heading(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Pilih masalah, pelajari langkah diagnosis, lalu uji pemahamanmu.',
                      style: TextStyle(color: _redup, height: 1.45),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) => setState(() => query = value),
                      decoration: InputDecoration(
                        hintText: 'Cari kasus atau kategori',
                        prefixIcon: const Icon(Icons.search_rounded),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: _garis),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: _garis),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: _biru,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final kategori in const [
                            'Semua',
                            'Hardware',
                            'Software',
                            'Jaringan',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: _FilterChip(
                                label: kategori,
                                selected: selectedCategory == kategori,
                                onTap: () =>
                                    setState(() => selectedCategory = kategori),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${hasilCari.length} kasus tersedia',
                      style: const TextStyle(
                        color: _redup,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (hasilCari.isEmpty)
                      const _EmptySearch()
                    else
                      ...hasilCari.map((item) {
                        final title = item['title'] as String;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _CaseCard(
                            title: title,
                            description: item['description'] as String,
                            category: item['category'] as String,
                            difficulty: item['difficulty'] as String,
                            score: item['score'] as int,
                            icon: item['icon'] as IconData,
                            isComplete: selesai.containsKey(title),
                            onTap: () => CasesPage.openCase(context, title),
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _biru : Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected ? _biru : _garis),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : _redup,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _CaseCard extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final int score;
  final IconData icon;
  final bool isComplete;
  final VoidCallback onTap;

  const _CaseCard({
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.score,
    required this.icon,
    required this.isComplete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _garis),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: _biru, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _tinta,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        color: _redup,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 7,
                      runSpacing: 7,
                      children: [
                        _Tag(text: category, blue: true),
                        _Tag(text: difficulty),
                        _Tag(
                          text: isComplete ? 'Selesai' : 'Belum dikerjakan',
                          color: isComplete ? const Color(0xFF047857) : _redup,
                          background: isComplete
                              ? const Color(0xFFECFDF5)
                              : const Color(0xFFF1F5F9),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4,
                      children: [
                        const Icon(
                          Icons.stars_rounded,
                          size: 16,
                          color: Color(0xFFD97706),
                        ),
                        Text(
                          '$score poin maksimal',
                          style: const TextStyle(color: _redup, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 12),
                child: Icon(Icons.chevron_right_rounded, color: _redup),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final bool blue;
  final Color? color;
  final Color? background;

  const _Tag({
    required this.text,
    this.blue = false,
    this.color,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: background ?? (blue ? const Color(0xFFEFF6FF) : _latar),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? (blue ? _biru : _redup),
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _garis),
      ),
      child: const Column(
        children: [
          Icon(Icons.search_off_rounded, size: 40, color: _redup),
          SizedBox(height: 10),
          Text(
            'Kasus tidak ditemukan',
            style: TextStyle(color: _tinta, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4),
          Text(
            'Coba kata kunci atau kategori lain.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _redup, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class CaseDetailPage extends StatelessWidget {
  final String title;
  final String category;
  final String difficulty;
  final int score;
  final String description;

  const CaseDetailPage({
    super.key,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.score,
    this.description = '',
  });

  @override
  Widget build(BuildContext context) {
    final detail = description.isEmpty
        ? 'Pelajari masalah ini dan lakukan langkah troubleshooting untuk menemukan penyebab serta solusi yang tepat.'
        : description;
    return Scaffold(
      backgroundColor: _latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Detail Kasus',
          style: TextStyle(color: _tinta, fontWeight: FontWeight.w800),
        ),
        iconTheme: const IconThemeData(color: _tinta),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 780),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _garis),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.troubleshoot_rounded,
                        color: _biru,
                        size: 30,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        title,
                        style: AppTextStyles.heading(
                          fontSize: 25,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _Tag(text: category, blue: true),
                          _Tag(text: difficulty),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text(
                        detail,
                        style: const TextStyle(
                          color: _redup,
                          fontSize: 15,
                          height: 1.65,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Dalam latihan ini',
                  style: AppTextStyles.heading(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const _GoalItem(text: 'Mengidentifikasi penyebab masalah'),
                const _GoalItem(text: 'Memilih langkah pemeriksaan yang tepat'),
                const _GoalItem(text: 'Memahami alasan di balik solusi'),
                const SizedBox(height: 18),
                Text(
                  'Pelajari Materi Terkait',
                  style: AppTextStyles.heading(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Bangun pemahaman sebelum memulai latihan kasus ini.',
                  style: TextStyle(color: _redup, height: 1.45, fontSize: 13),
                ),
                const SizedBox(height: 12),
                for (final materi in materiUntukKasus(title)) ...[
                  MateriTerkaitCard(
                    materi: materi,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => MateriDetailPage(
                            materi: materi,
                            onKembaliKeKasus: (materiContext) =>
                                Navigator.pop(materiContext),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.stars_rounded, color: _biru, size: 28),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Skor maksimal',
                          style: TextStyle(color: _redup),
                        ),
                      ),
                      Text(
                        '$score poin',
                        style: const TextStyle(
                          color: _biru,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              CasePlayPage(title: title, score: score),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('MULAI KASUS'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _biru,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontWeight: FontWeight.w700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
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

class _GoalItem extends StatelessWidget {
  final String text;

  const _GoalItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: _biru, size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _redup, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
