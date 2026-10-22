import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'progress.dart';

const _biru = Color(0xFF2563EB);
const _tinta = Color(0xFF172033);
const _latar = Color(0xFFF5F8FC);
const _garis = Color(0xFFE2E8F0);
const _redup = Color(0xFF64748B);

class PeringkatPage extends StatelessWidget {
  const PeringkatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pencapaian',
          style: TextStyle(color: _tinta, fontWeight: FontWeight.w800),
        ),
        iconTheme: const IconThemeData(color: _tinta),
      ),
      body: ValueListenableBuilder<Map<String, int>>(
        valueListenable: ProgressStore.selesai,
        builder: (context, selesai, _) {
          final total = ProgressStore.totalKasus;
          final dikerjakan = selesai.length;
          final persen = total == 0 ? 0.0 : dikerjakan / total;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 820),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [_biru, Color(0xFF1D4ED8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.emoji_events_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Perjalanan belajarmu',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$dikerjakan dari $total kasus selesai',
                                  style: AppTextStyles.heading(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth >= 520
                            ? (constraints.maxWidth - 12) / 2
                            : constraints.maxWidth;
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            SizedBox(
                              width: width,
                              child: _StatCard(
                                icon: Icons.stars_rounded,
                                label: 'Skor terbaik',
                                value: '${ProgressStore.skorTotal} poin',
                              ),
                            ),
                            SizedBox(
                              width: width,
                              child: _StatCard(
                                icon: Icons.donut_large_rounded,
                                label: 'Progres',
                                value: '${(persen * 100).round()}%',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Target pencapaian',
                      style: AppTextStyles.heading(
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Lencana ini mengikuti kasus yang benar-benar kamu selesaikan.',
                      style: TextStyle(color: _redup, height: 1.4),
                    ),
                    const SizedBox(height: 14),
                    _AchievementCard(
                      title: 'Langkah pertama',
                      description:
                          'Selesaikan kasus troubleshooting pertamamu.',
                      icon: Icons.flag_rounded,
                      unlocked: dikerjakan >= 1,
                      progress: dikerjakan.clamp(0, 1),
                      target: 1,
                    ),
                    const SizedBox(height: 10),
                    _AchievementCard(
                      title: 'Teknisi tekun',
                      description: 'Selesaikan tiga kasus yang berbeda.',
                      icon: Icons.handyman_rounded,
                      unlocked: dikerjakan >= 3,
                      progress: dikerjakan.clamp(0, 3),
                      target: 3,
                    ),
                    const SizedBox(height: 10),
                    _AchievementCard(
                      title: 'Problem solver',
                      description: 'Tuntaskan seluruh kasus yang tersedia.',
                      icon: Icons.military_tech_rounded,
                      unlocked: dikerjakan >= total,
                      progress: dikerjakan.clamp(0, total),
                      target: total,
                    ),
                    if (dikerjakan == 0) ...[
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _garis),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.lightbulb_outline, color: _biru),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Mulai dari satu kasus untuk membuka pencapaian pertamamu.',
                                style: TextStyle(color: _redup, height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _garis),
      ),
      child: Row(
        children: [
          Icon(icon, color: _biru),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: _redup, fontSize: 12),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    color: _tinta,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
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

class _AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool unlocked;
  final int progress;
  final int target;

  const _AchievementCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.unlocked,
    required this.progress,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    final warna = unlocked ? _biru : _redup;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: unlocked ? const Color(0xFFBFDBFE) : _garis),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: unlocked ? const Color(0xFFEFF6FF) : _latar,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: warna),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _tinta,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    color: _redup,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 9),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: target == 0 ? 0 : progress / target,
                    minHeight: 5,
                    backgroundColor: _latar,
                    valueColor: AlwaysStoppedAnimation<Color>(warna),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            unlocked ? Icons.check_circle_rounded : Icons.lock_outline_rounded,
            color: unlocked ? const Color(0xFF059669) : const Color(0xFF94A3B8),
            size: 20,
          ),
        ],
      ),
    );
  }
}
