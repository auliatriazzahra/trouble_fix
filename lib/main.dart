import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'dashboard.dart';
import 'progress.dart';

void main() {
  runApp(const TroubleFixApp());
}

class TroubleFixApp extends StatelessWidget {
  const TroubleFixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TroubleFix',
      theme: AppTheme.light,
      home: ValueListenableBuilder<String>(
        valueListenable: ProgressStore.nama,
        builder: (context, nama, _) => DashboardPage(namaPengguna: nama),
      ),
    );
  }
}