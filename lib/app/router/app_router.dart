import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/achievements/presentation/achievements_screen.dart';
import '../../features/goals/presentation/goals_screen.dart';
import '../../features/hydration/presentation/screens/add_intake_screen.dart';
import '../../features/hydration/presentation/screens/history_screen.dart';
import '../../features/hydration/presentation/screens/home_screen.dart';
import '../../features/missions/presentation/missions_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/pet/presentation/screens/pet_screen.dart';
import '../../features/profile/presentation/providers/session_providers.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/reminders/presentation/reminders_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/shop/presentation/shop_screens.dart';
import '../../features/statistics/presentation/screens/statistics_screen.dart';
import 'main_shell.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const progress = '/progress';
  static const achievements = '/achievements';
  static const pet = '/pet';
  static const profile = '/profile';
  static const history = '/hydration/history';
  static const addIntake = '/hydration/add';
  static const goals = '/goals';
  static const reminders = '/reminders';
  static const missions = '/missions';
  static const shop = '/shop';
  static const inventory = '/inventory';
  static const settings = '/settings';
  static const notificationSettings = '/settings/notifications';
}

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  // Notificador para que GoRouter reevalúe `redirect` al cambiar la sesión.
  final onboardingDone = ValueNotifier<bool>(ref.read(sessionProvider).onboardingCompleted);
  ref.listen(sessionProvider, (_, s) => onboardingDone.value = s.onboardingCompleted);
  ref.onDispose(onboardingDone.dispose);

  final router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoutes.home,
    refreshListenable: onboardingDone,
    redirect: (context, state) {
      final done = onboardingDone.value;
      final atOnboarding = state.matchedLocation == AppRoutes.onboarding;
      if (!done && !atOnboarding) return AppRoutes.onboarding;
      if (done && atOnboarding) return AppRoutes.home;
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.onboarding, builder: (_, _) => const OnboardingScreen()),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => MainShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: AppRoutes.home, builder: (_, _) => const HomeScreen())]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.progress, builder: (_, _) => const StatisticsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.achievements, builder: (_, _) => const AchievementsScreen()),
          ]),
          StatefulShellBranch(routes: [GoRoute(path: AppRoutes.pet, builder: (_, _) => const PetScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: AppRoutes.profile, builder: (_, _) => const ProfileScreen())]),
        ],
      ),
      GoRoute(path: AppRoutes.addIntake, parentNavigatorKey: _rootKey, builder: (_, _) => const AddIntakeScreen()),
      GoRoute(path: AppRoutes.goals, parentNavigatorKey: _rootKey, builder: (_, _) => const GoalsScreen()),
      GoRoute(path: AppRoutes.history, parentNavigatorKey: _rootKey, builder: (_, _) => const HistoryScreen()),
      GoRoute(path: AppRoutes.reminders, parentNavigatorKey: _rootKey, builder: (_, _) => const RemindersScreen()),
      GoRoute(path: AppRoutes.missions, parentNavigatorKey: _rootKey, builder: (_, _) => const MissionsScreen()),
      GoRoute(path: AppRoutes.shop, parentNavigatorKey: _rootKey, builder: (_, _) => const ShopScreen()),
      GoRoute(path: AppRoutes.inventory, parentNavigatorKey: _rootKey, builder: (_, _) => const InventoryScreen()),
      GoRoute(path: AppRoutes.settings, parentNavigatorKey: _rootKey, builder: (_, _) => const SettingsScreen()),
      GoRoute(
        path: AppRoutes.notificationSettings,
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const RemindersScreen(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
