# AquaLife

Aplicación móvil de hidratación gamificada (Android e iOS), local-first y sin backend.
Especificación completa: [AquaLife_Requerimientos_y_Especificacion.pdf](AquaLife_Requerimientos_y_Especificacion.pdf).

- Identificador: `dev.josueeb.aqualife`
- Stack: Flutter · Riverpod · GoRouter · Drift (SQLite) · flutter_local_notifications · fl_chart · Lottie

## Puesta en marcha

```bash
flutter pub get
dart run build_runner build      # genera el código de Drift (*.g.dart)
flutter test
flutter run
```

## Estructura

```
lib/
  app/        aplicación raíz, router (GoRouter) y tema
  core/       base de datos (Drift), constantes, utilidades, providers base
  features/   una carpeta por funcionalidad con data / domain / presentation
  shared/     widgets reutilizables
assets/images/mascot/stage_1..5/   ilustraciones de Aqua
tool/mascot/                       generador de los SVG de Aqua y vista previa
test/{unit,integration,widget}/
```

## Reglas de gamificación (fijadas)

Centralizadas en `lib/core/constants/gamification_rules.dart`.

| Regla | Valor |
|---|---|
| Registro válido | 5 XP, máximo 10 registros premiados por día |
| Meta diaria | 50 XP, una vez por día |
| Misión diaria / semanal | 15 XP / 100 XP |
| Racha de 7 días | 100 XP |
| Monedas | 1 por cada 10 XP del evento |
| Nivel | 1 + XP total / 100 |
| Cantidad válida por registro | 1–2000 ml |
| Etapas de Aqua | 0 / 100 / 300 / 600 / 1000 XP |

Las recompensas se registran en el ledger `reward_transactions` con clave única
`(usuario, tipo, fuente, referencia)`, dentro de la misma transacción que el consumo.

## Reglas adicionales

- Solo se pueden registrar o editar consumos de los últimos 7 días.
- XP y monedas solo se otorgan por cambios en el día de hoy; los días pasados cuentan para historial, rachas y logros.
- La racha se cuenta hasta ayer mientras la meta de hoy no se cumple (no punitiva); la mejor racha nunca baja.
- Recordatorios: se programan hasta 48 avisos concretos (límite de iOS: 64) y se reprograman al abrir la app,
  al registrar agua y al cambiar la configuración.

## Política temporal

`consumed_at` se guarda en UTC y cada consumo guarda su fecha local de agrupación
(`local_date`) calculada al registrarlo. Cambiar de zona horaria no mueve consumos pasados.

## Roadmap

- [x] 1. Foundation (estructura, tema, Riverpod, GoRouter, Drift, onboarding, navegación, Inicio)
- [x] 2. Base de datos (esquema v1, DAOs, pruebas con Drift en memoria)
- [x] 3. Hidratación (historial con calendario, edición de los últimos 7 días, accesos rápidos configurables, ajustes)
- [x] 4. Recordatorios (horario, intervalo, días, posponer, se pausan al cumplir la meta)
- [x] 5. Estadísticas (semana/mes, gráfico, calendario de actividad, rachas)
- [x] 6. Gamificación (rachas, hito de 7 días, logros con monedas)
- [ ] 7. Mascota (animaciones Lottie, accesorios)
- [ ] 8. Misiones y tienda
- [ ] 9. QA y publicación
