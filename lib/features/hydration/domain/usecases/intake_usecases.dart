import '../../../../core/constants/gamification_rules.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/local_date.dart';
import '../entities/water_intake.dart';
import '../repositories/hydration_repository.dart';

void _validate(int amountMl, DateTime consumedAt, DateTime now) {
  if (!GamificationRules.isValidIntakeAmount(amountMl)) {
    throw ValidationFailure(
        'La cantidad debe estar entre ${GamificationRules.minIntakeMl} y ${GamificationRules.maxIntakeMl} ml.');
  }
  if (consumedAt.isAfter(now.add(const Duration(minutes: 5)))) {
    throw const ValidationFailure('No puedes registrar consumos en el futuro.');
  }
  if (!IntakeWindow.isEditable(LocalDate.keyOf(consumedAt), LocalDate.keyOf(now))) {
    throw const ValidationFailure(
        'Solo puedes registrar o editar consumos de los últimos ${IntakeWindow.editableDays} días.');
  }
}

/// Ventana de días en la que se permite registrar o editar consumos.
abstract final class IntakeWindow {
  static const int editableDays = 7;

  static bool isEditable(String date, String today) =>
      date.compareTo(today) <= 0 && date.compareTo(LocalDate.addDays(today, -(editableDays - 1))) >= 0;
}

class AddWaterIntake {
  const AddWaterIntake(this._repo, this._clock);
  final HydrationRepository _repo;
  final DateTime Function() _clock;

  Future<IntakeResult> call(String userId, int amountMl, {DateTime? consumedAt}) {
    final now = _clock();
    final at = consumedAt ?? now;
    _validate(amountMl, at, now);
    return _repo.addIntake(userId, amountMl, at);
  }
}

class UpdateWaterIntake {
  const UpdateWaterIntake(this._repo, this._clock);
  final HydrationRepository _repo;
  final DateTime Function() _clock;

  Future<IntakeResult> call(String userId, String intakeId, int amountMl, DateTime consumedAt) {
    _validate(amountMl, consumedAt, _clock());
    return _repo.updateIntake(userId, intakeId, amountMl, consumedAt);
  }
}

class DeleteWaterIntake {
  const DeleteWaterIntake(this._repo);
  final HydrationRepository _repo;

  Future<void> call(String userId, String intakeId) => _repo.deleteIntake(userId, intakeId);
}
