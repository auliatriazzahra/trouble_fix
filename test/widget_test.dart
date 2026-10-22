import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trouble_fix/case_play.dart';
import 'package:trouble_fix/cases.dart';
import 'package:trouble_fix/dashboard.dart';
import 'package:trouble_fix/main.dart';
import 'package:trouble_fix/progress.dart';

void main() {
  testWidgets('dashboard and case list fit a narrow viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    ProgressStore.reset();

    await tester.pumpWidget(const TroubleFixApp());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final menuKasus = find.text('Daftar Kasus');
    await tester.ensureVisible(menuKasus);
    await tester.tap(menuKasus);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final caseTitle = find.text('Komputer tidak menyala');
    await tester.ensureVisible(caseTitle);
    await tester.tap(caseTitle);
    await tester.pumpAndSettle();
    expect(find.byType(CaseDetailPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens the dashboard without requiring login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TroubleFixApp());

    expect(find.byType(DashboardPage), findsOneWidget);
    expect(find.text('Halo, Pengguna 👋'), findsOneWidget);
    expect(find.text('LOGIN'), findsNothing);
    expect(find.text('DAFTAR'), findsNothing);

    final menuKasus = find.text('Daftar Kasus');
    await tester.ensureVisible(menuKasus);
    await tester.tap(menuKasus);
    await tester.pumpAndSettle();

    expect(find.byType(CasesPage), findsOneWidget);
    expect(find.text('Latihan troubleshooting'), findsOneWidget);

    final caseTitle = find.text('Komputer tidak menyala');
    await tester.ensureVisible(caseTitle);
    await tester.tap(caseTitle);
    await tester.pumpAndSettle();
    expect(find.byType(CaseDetailPage), findsOneWidget);

    final startButton = find.text('MULAI KASUS');
    await tester.ensureVisible(startButton);
    await tester.tap(startButton);
    await tester.pumpAndSettle();
    expect(find.byType(CasePlayPage), findsOneWidget);

    await _jawab(
      tester,
      'Pastikan kabel power tertancap dan stopkontak ada listrik',
    );
    await _lanjut(tester, 'LANJUTKAN');
    await _jawab(tester, 'Power Supply (PSU)');
    await _lanjut(tester, 'LANJUTKAN');
    await _jawab(
      tester,
      'Cabut semua perangkat tambahan, lalu cek RAM dan kabel power ke motherboard',
    );
    await _lanjut(tester, 'LIHAT HASIL');

    expect(find.text('Kasus Selesai!'), findsOneWidget);
    expect(ProgressStore.jumlahSelesai, 1);
    expect(ProgressStore.riwayat.value, hasLength(1));

    final backToDashboard = find.text('KEMBALI KE DASHBOARD');
    await tester.ensureVisible(backToDashboard);
    await tester.tap(backToDashboard);
    await tester.pumpAndSettle();
    expect(find.byType(DashboardPage), findsOneWidget);
  });
}

Future<void> _jawab(WidgetTester tester, String jawaban) async {
  final pilihan = find.text(jawaban);
  await tester.ensureVisible(pilihan);
  await tester.tap(pilihan);
  await tester.pumpAndSettle();
}

Future<void> _lanjut(WidgetTester tester, String label) async {
  final tombol = find.text(label);
  await tester.ensureVisible(tombol);
  await tester.tap(tombol);
  await tester.pumpAndSettle();
}
