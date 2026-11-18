import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/volume_format.dart';
import '../../domain/entities/water_intake.dart';
import 'intake_actions.dart';

class IntakeTile extends ConsumerWidget {
  const IntakeTile({super.key, required this.intake, required this.unit, this.editable = true});
  final WaterIntake intake;
  final UnitSystem unit;
  final bool editable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: const CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Icon(Icons.water_drop_rounded, color: AppColors.primary),
        ),
        title: Text(VolumeFormat.format(intake.amountMl, unit),
            style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        subtitle: Text(DateFormat.Hm('es').format(intake.consumedAt)),
        onTap: editable ? () => IntakeActions.edit(context, ref, intake) : null,
        trailing: editable
            ? IconButton(
                tooltip: 'Eliminar',
                icon: const Icon(Icons.delete_outline),
                onPressed: () => IntakeActions.delete(context, ref, intake),
              )
            : null,
      ),
    );
  }
}
