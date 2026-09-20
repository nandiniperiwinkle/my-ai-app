# Maternal Wellness — Mobile App

Flutter 3.x / Dart 3 client, built with **Clean Architecture** (presentation → domain → data)
and **Domain-Driven Design** feature modules. See `../ROADMAP.md` and `../docs/product-requirements.md`
for product context.

## 1. Project structure

```
mobile/
├── pubspec.yaml
├── analysis_options.yaml
├── lib/
│   ├── main.dart                    # composition root: DI init + MaterialApp.router
│   ├── core/                        # cross-cutting, feature-agnostic code
│   │   ├── constants/                app_constants.dart
│   │   ├── error/                    failures.dart (domain-facing), exceptions.dart (data-facing)
│   │   ├── network/                  DioClient, NetworkInfo, interceptors/
│   │   ├── theme/                    AppColors, AppTextStyles, AppTheme
│   │   ├── utils/                    Validators
│   │   ├── usecases/                 UseCase<Type, Params> base contract (fpdart Either)
│   │   ├── di/                       injection.dart (@InjectableInit), register_module.dart
│   │   ├── routes/                   app_routes.dart (path constants), app_router.dart (go_router)
│   │   └── presentation/             HomeDashboardPage, MainShell (bottom nav) — see §3
│   └── features/
│       ├── auth/                    Epic 1 — onboarding, progressive profiling, Profile tab
│       ├── womb_care/                Epic 2 — prenatal tracker, vitals, Garbh Sanskar mindfulness
│       ├── baby_care/                Epic 3 — postpartum trackers, milestones
│       ├── consultation/             Epic 4a — AMAs, 1-on-1 booking
│       └── community/                Epic 4b — forums, support groups
├── assets/
│   ├── images/
│   └── icons/
└── test/
```

Every feature module strictly separates:

- **`data/`** — `datasources/` (remote + local), `models/` (DTOs, `@JsonSerializable`), `repositories/` (implementations)
- **`domain/`** — `entities/` (pure business objects), `repositories/` (abstract interfaces), `usecases/` (one class per action, implements `UseCase<Type, Params>`)
- **`presentation/`** — `bloc/` (or cubit), `pages/`, `widgets/`

The dependency rule is enforced by import direction only, not tooling: `presentation` may import `domain`,
`data` may import `domain`, but `domain` never imports `presentation` or `data`. Code review should catch
violations until a lint rule (e.g. `import_lint`) is added.

Folders with no code yet contain a `.gitkeep` placeholder — delete it the moment you add the first real file.

## 2. Why `Home` and `Profile` aren't their own feature modules

The task brief calls for a 5-tab bottom nav (Home, Womb Care, Baby Care, Community, Profile) but only 5
*business* feature modules (auth, womb_care, baby_care, consultation, community — matching the PRD's epics).
Two tabs are intentionally not separate bounded contexts:

- **Home** is a composition root (`core/presentation/pages/home_dashboard_page.dart`) that will surface
  cards pulled from other features (today's tip, next consultation, latest milestone). It has no domain/data
  layer of its own — it composes usecases that already belong to other features.
- **Profile** lives inside `features/auth/presentation/pages/profile_page.dart`, since progressive profiling
  is explicitly Epic 1.
- **Consultation** (Epic 4a) is scaffolded as a full feature module but is *not* a nav tab — it's reached via
  `context.push(AppRoutes.consultation)` from Home or Womb Care, matching how the PRD frames expert access
  as an in-context action rather than a primary destination.

## 3. One-time setup: generate platform folders

This scaffold was written by hand (no `flutter` SDK was available in the scaffolding environment), so
`android/`, `ios/`, `macos/`, `linux/`, `windows/`, and `web/` **do not exist yet**. Before anything else,
from a machine with Flutter installed:

```bash
cd mobile
flutter create . --org com.yourcompany.maternalwellness --project-name maternal_wellness_app
```

This backfills the native platform folders in place without touching `lib/`, `pubspec.yaml`, or anything
else already scaffolded here (confirm with `git status` afterwards — it should only show new platform
folders being added, nothing under `lib/` modified). Commit the generated folders; `.gitignore` already
excludes their build output.

## 4. Running code generation

This scaffold depends on generated code for DI, JSON models, and immutable unions. **The app will not
compile until you run `build_runner` once**, because `core/di/injection.dart` imports the not-yet-generated
`injection.config.dart`.

```bash
cd mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Re-run that `build_runner` command any time you:
- add a class annotated `@injectable`, `@lazySingleton`, or `@LazySingleton(as: ...)`
- add a `@freezed` class or a class with `@JsonSerializable()`
- add a Retrofit `@RestApi()` client

During active development, use the watcher instead of re-running manually each time:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## 5. Running the app

```bash
cd mobile
flutter create . --org com.yourcompany.maternalwellness --project-name maternal_wellness_app  # §3, one-time
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

There's no backend yet (see ROADMAP.md Phase 0), so `AppConstants.baseUrl` is a placeholder and the splash
screen skips straight to Home rather than checking a real session.

## 6. Recommended next sprint

Per `../ROADMAP.md` Phase 1 (Epic 1: Onboarding & Profiling), the next feature to actually implement — not
just scaffold — is **`features/auth`**:

1. **Domain first:** `User` entity, `AuthRepository` interface, usecases (`SignInWithPhone`,
   `VerifyOtp`, `SignInWithGoogle`, `SignInWithApple`, `SaveProfile`, `GetCurrentUser`).
2. **Data:** `AuthRemoteDataSource` (Retrofit client against Firebase Auth REST or Cloud Functions),
   `AuthLocalDataSource` (token persistence via `flutter_secure_storage`), `AuthRepositoryImpl` mapping
   `ServerException`/`NetworkException` → `Failure`.
3. **Presentation:** `AuthBloc` (or `AuthCubit`) driving `LoginPage`, an OTP-entry page, and the progressive
   profiling flow (due date, pregnancy stage, health goals) that ends at `ProfilePage`.
4. Wire `SplashPage`'s `initState` to a real `GetCurrentUser` call and redirect to `AppRoutes.login` when
   there's no session, replacing the current fixed-delay placeholder.
5. Add the first widget/bloc tests under `test/features/auth/` once the Bloc exists.

`womb_care` (Epic 2) is the natural follow-on sprint after auth, since every other feature depends on
knowing the user's pregnancy stage.
