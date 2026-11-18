import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/reminders/presentation/reminder_providers.dart';

/// Barra inferior con las cinco pestañas principales.
///
/// También reprograma los recordatorios al entrar y al volver a la app, para
/// mantener siempre una ventana de avisos futuros.
class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(reminderSyncProvider).sync();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) ref.read(reminderSyncProvider).sync();
  }

  @override
  Widget build(BuildContext context) {
    final shell = widget.shell;
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (i) => shell.goBranch(i, initialLocation: i == shell.currentIndex),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(
              icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights), label: 'Progreso'),
          NavigationDestination(
              icon: Icon(Icons.emoji_events_outlined), selectedIcon: Icon(Icons.emoji_events), label: 'Logros'),
          NavigationDestination(
              icon: Icon(Icons.water_drop_outlined), selectedIcon: Icon(Icons.water_drop), label: 'Mascota'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
