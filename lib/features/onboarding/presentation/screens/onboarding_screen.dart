import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/volume_format.dart';
import '../../../pet/domain/pet_evolution.dart';
import '../../../pet/presentation/widgets/aqua_pet_image.dart';
import '../../../profile/domain/entities/user_profile.dart';
import '../../../profile/presentation/providers/session_providers.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _page = PageController();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _profileFormKey = GlobalKey<FormState>();

  int _index = 0;
  bool _isGuest = true;
  int _goalMl = AppConstants.defaultDailyGoalMl;
  UnitSystem _unit = UnitSystem.metric;
  bool _saving = false;

  static const _pages = 3;

  @override
  void dispose() {
    _page.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  void _go(int i) {
    _page.animateToPage(i, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void _next() {
    if (_index == 1 && !_isGuest && !(_profileFormKey.currentState?.validate() ?? false)) return;
    if (_index < _pages - 1) {
      _go(_index + 1);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    setState(() => _saving = true);
    try {
      await ref.read(sessionProvider.notifier).completeOnboarding(OnboardingData(
            isGuest: _isGuest,
            dailyGoalMl: _goalMl,
            unitSystem: _unit,
            name: _nameCtrl.text,
            email: _emailCtrl.text,
            weightKg: double.tryParse(_weightCtrl.text.replaceAll(',', '.')),
          ));
      // El router redirige a /home al cambiar la sesión.
    } on ValidationFailure catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('No pudimos guardar tu configuración. Inténtalo de nuevo.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  if (_index > 0)
                    IconButton(
                      tooltip: 'Atrás',
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => _go(_index - 1),
                    )
                  else
                    const SizedBox(width: 48),
                  Expanded(child: _Dots(count: _pages, index: _index)),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _page,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _index = i),
                children: [
                  const _WelcomePage(),
                  _ProfilePage(
                    formKey: _profileFormKey,
                    isGuest: _isGuest,
                    onModeChanged: (g) => setState(() => _isGuest = g),
                    nameCtrl: _nameCtrl,
                    emailCtrl: _emailCtrl,
                    weightCtrl: _weightCtrl,
                  ),
                  _GoalPage(
                    goalMl: _goalMl,
                    unit: _unit,
                    onGoalChanged: (v) => setState(() => _goalMl = v),
                    onUnitChanged: (u) => setState(() => _unit = u),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saving ? null : _next,
                  child: _saving
                      ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5))
                      : Text(_index == _pages - 1 ? 'Comenzar' : 'Continuar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: i == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == index ? AppColors.primary : AppColors.primaryLight,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          const AquaPetImage(stage: PetStage.baby, size: 220),
          const SizedBox(height: 24),
          Text('¡Hola! Soy Aqua', style: t.displaySmall, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(
            'Te acompaño a crear el hábito de beber agua. Registra lo que bebes, '
            'cumple tu meta y mira cómo evoluciono contigo.',
            style: t.bodyLarge?.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({
    required this.formKey,
    required this.isGuest,
    required this.onModeChanged,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.weightCtrl,
  });

  final GlobalKey<FormState> formKey;
  final bool isGuest;
  final ValueChanged<bool> onModeChanged;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController weightCtrl;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('¿Cómo quieres empezar?', style: t.headlineSmall),
            const SizedBox(height: 8),
            const Text('Tus datos se guardan solo en este dispositivo. Puedes crear un perfil más tarde.'),
            const SizedBox(height: 20),
            _ModeCard(
              selected: isGuest,
              icon: Icons.person_outline,
              title: 'Continuar como invitado',
              subtitle: 'Empieza ya, sin datos personales.',
              onTap: () => onModeChanged(true),
            ),
            const SizedBox(height: 12),
            _ModeCard(
              selected: !isGuest,
              icon: Icons.badge_outlined,
              title: 'Crear perfil local',
              subtitle: 'Guarda tu nombre y preferencias en el dispositivo.',
              onTap: () => onModeChanged(false),
            ),
            if (!isGuest) ...[
              const SizedBox(height: 20),
              TextFormField(
                controller: nameCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Escribe tu nombre' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Correo (opcional)'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim()) ? null : 'Correo no válido';
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: weightCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Peso en kg (opcional)'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final w = double.tryParse(v.replaceAll(',', '.'));
                  return (w == null || w < 20 || w > 350) ? 'Peso no válido' : null;
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.selected,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? AppColors.primaryLight : AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: selected ? AppColors.primary : Colors.transparent, width: 2),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primaryDark, size: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 2),
                      Text(subtitle),
                    ],
                  ),
                ),
                Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: AppColors.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoalPage extends StatelessWidget {
  const _GoalPage({
    required this.goalMl,
    required this.unit,
    required this.onGoalChanged,
    required this.onUnitChanged,
  });

  final int goalMl;
  final UnitSystem unit;
  final ValueChanged<int> onGoalChanged;
  final ValueChanged<UnitSystem> onUnitChanged;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Tu meta diaria', style: t.headlineSmall),
          const SizedBox(height: 8),
          const Text('Elige una meta cómoda para ti. Podrás cambiarla cuando quieras.'),
          const SizedBox(height: 28),
          Center(child: Text(VolumeFormat.format(goalMl, unit), style: t.displaySmall)),
          Slider(
            value: goalMl.toDouble(),
            min: AppConstants.minDailyGoalMl.toDouble(),
            max: AppConstants.maxDailyGoalMl.toDouble(),
            divisions: (AppConstants.maxDailyGoalMl - AppConstants.minDailyGoalMl) ~/ AppConstants.dailyGoalStepMl,
            label: VolumeFormat.format(goalMl, unit),
            onChanged: (v) => onGoalChanged(v.round()),
          ),
          const SizedBox(height: 16),
          Text('Unidades', style: t.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<UnitSystem>(
            segments: const [
              ButtonSegment(value: UnitSystem.metric, label: Text('Mililitros (ml)')),
              ButtonSegment(value: UnitSystem.imperial, label: Text('Onzas (oz)')),
            ],
            selected: {unit},
            onSelectionChanged: (s) => onUnitChanged(s.first),
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16)),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: AppColors.primaryDark),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'AquaLife es una herramienta de seguimiento de hábitos y no sustituye el consejo médico. '
                    'Si tienes dudas sobre cuánta agua necesitas, consulta a un profesional de la salud.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
