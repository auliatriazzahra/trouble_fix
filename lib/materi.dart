import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'materi_data.dart';
import 'progress.dart';

typedef BukaKasusTerkait = void Function(
  BuildContext context,
  String judulKasus,
);

class MateriPage extends StatefulWidget {
  final BukaKasusTerkait bukaKasusTerkait;

  const MateriPage({super.key, required this.bukaKasusTerkait});

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  String _kategori = 'Semua';
  String _kueri = '';

  @override
  Widget build(BuildContext context) {
    final daftar = daftarMateri
        .where((materi) {
          final cocokKategori =
              _kategori == 'Semua' || materi.kategori == _kategori;
          final cocokKueri =
              '${materi.judul} ${materi.deskripsi} ${materi.kategori}'
                  .toLowerCase()
                  .contains(_kueri.trim().toLowerCase());
          return cocokKategori && cocokKueri;
        })
        .toList(growable: false);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Materi Pembelajaran')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pahami konsep, lalu praktikkan',
                  style: AppTextStyles.heading(fontSize: 24),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Pelajari dasar diagnosis perangkat, jaringan, dan printer sebelum menerapkannya pada studi kasus.',
                  style: TextStyle(color: AppColors.textSecondary, height: 1.5),
                ),
                const SizedBox(height: 18),
                TextField(
                  onChanged: (value) => setState(() => _kueri = value),
                  decoration: const InputDecoration(
                    hintText: 'Cari materi',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final kategori in const [
                        'Semua',
                        'Hardware',
                        'Jaringan',
                        'Software',
                      ])
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(kategori),
                            selected: _kategori == kategori,
                            onSelected: (_) =>
                                setState(() => _kategori = kategori),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${daftar.length} materi tersedia',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 10),
                if (daftar.isEmpty)
                  const _MateriKosong()
                else
                  for (final materi in daftar) ...[
                    MateriTerkaitCard(
                      materi: materi,
                      onTap: () => _bukaMateri(context, materi),
                    ),
                    const SizedBox(height: 10),
                  ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _bukaMateri(BuildContext context, MateriPembelajaran materi) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => MateriDetailPage(
          materi: materi,
          onKembaliKeKasus: (materiContext) =>
              widget.bukaKasusTerkait(materiContext, materi.kasusTerkait.first),
        ),
      ),
    );
  }
}

class MateriTerkaitCard extends StatelessWidget {
  final MateriPembelajaran materi;
  final VoidCallback onTap;

