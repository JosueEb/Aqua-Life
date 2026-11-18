import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static TextTheme textTheme(TextTheme base) => base
      .apply(bodyColor: AppColors.textPrimary, displayColor: AppColors.textPrimary)
      .copyWith(
        displaySmall: base.displaySmall?.copyWith(fontWeight: FontWeight.w800, color: AppColors.primaryDark),
        headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        bodyMedium: base.bodyMedium?.copyWith(color: AppColors.textSecondary),
        labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      );
}
