import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'dashboard.dart';
import 'progress.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await ProgressStore.muatMateriSelesai();
  } catch (error, stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'TroubleFix',
        context: ErrorDescription('while loading saved learning progress'),
      ),
    );
  }
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