  const MateriTerkaitCard({
    super.key,
    required this.materi,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: ProgressStore.materiSelesai,
      builder: (context, selesai, _) {
        final sudahSelesai = selesai.contains(materi.id);
        final warnaStatus = sudahSelesai
            ? AppColors.success
            : AppColors.textSecondary;

        return Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(materi.ikon, color: AppColors.primary),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          materi.judul,
                          style: AppTextStyles.heading(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          materi.deskripsi,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            _LabelMateri(
                              icon: Icons.category_outlined,
                              text: materi.kategori,
                            ),
                            _LabelMateri(
                              icon: Icons.schedule_rounded,
                              text: '${materi.durasiMenit} menit',
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  sudahSelesai
                                      ? Icons.check_circle_rounded
                                      : Icons.radio_button_unchecked_rounded,
                                  size: 15,
                                  color: warnaStatus,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    sudahSelesai
                                        ? 'Selesai'
                                        : 'Belum Dipelajari',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: warnaStatus,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MateriDetailPage extends StatefulWidget {
  final MateriPembelajaran materi;
  final ValueChanged<BuildContext> onKembaliKeKasus;

  const MateriDetailPage({
    super.key,
    required this.materi,
    required this.onKembaliKeKasus,
  });

  @override
  State<MateriDetailPage> createState() => _MateriDetailPageState();
}

class _MateriDetailPageState extends State<MateriDetailPage> {
  bool _menyimpan = false;

  @override
  Widget build(BuildContext context) {
    final materi = widget.materi;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Materi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          materi.ikon,
                          color: AppColors.primary,
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        materi.judul,
                        style: AppTextStyles.heading(fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        materi.deskripsi,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          _LabelMateri(
                            icon: Icons.category_outlined,
                            text: materi.kategori,
                          ),
                          _LabelMateri(
                            icon: Icons.schedule_rounded,
                            text: '${materi.durasiMenit} menit',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _BagianMateri(
                  judul: 'Tujuan pembelajaran',
                  ikon: Icons.flag_outlined,
                  isi: materi.tujuan,
                ),
                const SizedBox(height: 12),
                _BagianMateri(
                  judul: 'Konsep dasar',
                  ikon: Icons.lightbulb_outline_rounded,
                  isi: materi.konsep,
                ),
                const SizedBox(height: 12),
                _BagianMateri(
                  judul: 'Penyebab dan karakteristik',
                  ikon: Icons.manage_search_rounded,
                  butir: materi.karakteristik,
                ),
                const SizedBox(height: 12),
                _BagianMateri(
                  judul: 'Langkah analisis dan penyelesaian',
                  ikon: Icons.format_list_numbered_rounded,
                  butir: materi.langkah,
                ),
                const SizedBox(height: 12),
                _BagianMateri(
                  judul: 'Contoh pada studi kasus',
                  ikon: Icons.library_books_outlined,
                  isi: materi.contoh,
                ),
                const SizedBox(height: 12),
                _BagianMateri(
                  judul: 'Ringkasan',
                  ikon: Icons.summarize_outlined,
                  isi: materi.ringkasan,
                ),
                const SizedBox(height: 18),
                ValueListenableBuilder<Set<String>>(
                  valueListenable: ProgressStore.materiSelesai,
                  builder: (context, selesai, _) {
                    final sudahSelesai = selesai.contains(materi.id);
                    return SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _menyimpan || sudahSelesai
                            ? null
                            : () => _tandaiSelesai(context),
                        icon: Icon(
                          sudahSelesai
                              ? Icons.check_circle_rounded
                              : Icons.bookmark_added_outlined,
                        ),
                        label: Text(
                          sudahSelesai
                              ? 'Selesai dipelajari'
                              : _menyimpan
                              ? 'Menyimpan...'
                              : 'Tandai selesai dipelajari',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => widget.onKembaliKeKasus(context),
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: const Text('Kembali ke studi kasus terkait'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _tandaiSelesai(BuildContext context) async {
    setState(() => _menyimpan = true);
    try {
      await ProgressStore.tandaiMateriSelesai(widget.materi.id, selesai: true);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Materi tersimpan sebagai selesai.')),
        );
      }
    } catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'TroubleFix',
          context: ErrorDescription('while saving learning progress'),
        ),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Status materi gagal disimpan. Coba lagi.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _menyimpan = false);
    }
  }
}

class _BagianMateri extends StatelessWidget {
  final String judul;
  final IconData ikon;
  final String? isi;
  final List<String>? butir;

  const _BagianMateri({
    required this.judul,
    required this.ikon,
    this.isi,
    this.butir,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ikon, color: AppColors.primary, size: 21),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  judul,
                  style: AppTextStyles.heading(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (isi != null) ...[
            const SizedBox(height: 10),
            Text(
              isi!,
              style: const TextStyle(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
          if (butir != null) ...[
            const SizedBox(height: 9),
            for (var i = 0; i < butir!.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 23,
                      height: 23,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        butir![i],
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _LabelMateri extends StatelessWidget {
  final IconData icon;
  final String text;

  const _LabelMateri({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _MateriKosong extends StatelessWidget {
  const _MateriKosong();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.menu_book_outlined,
            color: AppColors.textSecondary,
            size: 38,
          ),
          SizedBox(height: 10),
          Text(
            'Materi tidak ditemukan',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Coba kata kunci atau kategori lain.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
