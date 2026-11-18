import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../widgets/intake_actions.dart';

/// /hydration/add — registro manual de una cantidad personalizada.
class AddIntakeScreen extends ConsumerWidget {
  const AddIntakeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar consumo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        child: IntakeFormSheet(
          title: '¿Cuánto bebiste?',
          onSubmit: (ml, time) async {
            await IntakeActions.add(context, ref, ml, consumedAt: time);
            if (context.mounted) context.pop();
          },
        ),
      ),
    );
  }
}
