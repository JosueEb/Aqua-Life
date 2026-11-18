import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/volume_format.dart';
import '../../../hydration/presentation/providers/hydration_providers.dart';
import '../providers/session_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider).value;
    final goal = ref.watch(todaySummaryProvider).value?.goalMl;
    final unit = ref.watch(unitSystemProvider);

    Widget tile(IconData icon, String title, String route, {String? subtitle}) => ListTile(
          leading: Icon(icon, color: AppColors.primary),
          title: Text(title),
          subtitle: subtitle == null ? null : Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(route),
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primaryLight,
                child: Icon(Icons.person, color: AppColors.primary),
              ),
              title: Text(profile?.displayName ?? 'Invitado', style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text(profile == null || profile.isGuest
                  ? 'Modo invitado · datos solo en este dispositivo'
                  : (profile.email ?? 'Perfil local')),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              tile(Icons.flag_outlined, 'Meta diaria', '/goals',
                  subtitle: goal == null ? null : VolumeFormat.format(goal, unit)),
              tile(Icons.notifications_outlined, 'Recordatorios', '/reminders'),
              tile(Icons.flag_circle_outlined, 'Misiones', '/missions'),
              tile(Icons.storefront_outlined, 'Tienda', '/shop'),
              tile(Icons.inventory_2_outlined, 'Inventario', '/inventory'),
              tile(Icons.settings_outlined, 'Ajustes', '/settings'),
            ]),
          ),
        ],
      ),
    );
  }
}
