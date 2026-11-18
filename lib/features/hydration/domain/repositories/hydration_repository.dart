import '../entities/water_intake.dart';

abstract interface class HydrationRepository {
  Stream<DailySummary> watchDay(String userId, String localDate);

  /// Registra un consumo y otorga sus recompensas en una sola transacción.
  Future<IntakeResult> addIntake(String userId, int amountMl, DateTime consumedAt);

  /// Edita un consumo. No otorga XP por registro de nuevo; solo puede
  /// otorgar la meta diaria si aún no se había otorgado ese día.
  Future<IntakeResult> updateIntake(String userId, String intakeId, int amountMl, DateTime consumedAt);

  /// Elimina un consumo. La XP ya ganada no se retira (la evolución no
  /// retrocede) y el límite diario evita repetirla al volver a registrar.
  Future<void> deleteIntake(String userId, String intakeId);
}
