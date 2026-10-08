import 'package:flutter/material.dart';

class CasesPage extends StatefulWidget {
  const CasesPage({super.key});

  @override
  State<CasesPage> createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {
  String selectedCategory = 'Semua';

  final List<Map<String, dynamic>> cases = [
    {
      'title': 'Komputer tidak menyala',
      'category': 'Hardware',
      'difficulty': 'Mudah',
      'score': 100,
      'icon': Icons.power_settings_new_rounded,
    },
    {
      'title': 'Monitor tidak menampilkan gambar',
      'category': 'Hardware',
      'difficulty': 'Sedang',
      'score': 120,
      'icon': Icons.monitor_rounded,
    },
    {
      'title': 'Komputer sering restart',
      'category': 'Hardware',
      'difficulty': 'Sedang',
      'score': 120,
      'icon': Icons.restart_alt_rounded,
    },
    {
      'title': 'Tidak ada koneksi internet',
      'category': 'Jaringan',
      'difficulty': 'Sedang',
      'score': 120,
      'icon': Icons.wifi_off_rounded,
    },
    {
      'title': 'Printer tidak terdeteksi',
      'category': 'Software',
      'difficulty': 'Mudah',
      'score': 80,
      'icon': Icons.print_disabled_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCases = selectedCategory == 'Semua'
        ? cases
        : cases
            .where(
              (item) => item['category'] == selectedCategory,
            )
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Daftar Kasus',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF172033),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih Kasus',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Pilih masalah yang ingin kamu selesaikan.',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                  ),
                ),

                const SizedBox(height: 24),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'Semua',
                        selected: selectedCategory == 'Semua',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Semua';
                          });
                        },
                      ),
                      _FilterChip(
                        label: 'Hardware',
                        selected: selectedCategory == 'Hardware',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Hardware';
                          });
                        },
                      ),
                      _FilterChip(
                        label: 'Software',
                        selected: selectedCategory == 'Software',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Software';
                          });
                        },
                      ),
                      _FilterChip(
                        label: 'Jaringan',
                        selected: selectedCategory == 'Jaringan',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Jaringan';
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                ...filteredCases.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _CaseCard(
                      title: item['title'],
                      category: item['category'],
                      difficulty: item['difficulty'],
                      score: item['score'],
                      icon: item['icon'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CaseDetailPage(
                              title: item['title'],
                              category: item['category'],
                              difficulty: item['difficulty'],
                              score: item['score'],
                            ),
                          ),
                        );
                      },
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
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF2563EB)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected
                  ? const Color(0xFF2563EB)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : const Color(0xFF475569),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _CaseCard extends StatelessWidget {
  final String title;
  final String category;
  final String difficulty;
  final int score;
  final IconData icon;
  final VoidCallback onTap;

  const _CaseCard({
    required this.title,
    required this.category,
    required this.difficulty,
    required this.score,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF2563EB),
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF172033),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      _SmallTag(
                        text: category,
                        blue: true,
                      ),
                      const SizedBox(width: 8),
                      _SmallTag(
                        text: difficulty,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 17,
                        color: Color(0xFFF59E0B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$score poin',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallTag extends StatelessWidget {
  final String text;
  final bool blue;

  const _SmallTag({
    required this.text,
    this.blue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: blue
            ? const Color(0xFFEFF6FF)
            : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: blue
              ? const Color(0xFF2563EB)
              : const Color(0xFF64748B),
        ),
      ),
    );
  }
}

class CaseDetailPage extends StatelessWidget {
  final String title;
  final String category;
  final String difficulty;
  final int score;

  const CaseDetailPage({
    super.key,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final bool internetCase =
        title == 'Tidak ada koneksi internet';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Detail Kasus',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF172033),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF172033),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          _SmallTag(
                            text: category,
                            blue: true,
                          ),
                          const SizedBox(width: 8),
                          _SmallTag(
                            text: difficulty,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        internetCase
                            ? 'Perangkat tidak dapat terhubung ke internet. Cari tahu penyebab dan langkah troubleshooting untuk mengatasi masalah jaringan.'
                            : 'Pelajari masalah ini dan lakukan langkah troubleshooting untuk menemukan penyebab serta solusi yang tepat.',
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Tujuan Kasus',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                const _GoalItem(
                  text: 'Mengidentifikasi penyebab masalah',
                ),
                const _GoalItem(
                  text: 'Melakukan langkah troubleshooting',
                ),
                const _GoalItem(
                  text: 'Menemukan solusi yang tepat',
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.stars_rounded,
                        color: Color(0xFF2563EB),
                        size: 30,
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Estimasi Poin',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '$score poin',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'MULAI KASUS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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

  const _GoalItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF2563EB),
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }
}