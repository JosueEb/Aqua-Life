import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/errors/failures.dart';
import '../../../core/providers/core_providers.dart';
import '../../hydration/presentation/providers/hydration_providers.dart';
import '../../gamification/domain/gamification_status.dart';
import '../../pet/domain/pet_accessories.dart';
import '../../pet/domain/pet_evolution.dart';
import '../../pet/presentation/pet_mood_providers.dart';
import '../../pet/presentation/widgets/animated_aqua.dart';
import '../../profile/presentation/providers/session_providers.dart';
import '../data/shop_repository.dart';

final shopRepositoryProvider = Provider<ShopRepository>((ref) => ShopRepositoryImpl(ref.watch(appDatabaseProvider)));

final shopStateProvider = StreamProvider<ShopState>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const Stream.empty();
  return ref.watch(shopRepositoryProvider).watch(userId);
});

Future<void> _guard(BuildContext context, Future<void> Function() action, {String? success}) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    await action();
    if (success != null) messenger.showSnackBar(SnackBar(content: Text(success)));
  } on ValidationFailure catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.message)));
  } on NotFoundFailure catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.message)));
  }
}

class _CoinsBadge extends StatelessWidget {
  const _CoinsBadge(this.coins);
  final int coins;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.monetization_on_rounded, color: AppColors.reward),
          const SizedBox(width: 4),
          Text('$coins', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
        ]),
      );
}

/// /shop — tienda cosmética.
class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shop = ref.watch(shopStateProvider);
    final stage = (ref.watch(gamificationStatusProvider).value ?? GamificationStatus.empty).petStage;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda'),
        actions: [if (shop.value != null) _CoinsBadge(shop.value!.coins)],
      ),
      body: shop.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('No pudimos cargar la tienda.')),
        data: (s) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          children: [
            const Text('Gana monedas cumpliendo tu meta, completando misiones y abriendo cofres. '
                'Todo es cosmético: no hay compras con dinero real.'),
            const SizedBox(height: 12),
            for (final category in AccessoryCategory.values) ...[
              if (s.items.any((i) => i.category == category)) ...[
                Text(category.displayName, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.72,
                  children: [
                    for (final item in s.items.where((i) => i.category == category))
                      _ShopItemCard(item: item, state: s, stage: stage),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _ShopItemCard extends ConsumerWidget {
  const _ShopItemCard({required this.item, required this.state, required this.stage});
  final ShopItemView item;
  final ShopState state;
  final PetStage stage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locked = state.level < item.unlockLevel;
    final affordable = state.coins >= item.price;
    final preview = EquippedAccessories({item.category: item.id});

    Future<void> buy() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Comprar ${item.name}'),
          content: Text('Cuesta ${item.price} monedas. Te quedarán ${state.coins - item.price}.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(64, 44)),
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Comprar'),
            ),
          ],
        ),
      );
      if (ok != true || !context.mounted) return;
      final userId = ref.read(currentUserIdProvider)!;
      await _guard(context, () async {
        await ref.read(shopRepositoryProvider).purchase(userId, item.id, ref.read(clockProvider)());
        await ref.read(shopRepositoryProvider).setEquipped(userId, item.id, equip: true);
        ref.read(petMomentProvider.notifier).trigger(PetMood.happy);
      }, success: '¡${item.name} es tuyo! Aqua ya lo lleva puesto.');
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Opacity(
                opacity: locked ? 0.4 : 1,
                child: AnimatedAqua(stage: stage, equipped: preview, size: 120, animate: false),
              ),
            ),
            Text(item.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: item.owned
                  ? const OutlinedButton(onPressed: null, child: Text('Comprado'))
                  : locked
                      ? OutlinedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.lock_outline, size: 18),
                          label: Text('Nivel ${item.unlockLevel}'),
                        )
                      : FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.reward,
                            foregroundColor: AppColors.textPrimary,
                            minimumSize: const Size(64, 44),
                          ),
                          onPressed: affordable ? buy : null,
                          icon: const Icon(Icons.monetization_on_rounded, size: 18),
                          label: Text('${item.price}'),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

/// /inventory — artículos comprados; equipar y quitar.
class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shop = ref.watch(shopStateProvider);
    final status = ref.watch(gamificationStatusProvider).value ?? GamificationStatus.empty;

    return Scaffold(
      appBar: AppBar(title: const Text('Inventario')),
      body: shop.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('No pudimos cargar tu inventario.')),
        data: (s) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: AnimatedAqua(
                    stage: status.petStage,
                    equipped: s.equipped,
                    mood: ref.watch(petMoodProvider),
                    size: 180,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (s.owned.isEmpty)
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Aún no tienes accesorios.', textAlign: TextAlign.center),
                  ),
                  FilledButton.icon(
                    onPressed: () => context.push('/shop'),
                    icon: const Icon(Icons.storefront),
                    label: const Text('Ir a la tienda'),
                  ),
                ],
              )
            else
              for (final item in s.owned)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    child: SwitchListTile(
                      secondary: SizedBox(
                        width: 48,
                        height: 48,
                        child: AnimatedAqua(
                          stage: status.petStage,
                          equipped: EquippedAccessories({item.category: item.id}),
                          size: 48,
                          animate: false,
                        ),
                      ),
                      title: Text(item.name),
                      subtitle: Text(item.category.displayName),
                      value: item.equipped,
                      onChanged: (v) => _guard(
                        context,
                        () => ref
                            .read(shopRepositoryProvider)
                            .setEquipped(ref.read(currentUserIdProvider)!, item.id, equip: v),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
