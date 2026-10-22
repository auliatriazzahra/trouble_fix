import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trouble_fix/pengaturan.dart';
import 'package:trouble_fix/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('display name can be changed locally', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    ProgressStore.nama.value = 'Pengguna';
    await tester.pumpWidget(const MaterialApp(home: PengaturanPage()));

    await tester.tap(find.byTooltip('Ubah nama'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Aulia');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(ProgressStore.nama.value, 'Aulia');
  });

  testWidgets('progress can be reset after confirmation', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    ProgressStore.simpan('Komputer tidak menyala', 80, benar: 2, total: 3);
    ProgressStore.materiSelesai.value = {'alur-daya-pc'};
    await tester.pumpWidget(const MaterialApp(home: PengaturanPage()));

    await tester.tap(find.text('Reset Progress'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();

    expect(ProgressStore.jumlahSelesai, 0);
    expect(ProgressStore.riwayat.value, isEmpty);
    expect(ProgressStore.materiSelesai.value, isEmpty);
  });
}
