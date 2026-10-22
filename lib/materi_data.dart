import 'package:flutter/material.dart';

class MateriPembelajaran {
  final String id;
  final String judul;
  final String deskripsi;
  final String kategori;
  final int durasiMenit;
  final IconData ikon;
  final List<String> kasusTerkait;
  final String tujuan;
  final String konsep;
  final List<String> karakteristik;
  final List<String> langkah;
  final String contoh;
  final String ringkasan;

  const MateriPembelajaran({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.kategori,
    required this.durasiMenit,
    required this.ikon,
    required this.kasusTerkait,
    required this.tujuan,
    required this.konsep,
    required this.karakteristik,
    required this.langkah,
    required this.contoh,
    required this.ringkasan,
  });
}

const daftarMateri = <MateriPembelajaran>[
  MateriPembelajaran(
    id: 'alur-daya-pc',
    judul: 'Alur Pemeriksaan Daya PC',
    deskripsi:
        'Telusuri sumber listrik hingga konektor daya komputer secara aman.',
    kategori: 'Hardware',
    durasiMenit: 5,
    ikon: Icons.power_rounded,
    kasusTerkait: ['Komputer tidak menyala'],
    tujuan: 'Menyusun pemeriksaan daya dari langkah paling sederhana sebelum mencurigai komponen internal.',
    konsep: 'Komputer membutuhkan sumber listrik, kabel yang terhubung baik, sakelar PSU, dan jalur daya motherboard. Pemeriksaan berurutan membantu menemukan titik putus tanpa mengganti komponen secara spekulatif.',
    karakteristik: [
      'Tidak ada lampu indikator, kipas, atau respons saat tombol daya ditekan.',
      'Kabel longgar, stopkontak mati, atau sakelar PSU dapat membuat komputer tampak rusak total.',
      'Jika sumber eksternal normal tetapi komputer tetap mati, barulah komponen internal perlu diperiksa.',
    ],
    langkah: [
      'Pastikan kabel daya terpasang rapat di komputer dan stopkontak.',
      'Uji stopkontak dengan perangkat lain yang diketahui berfungsi.',
      'Periksa sakelar PSU dan pastikan kabel daya motherboard terpasang dengan benar.',
      'Jika gejala tetap sama, lanjutkan pemeriksaan PSU oleh teknisi dengan prosedur aman.',
    ],
    contoh: 'Pada kasus “Komputer tidak menyala”, pemeriksaan kabel dan stopkontak menjadi langkah pertama sebelum menyimpulkan PSU rusak.',
    ringkasan: 'Mulai dari sumber daya eksternal, periksa sambungan, lalu lanjutkan ke PSU dan komponen internal.',
  ),
  MateriPembelajaran(
    id: 'diagnosis-psu',
    judul: 'Mengenali Peran PSU',
    deskripsi:
        'Pahami gejala catu daya bermasalah dan batas pemeriksaan yang aman.',
    kategori: 'Hardware',
    durasiMenit: 6,
    ikon: Icons.electrical_services_rounded,
    kasusTerkait: ['Komputer tidak menyala', 'Komputer sering restart'],
    tujuan: 'Menjelaskan peran PSU dan mengenali kapan gejala mengarah pada suplai daya yang tidak stabil.',
    konsep: 'Power Supply Unit mengubah listrik AC menjadi beberapa tegangan DC yang dibutuhkan komponen. PSU yang gagal atau tidak memadai dapat menyebabkan komputer tidak menyala atau mati ulang saat beban meningkat.',
    karakteristik: [
      'Komputer tidak merespons meskipun kabel dan stopkontak telah dipastikan baik.',
      'Restart atau mati mendadak dapat muncul ketika CPU dan GPU bekerja lebih berat.',
      'Gejala PSU dapat menyerupai kerusakan motherboard, sehingga perlu diagnosis bertahap.',
    ],
    langkah: [
      'Singkirkan masalah stopkontak, kabel, dan sakelar PSU terlebih dahulu.',
      'Catat apakah komputer mati total atau hanya restart saat beban tertentu.',
      'Periksa konektor dan tanda kerusakan yang terlihat tanpa membuka casing PSU.',
      'Minta teknisi menguji PSU dengan alat yang sesuai; jangan membuka unit PSU karena kapasitor dapat menyimpan tegangan berbahaya.',
    ],
    contoh: 'Pada kasus komputer yang restart saat digunakan berat, PSU menjadi salah satu kemungkinan setelah suhu dan kondisi RAM diperiksa.',
    ringkasan: 'PSU memasok daya untuk seluruh komponen. Gunakan pola gejala sebagai petunjuk, bukan bukti tunggal, dan hindari membongkar PSU.',
  ),
  MateriPembelajaran(
    id: 'rantai-sinyal-monitor',
    judul: 'Rantai Sinyal Monitor dan GPU',
    deskripsi: 'Ikuti jalur sinyal dari komputer ke layar untuk menemukan penyebab layar hitam.',
    kategori: 'Hardware',
    durasiMenit: 6,
    ikon: Icons.monitor_rounded,
    kasusTerkait: ['Monitor tidak menampilkan gambar'],
    tujuan: 'Mengidentifikasi bagian jalur tampilan yang perlu diperiksa saat monitor tidak menerima gambar.',
    konsep: 'Gambar melewati keluaran grafis komputer, kabel video, masukan monitor yang dipilih, lalu panel layar. Gangguan pada salah satu sambungan dapat menampilkan layar hitam atau pesan “No Signal”.',
    karakteristik: [
      'Monitor menyala tetapi menampilkan “No Signal”.',
      'Kabel mungkin longgar, rusak, atau terpasang pada keluaran yang tidak aktif.',
      'Sumber input monitor yang salah dapat terlihat sama seperti kerusakan komputer.',
    ],
    langkah: [
      'Pastikan monitor menyala dan kabel dayanya terpasang.',
      'Periksa kedua ujung kabel HDMI, DisplayPort, atau VGA.',
      'Pilih input/source yang sesuai pada menu monitor.',
      'Jika tersedia, uji kabel atau monitor dengan perangkat lain; setelah itu periksa keluaran GPU.',
    ],
    contoh: 'Pada kasus “Monitor tidak menampilkan gambar”, kabel video dan sumber input diperiksa sebelum mengganti motherboard atau memasang ulang sistem operasi.',
    ringkasan: 'Periksa daya monitor, kabel, sumber input, lalu keluaran grafis secara berurutan.',
  ),
  MateriPembelajaran(
    id: 'post-beep-ram',
    judul: 'POST, Beep Code, dan RAM',
    deskripsi: 'Gunakan gejala saat boot untuk mengarahkan pemeriksaan memori dan grafis.',
    kategori: 'Hardware',
    durasiMenit: 7,
    ikon: Icons.memory_rounded,
    kasusTerkait: ['Monitor tidak menampilkan gambar'],
    tujuan: 'Memahami pemeriksaan awal komputer saat dinyalakan dan menggunakan bunyi beep sebagai petunjuk.',
    konsep: 'POST (Power-On Self-Test) adalah pemeriksaan komponen dasar saat komputer mulai boot. Beep code bergantung pada BIOS dan motherboard tertentu; pola bunyi membantu mengarahkan diagnosis, tetapi artinya perlu dicocokkan dengan dokumentasi perangkat.',
    karakteristik: [
      'Kipas berputar tetapi komputer tidak menampilkan gambar.',
      'Beep berulang atau indikator diagnostik dapat menunjukkan masalah memori atau grafis.',
      'Satu pola beep tidak memiliki arti universal untuk semua komputer.',
    ],
    langkah: [
      'Catat jumlah dan pola beep, atau indikator lampu diagnostik.',
      'Cari arti pola pada dokumentasi motherboard atau produsen komputer.',
      'Matikan komputer, cabut daya, lalu minta bantuan yang kompeten untuk memeriksa pemasangan RAM atau kartu grafis.',
      'Uji satu perubahan dalam satu waktu dan nyalakan kembali untuk membandingkan gejala.',
    ],
    contoh: 'Jika layar tetap hitam dan terdengar beep berulang, materi kasus mengarahkan perhatian pada RAM atau VGA sebelum komponen lain.',
    ringkasan: 'POST dan beep memberikan petunjuk awal; cocokkan kode dengan dokumentasi dan lakukan pemeriksaan komponen secara aman.',
  ),
  MateriPembelajaran(
    id: 'overheating-restart',
    judul: 'Overheating dan Restart Otomatis',
    deskripsi: 'Kenali hubungan suhu, pendinginan, dan komputer yang restart saat beban tinggi.',
    kategori: 'Hardware',
    durasiMenit: 6,
    ikon: Icons.device_thermostat_rounded,
    kasusTerkait: ['Komputer sering restart'],
    tujuan: 'Menjelaskan bagaimana suhu berlebih dapat memicu penurunan performa, mati, atau restart otomatis.',
    konsep: 'CPU dan GPU menghasilkan panas saat bekerja. Kipas, heatsink, aliran udara casing, dan thermal interface membantu membuang panas. Perlindungan termal dapat membatasi performa atau mematikan sistem untuk mencegah kerusakan.',
    karakteristik: [
      'Restart lebih sering terjadi saat bermain gim, rendering, atau beban tinggi.',
      'Kipas bising, ventilasi tertutup, atau debu berlebih dapat menghambat aliran udara.',
      'Restart juga dapat disebabkan RAM, PSU, atau software; suhu perlu diukur, bukan ditebak.',
    ],
    langkah: [
      'Catat kapan restart terjadi dan periksa suhu dengan alat pemantau tepercaya.',
      'Pastikan ventilasi tidak tertutup dan komputer memiliki ruang aliran udara.',
      'Matikan serta cabut daya sebelum membersihkan debu luar dengan cara yang aman.',
      'Jika suhu tetap tinggi, kipas bermasalah, atau perangkat perlu dibongkar, minta bantuan teknisi.',
    ],
    contoh: 'Pada kasus komputer sering restart saat dipakai berat, periksa suhu dan kebersihan kipas sebelum memutuskan mengganti PSU.',
    ringkasan: 'Hubungkan waktu terjadinya restart dengan data suhu dan kondisi pendinginan sebelum memilih perbaikan.',
  ),
  MateriPembelajaran(
    id: 'restart-ram-psu',
    judul: 'Membedakan Restart: RAM dan PSU',
    deskripsi: 'Bandingkan petunjuk masalah memori dan suplai daya setelah suhu normal.',
    kategori: 'Hardware',
    durasiMenit: 7,
    ikon: Icons.restart_alt_rounded,
    kasusTerkait: ['Komputer sering restart'],
    tujuan: 'Menggunakan pola restart untuk memilih pemeriksaan berikutnya ketika suhu tidak menunjukkan masalah.',
    konsep: 'RAM menyimpan data kerja sementara, sedangkan PSU menyuplai daya. Kesalahan memori bisa menimbulkan crash atau boot gagal; suplai daya yang tidak stabil bisa membuat komputer mati atau restart, khususnya saat beban berubah.',
    karakteristik: [
      'Masalah RAM dapat disertai crash, layar biru, atau kegagalan boot.',
      'Masalah suplai daya dapat tampak saat komputer menerima beban lebih tinggi.',
      'Gejala dapat tumpang tindih sehingga perlu pengujian sistematis.',
    ],
    langkah: [
      'Catat pesan error, waktu restart, dan perubahan terakhir pada perangkat.',
      'Periksa log sistem atau jalankan diagnostik memori yang tersedia.',
      'Pastikan konektor daya terpasang baik tanpa membuka atau memperbaiki PSU.',
      'Uji satu kemungkinan pada satu waktu; bawa ke teknisi jika perlu melepas komponen internal.',
    ],
    contoh: 'Pada kasus restart yang suhunya normal, langkah berikutnya adalah memeriksa RAM serta kapasitas dan kondisi PSU.',
    ringkasan: 'Setelah suhu diperiksa, gunakan pola gejala dan diagnostik memori/daya untuk mempersempit penyebab.',
  ),
  MateriPembelajaran(
    id: 'diagnosis-jaringan',
    judul: 'Diagnosis Jaringan Berlapis',
    deskripsi: 'Temukan titik gangguan jaringan dari koneksi fisik hingga akses internet.',
    kategori: 'Jaringan',
    durasiMenit: 6,
    ikon: Icons.router_rounded,
    kasusTerkait: ['Tidak ada koneksi internet'],
    tujuan: 'Menyusun pemeriksaan jaringan dari perangkat lokal menuju router dan layanan internet.',
    konsep: 'Koneksi jaringan bergantung pada beberapa tahap: sambungan Wi-Fi atau kabel, alamat jaringan lokal, gateway/router, lalu koneksi ke luar jaringan. Menguji setiap tahap membantu menentukan area gangguan.',
    karakteristik: [
      'Perangkat dapat terputus dari Wi-Fi atau kabel LAN.',
      'Perangkat dapat tersambung ke router tetapi tetap tidak mencapai internet.',
      'Hasil ping ke alamat IP dan nama domain dapat memberikan petunjuk berbeda.',
    ],
    langkah: [
      'Pastikan Wi-Fi aktif atau kabel LAN terpasang dan router menyala.',
      'Bandingkan koneksi dengan perangkat lain pada jaringan yang sama.',
      'Uji gateway lokal, lalu uji alamat IP internet jika sesuai dengan jaringan.',
      'Jika koneksi IP berhasil tetapi nama domain gagal, periksa konfigurasi DNS.',
    ],
    contoh: 'Pada kasus “Tidak ada koneksi internet”, ping ke alamat IP berhasil tetapi akses nama domain gagal mengarahkan pemeriksaan ke DNS.',
    ringkasan: 'Uji sambungan, jaringan lokal, gateway, koneksi IP, lalu resolusi nama agar sumber gangguan lebih jelas.',
  ),
  MateriPembelajaran(
    id: 'dns-resolusi',
    judul: 'DNS dan Resolusi Nama Domain',
    deskripsi: 'Pahami cara nama situs diterjemahkan menjadi alamat IP dan cara mengenali gangguannya.',
    kategori: 'Jaringan',
    durasiMenit: 5,
    ikon: Icons.language_rounded,
    kasusTerkait: ['Tidak ada koneksi internet'],
    tujuan: 'Membedakan gangguan koneksi IP dari kegagalan menerjemahkan nama domain.',
    konsep: 'DNS (Domain Name System) mencari alamat IP yang terkait dengan nama domain. Perangkat mengirim kueri ke resolver DNS; jika kueri gagal, situs dapat tidak terbuka meskipun koneksi IP masih berfungsi.',
    karakteristik: [
      'Akses ke alamat IP dapat berhasil sementara nama domain gagal.',
      'Gangguan bisa berasal dari resolver, konfigurasi DNS, atau cache yang tidak sesuai.',
      'Ping ke sebuah alamat saja tidak membuktikan seluruh layanan internet berfungsi.',
    ],
    langkah: [
      'Pastikan perangkat benar-benar terhubung ke jaringan dan gateway dapat dijangkau.',
      'Bandingkan akses ke alamat IP dengan akses ke nama domain.',
      'Periksa konfigurasi DNS perangkat atau router dan pesan kesalahan resolusi.',
      'Gunakan pengaturan DNS yang dikelola secara sah oleh jaringan atau penyedia, lalu uji ulang.',
    ],
    contoh: 'Dalam studi kasus TroubleFix, ping ke 8.8.8.8 yang berhasil tetapi google.com gagal menunjukkan kemungkinan masalah resolusi DNS.',
    ringkasan: 'DNS menghubungkan nama domain ke alamat IP. Perbandingan uji IP dan nama membantu mengisolasi gangguan.',
  ),
  MateriPembelajaran(
    id: 'printer-driver',
    judul: 'Koneksi Printer dan Driver',
    deskripsi: 'Periksa daya, sambungan, dan perangkat lunak yang membuat printer dikenali.',
    kategori: 'Software',
    durasiMenit: 6,
    ikon: Icons.print_rounded,
    kasusTerkait: ['Printer tidak terdeteksi'],
    tujuan: 'Menentukan apakah printer tidak terdeteksi karena sambungan fisik, jaringan, atau driver.',
    konsep: 'Sistem operasi berkomunikasi dengan printer melalui koneksi USB/jaringan dan driver yang sesuai model. Tanpa daya, koneksi, atau driver yang benar, printer bisa tidak muncul atau tidak dapat menerima pekerjaan.',
    karakteristik: [
      'Printer tidak muncul di daftar perangkat atau berstatus offline.',
      'Koneksi USB/jaringan yang terputus dapat menyerupai masalah driver.',
      'Driver yang tidak sesuai model atau versi sistem dapat menghambat komunikasi.',
    ],
    langkah: [
      'Pastikan printer menyala dan tidak menunjukkan pesan error pada panelnya.',
      'Periksa kabel USB atau koneksi jaringan, lalu pastikan komputer dan printer berada pada jaringan yang sesuai.',
      'Periksa antrean serta status perangkat di pengaturan sistem operasi.',
      'Pasang atau perbarui driver dari sumber resmi sesuai model printer.',
    ],
    contoh: 'Pada kasus “Printer tidak terdeteksi”, koneksi fisik diperiksa lebih dahulu; jika normal, lanjutkan dengan memasang atau memperbarui driver.',
    ringkasan: 'Pastikan daya dan koneksi printer, lalu periksa status sistem dan driver yang cocok dengan modelnya.',
  ),
  MateriPembelajaran(
    id: 'antrean-cetak',
    judul: 'Antrean Cetak dan Print Spooler',
    deskripsi:
        'Pahami mengapa dokumen tertahan dan cara memulihkan layanan cetak.',
    kategori: 'Software',
    durasiMenit: 5,
    ikon: Icons.queue_rounded,
    kasusTerkait: ['Printer tidak terdeteksi'],
    tujuan: 'Membedakan masalah printer yang tidak dikenali dari pekerjaan cetak yang macet di antrean.',
    konsep: 'Print spooler mengelola pekerjaan cetak yang menunggu diproses. Dokumen yang gagal atau layanan yang berhenti dapat menahan pekerjaan lain dalam antrean.',
    karakteristik: [
      'Dokumen berstatus pending atau error dan tidak kunjung dicetak.',
      'Pekerjaan baru ikut tertahan di belakang dokumen yang macet.',
      'Printer dapat terdeteksi normal meskipun antrean cetaknya bermasalah.',
    ],
    langkah: [
      'Periksa status printer, kertas, tinta, dan koneksi terlebih dahulu.',
      'Buka antrean cetak dan catat pekerjaan yang berstatus error.',
      'Batalkan pekerjaan macet melalui antarmuka sistem operasi.',
      'Jika antrean tetap macet, mulai ulang layanan Print Spooler melalui prosedur sistem yang sesuai.',
    ],
    contoh: 'Jika printer terdeteksi tetapi dokumen tertahan, kasus TroubleFix mengarahkan pengguna membersihkan antrean atau memulai ulang Print Spooler.',
    ringkasan: 'Periksa koneksi dan status printer, lalu kelola antrean atau layanan spooler jika pekerjaan tetap tertahan.',
  ),
];

List<MateriPembelajaran> materiUntukKasus(String judulKasus) {
  return daftarMateri
      .where((materi) => materi.kasusTerkait.contains(judulKasus))
      .toList(growable: false);
}
