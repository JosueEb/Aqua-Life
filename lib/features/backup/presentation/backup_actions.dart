import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/errors/failures.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/utils/local_date.dart';
import '../../hydration/presentation/providers/hydration_providers.dart';
import '../../profile/presentation/providers/session_providers.dart';
import '../../reminders/presentation/reminder_providers.dart';
import '../data/backup_service.dart';

final backupServiceProvider = Provider<BackupService>((ref) => BackupService(ref.watch(appDatabaseProvider)));

abstract final class BackupActions {
  static Future<void> export(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final now = ref.read(clockProvider)();
      final json = await ref.read(backupServiceProvider).exportJson(
            quickAmounts: ref.read(quickAmountsProvider),
            now: now,
          );
      final uri = await FilePicker.saveFile(
        dialogTitle: 'Guardar respaldo de AquaLife',
        fileName: 'aqualife-respaldo-${LocalDate.keyOf(now)}.json',
        bytes: Uint8List.fromList(utf8.encode(json)),
        mimeType: 'application/json',
      );
      if (uri != null) messenger.showSnackBar(const SnackBar(content: Text('Respaldo guardado')));
    } catch (_) {
      messenger.showSnackBar(const SnackBar(content: Text('No se pudo exportar el respaldo.')));
    }
  }

  static Future<void> import(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Importar respaldo'),
        content: const Text(
          'Los datos de este dispositivo se reemplazarán por los del respaldo: registros, metas, '
          'progreso de Aqua, logros e inventario. Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error, minimumSize: const Size(64, 44)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Elegir archivo'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);

    final files = await FilePicker.pickFiles(dialogTitle: 'Elige un respaldo de AquaLife');
    if (files.isEmpty) return;
    try {
      final raw = await files.first.xFile.readAsString();
      final result = await ref.read(backupServiceProvider).importJson(raw);
      if (result.quickAmounts != null && result.quickAmounts!.isNotEmpty) {
        await ref.read(quickAmountsProvider.notifier).set(result.quickAmounts!);
      }
      await ref.read(sessionProvider.notifier).adopt(result.userId);
      ref.read(reminderSyncProvider).sync();
      messenger.showSnackBar(SnackBar(content: Text('Respaldo importado: ${result.intakeCount} registros')));
    } on ValidationFailure catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (_) {
      messenger.showSnackBar(const SnackBar(content: Text('No se pudo leer el archivo.')));
    }
  }
}
