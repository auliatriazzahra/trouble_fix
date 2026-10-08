import 'package:flutter/material.dart';
import 'cases.dart';

class DashboardPage extends StatelessWidget {
  final String namaPengguna;

  const DashboardPage({
    super.key,
    required this.namaPengguna,
  });

  @override
  Widget build(BuildContext context) {
    final String nama =
        namaPengguna.trim().isEmpty ? 'Pengguna' : namaPengguna.trim();

    final String inisial = nama[0].toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      // =====================================================
      // APP BAR
      // =====================================================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,

        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF172033),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),

        title: const Text(
          'TroubleFix',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF172033),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFDBEAFE),
              child: Text(
                inisial,
                style: const TextStyle(
                  color: Color(0xFF2563EB),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

      // =====================================================
      // DRAWER
      // =====================================================
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF2563EB),
              ),

              accountName: Text(
                nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              accountEmail: const Text(
                'Pengguna TroubleFix',
              ),

              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  inisial,
                  style: const TextStyle(
                    color: Color(0xFF2563EB),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard_outlined),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: const Text('Daftar Kasus'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CasesPage(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Riwayat Saya'),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(
                Icons.emoji_events_outlined,
              ),
              title: const Text('Peringkat'),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
              ),
              title: const Text('Pengaturan'),
              onTap: () {},
            ),
          ],
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1000,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =====================================================
                  // GREETING
                  // =====================================================

                  Text(
                    'Halo, $nama 👋',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF172033),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Semangat belajar hari ini!',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF64748B),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // =====================================================
                  // PROGRESS
                  // =====================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Progress Belajar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          '60%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(20),

                          child: const LinearProgressIndicator(
                            value: 0.0,
                            minHeight: 9,
                            backgroundColor:
                                Color(0xFF93C5FD),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          '6 dari 10 kasus telah diselesaikan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // =====================================================
                  // STATISTIK
                  // =====================================================

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool sempit =
                          constraints.maxWidth < 400;

                      if (sempit) {
                        return Column(
                          children: [
                            const _StatCard(
                              icon: Icons.check_circle_outline,
                              value: '0/10',
                              title: 'Kasus Selesai',
                            ),

                            const SizedBox(height: 12),

                            const _StatCard(
                              icon: Icons.stars_outlined,
                              value: '0',
                              title: 'Skor Total',
                            ),
                          ],
                        );
                      }

                      return const Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              icon:
                                  Icons.check_circle_outline,
                              value: '/10',
                              title: 'Kasus Selesai',
                            ),
                          ),

                          SizedBox(width: 14),

                          Expanded(
                            child: _StatCard(
                              icon: Icons.stars_outlined,
                              value: '0',
                              title: 'Skor Total',
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  // =====================================================
                  // MENU BELAJAR
                  // =====================================================

                  const Text(
                    'Menu Belajar',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF172033),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // =====================================================
                  // MENU RESPONSIVE
                  // =====================================================

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double lebar =
                          constraints.maxWidth;

                      // Layar kecil:
                      // 1 kolom
                      if (lebar < 550) {
                        return const Column(
                          children: [
                            _MenuCard(
                              icon: Icons.assignment_outlined,
                              title: 'Daftar Kasus',
                              subtitle:
                                  'Mulai latihan troubleshooting',
                            ),

                            SizedBox(height: 12),

                            _MenuCard(
                              icon: Icons.history,
                              title: 'Riwayat Saya',
                              subtitle:
                                  'Lihat kasus yang telah dikerjakan',
                            ),

                            SizedBox(height: 12),

                            _MenuCard(
                              icon:
                                  Icons.emoji_events_outlined,
                              title: 'Peringkat',
                              subtitle:
                                  'Lihat pencapaian belajar',
                            ),

                            SizedBox(height: 12),

                            _MenuCard(
                              icon: Icons.settings_outlined,
                              title: 'Pengaturan',
                              subtitle:
                                  'Atur profil dan aplikasi',
                            ),
                          ],
                        );
                      }

                      // Layar besar:
                      // 2 kolom
                      return Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          SizedBox(
                            width: (lebar - 14) / 2,
                            child: const _MenuCard(
                              icon:
                                  Icons.assignment_outlined,
                              title: 'Daftar Kasus',
                              subtitle:
                                  'Mulai latihan troubleshooting',
                            ),
                          ),

                          SizedBox(
                            width: (lebar - 14) / 2,
                            child: const _MenuCard(
                              icon: Icons.history,
                              title: 'Riwayat Saya',
                              subtitle:
                                  'Lihat kasus yang telah dikerjakan',
                            ),
                          ),

                          SizedBox(
                            width: (lebar - 14) / 2,
                            child: const _MenuCard(
                              icon:
                                  Icons.emoji_events_outlined,
                              title: 'Peringkat',
                              subtitle:
                                  'Lihat pencapaian belajar',
                            ),
                          ),

                          SizedBox(
                            width: (lebar - 14) / 2,
                            child: const _MenuCard(
                              icon: Icons.settings_outlined,
                              title: 'Pengaturan',
                              subtitle:
                                  'Atur profil dan aplikasi',
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// STAT CARD
// =====================================================

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            width: 46,
            height: 46,

            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: const Color(0xFF2563EB),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
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

// =====================================================
// MENU CARD
// =====================================================

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),

      child: LayoutBuilder(
        builder: (context, constraints) {
          // Kalau ruang sangat sempit,
          // susun icon dan teks secara vertikal.
          if (constraints.maxWidth < 230) {
            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                _IconBox(icon: icon),

                const SizedBox(height: 12),

                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.3,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            );
          }

          // Kalau ruang cukup,
          // icon dan teks dibuat berdampingan.
          return Row(
            crossAxisAlignment:
                CrossAxisAlignment.center,

            children: [
              _IconBox(icon: icon),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF172033),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.3,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =====================================================
// ICON BOX
// =====================================================

class _IconBox extends StatelessWidget {
  final IconData icon;

  const _IconBox({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,

      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(13),
      ),

      child: Icon(
        icon,
        color: const Color(0xFF2563EB),
        size: 25,
      ),
    );
  }
}