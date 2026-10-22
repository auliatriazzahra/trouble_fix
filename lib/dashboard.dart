import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'cases.dart';
import 'materi.dart';
import 'progress.dart';
import 'riwayat.dart';
import 'peringkat.dart';
import 'pengaturan.dart';

const _navy = Color(0xFF101B3D);
const _biru = Color(0xFF4169F5);
const _cyan = Color(0xFF5DE0E6);
const _latar = Color(0xFFFAF9F6);
const _tinta = Color(0xFF182442);
const _redup = Color(0xFF78839C);

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
        icon: Icons.terminal_rounded,
        title: 'Jelajahi Kasus',
        subtitle: 'Pecahkan masalah komputer nyata',
        tag: 'LATIHAN',
        warna: const Color(0xFF4169F5),
        halaman: const CasesPage(),
      ),
      _MenuData(
        icon: Icons.menu_book_rounded,
        title: 'Materi Pembelajaran',
        subtitle: 'Pahami konsep sebelum memecahkan kasus',
        tag: 'MATERI',
        warna: const Color(0xFF0DAD9B),
        halaman: MateriPage(
          bukaKasusTerkait: (context, judulKasus) => CasesPage.openCase(
            context,
            judulKasus,
            replaceCurrentRoute: true,
          ),
        ),
      ),
      _MenuData(
        icon: Icons.timeline_rounded,
        title: 'Riwayat Belajar',
        subtitle: 'Lihat perjalanan belajarmu',
        tag: 'AKTIVITAS',
        warna: const Color(0xFF8B5CF6),
        halaman: const RiwayatPage(),
      ),
      _MenuData(
        icon: Icons.workspace_premium_rounded,
        title: 'Pencapaian',
        subtitle: 'Pantau skor dan prestasimu',
        tag: 'REWARD',
        warna: const Color(0xFFF59E0B),
        halaman: const PeringkatPage(),
      ),
      _MenuData(
        icon: Icons.tune_rounded,
        title: 'Pengaturan',
        subtitle: 'Sesuaikan pengalaman aplikasi',
        tag: 'PREFERENSI',
        warna: const Color(0xFF0DAD9B),
        halaman: const PengaturanPage(),
      ),
    ];

    return Scaffold(
      backgroundColor: _latar,
      drawer: _buildDrawer(context, nama, inisial, menu),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final lebar = constraints.maxWidth;
            final mobile = lebar < 600;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1120),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          mobile ? 18 : 32,
                          16,
                          mobile ? 18 : 32,
                          32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTopBar(context, nama, inisial),
                            const SizedBox(height: 28),
                            _buildHero(context, nama, mobile),
                            const SizedBox(height: 26),
                            _buildSectionHeading(
                              'Ringkasan aktivitas',
                              'Perkembanganmu sejauh ini',
                              Icons.analytics_outlined,
                            ),
                            const SizedBox(height: 14),
                            ValueListenableBuilder<Map<String, int>>(
                              valueListenable: ProgressStore.selesai,
                              builder: (context, _, _) {
                                final jumlah = ProgressStore.jumlahSelesai;
                                final total = ProgressStore.totalKasus;
                                final skor = ProgressStore.skorTotal;
                                final selesai = total > 0 && jumlah >= total;

                                return LayoutBuilder(
                                  builder: (context, box) {
                                    final duaKolom = box.maxWidth >= 500;
                                    final jarak = 12.0;
                                    final lebarKartu = duaKolom
                                        ? (box.maxWidth - jarak) / 2
                                        : box.maxWidth;

                                    return Wrap(
                                      spacing: jarak,
                                      runSpacing: jarak,
                                      children: [
                                        SizedBox(
                                          width: lebarKartu,
                                          child: _StatCard(
                                            icon: Icons.task_alt_rounded,
                                            label: 'Kasus diselesaikan',
                                            value: '$jumlah',
                                            suffix: '/ $total',
                                            footnote: selesai
                                                ? 'Semua kasus selesai!'
                                                : 'Terus tingkatkan progresmu',
                                            warna: const Color(0xFF4169F5),
                                            progress: total > 0
                                                ? (jumlah / total).clamp(
                                                    0.0,
                                                    1.0,
                                                  )
                                                : 0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: lebarKartu,
                                          child: _StatCard(
                                            icon: Icons.bolt_rounded,
                                            label: 'Total poin',
                                            value: '$skor',
                                            suffix: 'XP',
                                            footnote:
                                                'Kumpulkan poin dari latihan',
                                            warna: const Color(0xFFED9C28),
                                            progress: null,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 30),
                            _buildSectionHeading(
                              'Pusat aktivitas',
                              'Pilih langkah berikutnya',
                              Icons.grid_view_rounded,
                            ),
                            const SizedBox(height: 14),
                            LayoutBuilder(
                              builder: (context, box) {
                                final kolom = box.maxWidth >= 760
                                    ? 2
                                    : box.maxWidth >= 500
                                    ? 2
                                    : 1;
                                const jarak = 14.0;
                                final lebarKartu = kolom == 1
                                    ? box.maxWidth
                                    : (box.maxWidth - jarak) / 2;

                                return Wrap(
                                  spacing: jarak,
                                  runSpacing: jarak,
                                  children: [
                                    for (int i = 0; i < menu.length; i++)
                                      SizedBox(
                                        width: lebarKartu,
                                        child: _MenuCard(
                                          data: menu[i],
                                          index: i,
                                          onTap: () =>
                                              _buka(context, menu[i].halaman),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildFooter(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, String nama, String inisial) {
    return Row(
      children: [
        Builder(
          builder: (context) => _TopButton(
            icon: Icons.menu_rounded,
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_biru, Color(0xFF7958F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: _biru.withValues(alpha: 0.22),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.handyman_rounded,
            color: Colors.white,
            size: 23,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TroubleFix',
                style: AppTextStyles.heading(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: _navy,
                ),
              ),
              const Text(
                'LEARN • SOLVE • LEVEL UP',
                style: TextStyle(
                  color: _redup,
                  fontSize: 9,
                  letterSpacing: 1.05,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        _TopButton(
          icon: Icons.settings_outlined,
          onTap: () => _buka(context, const PengaturanPage()),
        ),
        const SizedBox(width: 10),
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: const Color(0xFFE2E9FF),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            inisial,
            style: const TextStyle(
              color: _biru,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHero(BuildContext context, String nama, bool mobile) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 240),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF111B3D), Color(0xFF202F65), Color(0xFF344FAD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF263A80).withValues(alpha: 0.20),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned(
              right: -45,
              top: -65,
              child: _GlowCircle(
                size: mobile ? 190 : 240,
                color: _cyan.withValues(alpha: 0.10),
              ),
            ),
            Positioned(
              right: mobile ? 60 : 190,
              bottom: -95,
              child: _GlowCircle(
                size: 180,
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
              ),
            ),
            Positioned(
              right: mobile ? -15 : 30,
              top: 30,
              child: Opacity(
                opacity: 0.12,
                child: Icon(
                  Icons.memory_rounded,
                  size: mobile ? 110 : 175,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(mobile ? 22 : 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome_rounded,
                          color: _cyan,
                          size: 15,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'YOUR TECH JOURNEY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Hai, $nama!',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading(
                      fontSize: mobile ? 28 : 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: const Text(
                      'Setiap masalah punya solusi. Yuk, asah skill troubleshooting-mu hari ini.',
                      style: TextStyle(
                        color: Color(0xFFD4DDF7),
                        fontSize: 13,
                        height: 1.7,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  ValueListenableBuilder<Map<String, int>>(
                    valueListenable: ProgressStore.selesai,
                    builder: (context, _, _) {
                      final persen = ProgressStore.persen;
                      return Row(
                        children: [
                          Flexible(
                            child: FilledButton.icon(
                              onPressed: () =>
                                  _buka(context, const CasesPage()),
                              style: FilledButton.styleFrom(
                                backgroundColor: _cyan,
                                foregroundColor: _navy,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              icon: const Icon(
                                Icons.play_arrow_rounded,
                                size: 21,
                              ),
                              label: const Text(
                                'Mulai belajar',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${(persen * 100).round()}% selesai',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: LinearProgressIndicator(
                                    value: persen.clamp(0.0, 1.0),
                                    minHeight: 6,
                                    backgroundColor: Colors.white24,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          _cyan,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeading(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFE6EAF4)),
          ),
          child: Icon(icon, color: _biru, size: 21),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.heading(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _navy,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: _redup),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(
    BuildContext context,
    String nama,
    String inisial,
    List<_MenuData> menu,
  ) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(22, 25, 22, 26),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_navy, Color(0xFF344FAD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.handyman_rounded,
                      color: _cyan,
                      size: 27,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'TroubleFix • $inisial',
                    style: const TextStyle(
                      color: Color(0xFFCFD9F7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _DrawerItem(
              icon: Icons.dashboard_rounded,
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
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'LEARN • SOLVE • LEVEL UP',
                style: TextStyle(
                  color: _redup,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EDFA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: _biru, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tips: pahami gejala masalah sebelum menentukan solusinya.',
              style: TextStyle(
                color: _tinta,
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String tag;
  final Color warna;
  final Widget halaman;

  const _MenuData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.warna,
    required this.halaman,
  });
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _TopButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE6EAF4)),
          ),
          child: Icon(icon, color: _navy, size: 21),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String suffix;
  final String footnote;
  final Color warna;
  final double? progress;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.suffix,
    required this.footnote,
    required this.warna,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9EDF5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF27375D).withValues(alpha: 0.035),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: warna.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: warna, size: 23),
              ),
              const Spacer(),
              if (progress != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF8F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'PROGRES',
                    style: TextStyle(
                      color: Color(0xFF12845D),
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            label,
            style: const TextStyle(
              color: _redup,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading(
                    fontSize: 31,
                    fontWeight: FontWeight.w800,
                    color: _navy,
                    letterSpacing: -0.8,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5),
                child: Text(
                  suffix,
                  style: TextStyle(
                    color: warna,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress!.clamp(0.0, 1.0),
                minHeight: 5,
                backgroundColor: const Color(0xFFEEF1F8),
                valueColor: AlwaysStoppedAnimation<Color>(warna),
              ),
            ),
            const SizedBox(height: 10),
          ] else
            const SizedBox(height: 10),
          Text(
            footnote,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _redup, fontSize: 11, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final _MenuData data;
  final int index;
  final VoidCallback onTap;

  const _MenuCard({
    required this.data,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          constraints: const BoxConstraints(minHeight: 142),
          padding: const EdgeInsets.all(19),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFE8ECF5)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF27375D).withValues(alpha: 0.025),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 49,
                    height: 49,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          data.warna.withValues(alpha: 0.16),
                          data.warna.withValues(alpha: 0.07),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(data.icon, color: data.warna, size: 25),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: data.warna.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      data.tag,
                      style: TextStyle(
                        color: data.warna,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.65,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data.title,
                      style: AppTextStyles.heading(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: _navy,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: data.warna,
                    size: 19,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                data.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _redup,
                  fontSize: 11.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: ListTile(
        selected: selected,
        selectedTileColor: const Color(0xFFEEF1FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Icon(icon, color: selected ? _biru : _redup),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? _biru : _tinta,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
            fontSize: 13,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: selected ? _biru : _redup,
        ),
        onTap: onTap,
      ),
    );
  }
}
