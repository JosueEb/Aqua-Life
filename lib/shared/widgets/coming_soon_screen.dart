import 'package:material_ui/material_ui.dart';

import '../../app/theme/app_colors.dart';

/// Pantalla provisional para secciones de fases posteriores del roadmap.
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key, required this.title, required this.description, this.icon = Icons.water_drop});

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return Scaffold(
      appBar: AppBar(title: Text(title), automaticallyImplyLeading: canPop),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryLight,
                child: Icon(icon, size: 40, color: AppColors.primary),
              ),
              const SizedBox(height: 20),
              Text('Próximamente', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
