# Fase 9 · QA y publicación

## 1. Verificación automática (antes de cada build)

```bash
flutter analyze
flutter test
```

Cubre: reglas (XP, niveles, rachas, evolución, fechas), integración con Drift en memoria
(transacciones, anti-duplicación, respaldo JSON, programación de recordatorios) y widgets
(onboarding → registro, y recorrido de las 13 pantallas en un teléfono de 375 pt, vacío y con datos).

## 2. Builds de publicación

Versión: `version:` en `pubspec.yaml` (`1.0.0+1` → versionName/CFBundleShortVersionString + build number).
Sube el número tras `+` en cada envío a las tiendas.

### Android (Google Play)

1. Crear la llave de subida (una sola vez; guárdala fuera del repo y respáldala):
   ```bash
   keytool -genkey -v -keystore ~/aqualife-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. Crear `android/key.properties` (ignorado por git):
   ```properties
   storePassword=…
   keyPassword=…
   keyAlias=upload
   storeFile=/Users/<tú>/aqualife-upload.jks
   ```
   Sin este archivo el release se firma con la llave debug (sirve para probar, no para Play).
3. `flutter build appbundle --release --obfuscate --split-debug-info=build/symbols`
   → `build/app/outputs/bundle/release/app-release.aab`. Guarda `build/symbols` para leer trazas de errores.

### iOS (App Store)

1. En Xcode (`ios/Runner.xcworkspace`) → Runner → Signing & Capabilities: elegir el equipo
   (Team) y dejar el bundle id `dev.josueeb.aqualife`.
2. `flutter build ipa --release --obfuscate --split-debug-info=build/symbols`
3. Subir `build/ios/ipa/*.ipa` con Transporter o `xcrun altool`.

## 3. Pruebas en dispositivos reales (manual)

Hacer en al menos un Android (13+) y un iPhone. Marcar cada punto:

**Instalación y datos**
- [ ] Instalación limpia: aparece el onboarding; tras completarlo no vuelve a aparecer.
- [ ] Registrar, editar y borrar consumos; cerrar la app (deslizar) y reabrir: los datos siguen.
- [ ] Exportar respaldo JSON, borrar la app, reinstalar, importar: progreso, monedas y Aqua iguales.

**Recordatorios**
- [ ] Permiso concedido: llega el aviso de prueba y los programados con la app cerrada.
- [ ] Permiso denegado: la pantalla de recordatorios lo explica y no se rompe nada.
- [ ] «Posponer» desde la notificación con la app cerrada: vuelve a avisar tras N minutos.
- [ ] Reiniciar el teléfono: los avisos siguen llegando (Android: tras desbloquear).
- [ ] Al cumplir la meta no llegan más avisos ese día.

**Tiempo**
- [ ] Dejar la app abierta al pasar la medianoche: Inicio cambia al nuevo día.
- [ ] Cambiar la zona horaria del sistema: los consumos pasados no cambian de día y la racha se mantiene.

**Interfaz y accesibilidad**
- [ ] Texto del sistema al tamaño máximo: nada se corta ni se superpone en Inicio y Registro.
- [ ] «Reducir movimiento/animaciones» activado: Aqua queda quieta.
- [ ] Lector de pantalla (TalkBack/VoiceOver): los botones de registro rápido se anuncian con su cantidad.

**Rendimiento**
- [ ] `flutter run --profile`: desplazamiento fluido en Progreso e Historial (sin saltos visibles).

## 4. Fichas de tienda

**Nombre:** AquaLife
**Subtítulo / descripción corta:** Bebe agua con Aqua, tu gotita compañera.
**Categoría:** Salud y bienestar.
**Clasificación de edad:** Para todos (sin contenido sensible, sin compras, sin anuncios).

**Descripción:**
AquaLife te ayuda a crear el hábito de beber agua. Registra cada vaso en un toque, fija tu meta
diaria y recibe recordatorios a tu ritmo. Con cada día cumplido, Aqua —una gotita kawaii— gana
experiencia y evoluciona en cinco etapas. Completa misiones, desbloquea logros, abre cofres y
viste a Aqua con accesorios de la tienda (sin dinero real). Todo funciona sin internet y tus
datos se quedan en tu teléfono; puedes exportarlos como respaldo cuando quieras.
AquaLife es una herramienta de hábitos y no sustituye el consejo médico.

**Capturas:** Android (1080×1920, listas para Play) en [screenshots/android/](screenshots/android/):
bienvenida, Inicio, Misiones, Progreso, Logros, Tienda y Aqua con accesorio. Se generaron en el
emulador con 7 días de uso real (fecha del sistema adelantada día a día). Faltan las de iPhone 6,9".

### Privacidad

- Google Play › Seguridad de los datos: *no se recopilan ni se comparten datos*.
- App Store › Privacidad de la app: *Datos no recopilados*.
- Ambas tiendas piden una URL de política de privacidad; texto sugerido:

> AquaLife no recopila, transmite ni comparte datos personales. Todo lo que registras
> (perfil, consumos, metas y progreso) se guarda solo en tu dispositivo. La app no usa
> internet, anuncios ni analítica. Si exportas un respaldo, el archivo queda bajo tu control.
> Al desinstalar la app se eliminan sus datos.
