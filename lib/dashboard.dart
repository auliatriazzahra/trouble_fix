import 'package:flutter/material.dart';

import 'cases.dart';
import 'progress.dart';
import 'riwayat.dart';
import 'peringkat.dart';
import 'pengaturan.dart';

const _biru = Color(0xFF2563EB);
const _tinta = Color(0xFF172033);
const _latar = Color(0xFFF5F8FC);
const _garis = Color(0xFFE2E8F0);
const _redup = Color(0xFF64748B);

class DashboardPage extends StatelessWidget {
  final String namaPengguna;

  const DashboardPage({super.key, required this.namaPengguna});

  void _buka(BuildContext context, Widget halaman) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => halaman));
  }

  @override
  Widget build(BuildContext context) {
    final nama = namaPengguna.trim().isEmpty ? 'Pengguna' : namaPengguna.trim();
    final inisial = nama[0].toUpperCase();
    final menu = [
      _MenuData(
        icon: Icons.assignment_outlined,
        title: 'Daftar Kasus',
        subtitle: 'Latihan dari masalah komputer nyata',
        halaman: const CasesPage(),
      ),
      _MenuData(
        icon: Icons.history_rounded,
        title: 'Riwayat Belajar',
        subtitle: 'Tinjau hasil latihan sebelumnya',
        halaman: const RiwayatPage(),
      ),
      _MenuData(
        icon: Icons.emoji_events_outlined,
        title: 'Pencapaian',
        subtitle: 'Lihat kemajuan dan target belajarmu',
        halaman: const PeringkatPage(),
      ),
      _MenuData(
        icon: Icons.tune_rounded,
        title: 'Pengaturan',
        subtitle: 'Atur preferensi aplikasi',
        halaman: const PengaturanPage(),
      ),
    ];

    return Scaffold(
      backgroundColor: _latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            tooltip: 'Buka menu',
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: _biru,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.build_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'TroubleFix',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _tinta,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Pengaturan',
            onPressed: () => _buka(context, const PengaturanPage()),
            icon: const Icon(Icons.settings_outlined, color: _redup),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_biru, Color(0xFF1D4ED8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Text(
                        inisial,
                        style: const TextStyle(
                          color: _biru,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nama,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'Belajar mandiri, langsung mulai',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  children: [
                    _DrawerItem(
                      icon: Icons.dashboard_outlined,
                      title: 'Dashboard',
                      selected: true,
                      onTap: () => Navigator.pop(context),
                    ),
                    for (final item in menu)
                      _DrawerItem(
                        icon: item.icon,
                        title: item.title,
                        onTap: () {
                          Navigator.pop(context);
                          _buka(context, item.halaman);
                        },
                      ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'TroubleFix • Belajar troubleshooting',
                  style: TextStyle(color: _redup, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, $nama 👋',
                    style: const TextStyle(
                      color: _tinta,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.7,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Siap mengasah kemampuan troubleshooting hari ini?',
                    style: TextStyle(color: _redup, fontSize: 15, height: 1.4),
                  ),
                  const SizedBox(height: 24),
                  _ProgressCard(
                    onStart: () => _buka(context, const CasesPage()),
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final horizontal = constraints.maxWidth >= 520;
                      final width = horizontal
                          ? (constraints.maxWidth - 12) / 2
                          : constraints.maxWidth;
                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SizedBox(
                            width: width,
                            child: ValueListenableBuilder<Map<String, int>>(
                              valueListenable: ProgressStore.selesai,
                              builder: (context, _, _) => _StatCard(
                                icon: Icons.task_alt_rounded,
                                title: 'Kasus selesai',
                                value:
                                    '${ProgressStore.jumlahSelesai}/${ProgressStore.totalKasus}',
                                description: 'dari seluruh latihan',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: ValueListenableBuilder<Map<String, int>>(
                              valueListenable: ProgressStore.selesai,
                              builder: (context, _, _) => _StatCard(
                                icon: Icons.stars_rounded,
                                title: 'Total skor',
                                value: '${ProgressStore.skorTotal}',
                                description: 'poin terbaik per kasus',
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Menu belajar',
                    style: TextStyle(
                      color: _tinta,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Pilih aktivitas yang ingin kamu lanjutkan.',
                    style: TextStyle(color: _redup, fontSize: 14),
                  ),
                  const SizedBox(height: 14),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = constraints.maxWidth >= 700
                          ? 2
                          : constraints.maxWidth >= 440
                          ? 2
                          : 1;
                      final width = columns == 1
                          ? constraints.maxWidth
                          : (constraints.maxWidth - 14) / 2;
                      return Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          for (final item in menu)
                            SizedBox(
                              width: width,
                              child: _MenuCard(
                                icon: item.icon,
                                title: item.title,
                                subtitle: item.subtitle,
                                onTap: () => _buka(context, item.halaman),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget halaman;

  const _MenuData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.halaman,
  });
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: const Color(0xFFEFF6FF),
      leading: Icon(icon, color: selected ? _biru : _redup),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? _biru : _tinta,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: _redup),
      onTap: onTap,
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final VoidCallback onStart;

  const _ProgressCard({required this.onStart});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, int>>(
      valueListenable: ProgressStore.selesai,
      builder: (context, _, _) {
        final persen = ProgressStore.persen;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_biru, Color(0xFF1D4ED8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: _biru.withValues(alpha: 0.18),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final judul = const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROGRES BELAJAR',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Satu langkah lebih dekat menjadi problem solver.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          height: 1.35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                  final angka = Text(
                    '${(persen * 100).round()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  );
                  if (constraints.maxWidth < 400) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [judul, const SizedBox(height: 8), angka],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: judul),
                      const SizedBox(width: 12),
                      angka,
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: persen.clamp(0.0, 1.0),
                  minHeight: 9,
                  backgroundColor: Colors.white.withValues(alpha: 0.25),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  final ringkas = Text(
                    '${ProgressStore.jumlahSelesai} dari ${ProgressStore.totalKasus} kasus diselesaikan',
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  );
                  final tombol = TextButton.icon(
                    onPressed: onStart,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow_rounded, size: 19),
                    label: const Text('Mulai belajar'),
                  );
                  if (constraints.maxWidth < 430) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [ringkas, const SizedBox(height: 8), tombol],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: ringkas),
                      tombol,
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String description;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _garis),
      ),
      child: Row(
        children: [
          _IconBox(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: _redup, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: _tinta,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _redup, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          constraints: const BoxConstraints(minHeight: 100),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _garis),
          ),
          child: Row(
            children: [
              _IconBox(icon: icon),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _tinta,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _redup,
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded, color: _redup, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;

  const _IconBox({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: _biru, size: 24),
    );
  }
}
