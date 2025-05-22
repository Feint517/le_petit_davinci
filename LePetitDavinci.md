
# LePetitDavinci – Project Structure & Best Practices

## 📁 Folder Structure and File Management

```
lib/
├── main.dart
├── app.dart                         # Root widget (GetMaterialApp)
├── routes/
│   ├── app_pages.dart               # Route definitions (GetPage list)
│   └── app_routes.dart              # Route name constants
│
├── core/
│   ├── bindings/                    # Global bindings (e.g. AuthBinding)
│   ├── network/
│   │   ├── dio_client.dart
│   │   ├── api_result.dart          # API response wrapper
│   │   └── exceptions.dart          # Custom exceptions
│   ├── constants/                   # App-wide constants (e.g. baseUrl)
│   ├── themes/                      # Colors, typography, themes
│   ├── utils/                       # Helpers, validators
│   └── widgets/                     # Global shared widgets
│
├── data/                            # Shared models/repositories
│   ├── models/
│   └── repositories/

├── features/                        # Feature-first structure
│   ├── auth/
│   │   ├── controllers/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── datasources/
│   │   │   └── repositories/
│   │   ├── bindings/
│   │   ├── views/
│   │   ├── widgets/
│   │   └── auth_feature.dart        # Barrel file (optional)
│   └── profile/
│       └── ...                      # Same structure as auth/
│
└── l10n/                            # Localization files

test/
├── features/
│   └── profile/
│       ├── profile_controller_test.dart
│       └── profile_view_test.dart

integration_test/
```

---

## 📦 Barrel Files

Barrel files aggregate exports in a single access point:

```dart
export 'controllers/profile_controller.dart';
export 'views/profile_page.dart';
export 'widgets/profile_header.dart';
```

Usage:
```dart
import 'features/profile/profile_feature.dart';
```

Do NOT import a barrel file inside its own feature components (risk of circular dependency).

---

## 🌐 HTTP Requests

Using `Dio` + `json_serializable` for safe typed API communication.

Example structure:
```
lib/
├── core/network/dio_client.dart
├── features/user/
│   ├── data/models/user_model.dart
│   ├── data/models/user_model.g.dart  # auto-generated
│   ├── data/datasources/user_api.dart
│   └── controllers/user_controller.dart
```

---

## 🎞️ Animations

Supported libraries:
- **Rive**
- **Lottie**
- **Flutter Animate**
- **Animated Text Kit**

**About Rive**:
Real-time animation tool combining vector editing with runtime control. Ideal for interactive UI/UX.

---

## 🐞 Debugging

- `pretty_dio_logger`: Logs HTTP requests.
- `sentry`: Advanced error tracking and monitoring.

---

## 📱 Responsiveness

Recommended packages:
- `flutter_screenutil` ✅
- `responsive_framework`

---

## ✅ Development Notes & Best Practices

- Barrel files are **optional**.
- Avoid circular imports: don't import a barrel file in its subfiles.
- Keep **logic separate from UI**.
- Avoid widget-returning functions; use **custom StatelessWidget**.
- Place reusable widgets in `widgets/` folder of the screen.
- Use `Gap` instead of `SizedBox` for spacing.
- Use `withAlpha()` instead of deprecated `withOpacity()`.
- Always use:
  - `color_manager` for colors
  - `assets_manager` for asset paths
  - `strings_manager` for text strings
  - `sizes.dart` for dimensions
- Stick to the **same font family**.
- Use `screenutil` to ensure responsiveness before moving to next UI.
- Shared widgets → place in `core/widgets/`.
- Animation logic → always in separate **controller**.
- Controllers → always initialized in their **bindings file**.
- Work on a **separate branch**.
- Merge to main every **2 days**, after team notification.

---
