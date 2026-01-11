# Sample App Features Documentation

## 1. Overview

### About This App
Flutter Autonomous Template - Claude Codeによる自律的なFlutterアプリ開発用のサンプルアプリ。

### Tech Stack
| Category | Technology |
|----------|------------|
| Framework | Flutter 3.x |
| State Management | Riverpod (AsyncNotifier) |
| Navigation | AutoRoute |
| Data Serialization | Freezed + json_serializable |
| Local Storage | SharedPreferences |
| Logging | Talker |
| Internationalization | Flutter intl |

### Architecture Pattern
- **Feature-first structure**: `lib/features/{feature_name}/`
- **Repository pattern**: Data layer abstraction
- **Provider pattern**: Business logic via Riverpod

---

## 2. Feature Modules

### 2.1 Authentication (auth)

#### Data Layer

**User Model** (`lib/features/auth/data/models/user.dart`)
```dart
class User {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
}
```

**AuthRepository** (`lib/features/auth/data/repositories/`)
- `AuthRepository` - Interface
- `MockAuthRepository` - Mock implementation (全メール/パスワードで成功)

#### Business Logic (`lib/features/auth/providers/auth_provider.dart`)

| Provider | Type | Description |
|----------|------|-------------|
| `authRepositoryProvider` | Provider | MockAuthRepository提供 |
| `authStateProvider` | StreamProvider | ログイン状態監視 |
| `currentUserProvider` | Provider | 現在のユーザー取得 |
| `isAuthenticatedProvider` | Provider | 認証状態bool |
| `authNotifierProvider` | AsyncNotifierProvider | signIn/signOutアクション |

#### UI Components

**LoginScreen** (`lib/features/auth/ui/screens/login_screen.dart`)

| Element | Widget | Behavior |
|---------|--------|----------|
| Email Input | `AppTextField` | Required, @含むバリデーション |
| Password Input | `AppTextField` | obscureText, 表示トグル |
| Sign In Button | `AppButton` | Loading状態、disabled状態 |
| Demo Mode Card | `Container` | kDebugMode時のみ表示 |
| Quick Login | `TextButton` | demo@example.comで即ログイン |
| Error Display | `SnackBar` | バリデーション/認証エラー表示 |

**User Interactions:**
1. メール入力 → バリデーション
2. パスワード入力 → 表示/非表示トグル
3. Sign Inタップ → ローディング → 成功/エラー
4. Quick Loginタップ → 即座にホームへ遷移

---

### 2.2 TODO Management (todo)

#### Data Layer

**Todo Model** (`lib/features/todo/data/models/todo.dart`)
```dart
class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? dueDate;
  final Category? category;
}
```

**Category Model** (`lib/features/todo/data/models/category.dart`)
```dart
class Category {
  final String id;
  final String name;
  final int colorIndex;
}

// Default categories: Personal, Work, Shopping, Health
```

**TodoRepository** (`lib/features/todo/data/repositories/`)
- `TodoRepository` - Interface + SharedPreferences実装
- `DebugTodoRepository` - スクリーンショット用ダミーデータ

#### Business Logic

**todo_provider.dart**
| Provider | Type | Description |
|----------|------|-------------|
| `todoRepositoryProvider` | Provider | Repository提供 (Debug切替対応) |
| `todoListProvider` | AsyncNotifierProvider | CRUD操作 |
| `todoStatsProvider` | Provider | {total, completed, active} |

**filter_provider.dart** (`lib/features/todo/providers/filter_provider.dart`)
| Provider | Type | Description |
|----------|------|-------------|
| `filterProvider` | NotifierProvider | TodoFilter (all/active/completed) |
| `filteredTodosProvider` | Provider | フィルタリング済みリスト |

#### UI Components

**TodoListScreen** (`lib/features/todo/ui/screens/todo_list_screen.dart`)

| Element | Widget | Behavior |
|---------|--------|----------|
| Header | AppBar | "TODOs" タイトル、Clear completedアクション |
| Filter Chips | `FilterChip` x3 | All(n) / Active(n) / Completed(n) |
| TODO List | `ListView.separated` | TodoTileのリスト |
| Empty State | `AppEmptyState` | フィルター別メッセージ |
| Loading | `AppLoadingOverlay` | 初回読み込み時 |
| FAB | `FloatingActionButton` | 新規TODO追加 |
| Delete Feedback | `SnackBar` | スワイプ削除後の通知 |

**TodoTile** (`lib/features/todo/ui/widgets/todo_tile.dart`)

| Element | Widget | Behavior |
|---------|--------|----------|
| Checkbox | `Checkbox` | 完了トグル、アニメーション |
| Title | `Text` | 完了時strikethrough |
| Description | `Text` | 最大2行、overflow ellipsis |
| Due Date | `Text` | Today/Tomorrow/日付表示、期限切れは赤 |
| Category | `Container` | 左端にカラーインジケータ |
| Swipe | `Dismissible` | 左スワイプで削除 |
| Tap | `InkWell` | 編集画面へ遷移 |

**TodoEditScreen** (`lib/features/todo/ui/screens/todo_edit_screen.dart`)

| Element | Widget | Behavior |
|---------|--------|----------|
| Title Input | `AppTextField` | Required バリデーション |
| Description Input | `AppTextField` | multiline |
| Due Date | `ListTile` + `DatePicker` | タップで日付選択 |
| Save Button | `AppButton` | 保存アクション |
| Delete Button | `IconButton` | 編集モードのみ表示 |
| Delete Dialog | `AlertDialog` | 削除確認 |

**User Interactions:**
1. フィルターチップタップ → リスト更新
2. FABタップ → 新規作成画面
3. TodoTileタップ → 編集画面
4. Checkboxタップ → 完了トグル
5. 左スワイプ → 削除 + SnackBar
6. Clear completedタップ → 完了済み一括削除

---

### 2.3 Settings (settings)

#### Data Layer

**AppSettings Model** (`lib/features/settings/data/models/app_settings.dart`)
```dart
class AppSettings {
  final ThemeModeValue themeMode; // system, light, dark
  final String locale; // 'en', 'ja'
}
```

**SettingsRepository** (`lib/features/settings/data/repositories/settings_repository.dart`)
- SharedPreferencesでJSON保存/読み込み

#### Business Logic (`lib/features/settings/providers/settings_provider.dart`)

| Provider | Type | Description |
|----------|------|-------------|
| `settingsRepositoryProvider` | Provider | Repository提供 |
| `settingsProvider` | NotifierProvider | 設定CRUD |
| `themeModeProvider` | Provider | 現在のテーマモード |
| `localeProvider` | Provider | 現在のロケール |

#### UI Components

**SettingsScreen** (`lib/features/settings/ui/screens/settings_screen.dart`)

| Section | Elements | Behavior |
|---------|----------|----------|
| Theme | 3x `ListTile` | System/Light/Dark選択 |
| Language | 2x `ListTile` | English/Japanese選択 |
| About | `ListTile` | AboutDialogを表示 |
| Account | `ListTile` + `CircleAvatar` | ユーザー情報表示 |
| Sign Out | `ListTile` | 確認ダイアログ後ログアウト |
| Debug (kDebugMode) | 複数要素 | Flavor情報、リポジトリ切替、ギャラリー |

**Debug Section Details:**
- Flavor / App Name / Base URL 表示
- `SwitchListTile` - Debug Repositoryトグル
- Reset to Defaults ボタン
- Discord Components ギャラリーリンク

**User Interactions:**
1. テーマ選択 → 即座に反映
2. 言語選択 → 即座に反映
3. Aboutタップ → ダイアログ表示
4. Sign Outタップ → 確認ダイアログ → ログアウト
5. Debug Repositoryトグル → ダミーデータ切替

---

### 2.4 Main Navigation (main)

**MainScreen** (`lib/features/main/ui/screens/main_screen.dart`)

| Element | Widget | Behavior |
|---------|--------|----------|
| Shell | `AutoTabsScaffold` | タブナビゲーション管理 |
| Bottom Nav | `NavigationBar` | 2タブ (TODOs, Settings) |
| Tab 1 | `NavigationDestination` | TODOs (list icon) |
| Tab 2 | `NavigationDestination` | Settings (settings icon) |

---

## 3. Core Infrastructure

### 3.1 Theme System

**AppColors** (`lib/core/theme/app_colors.dart`)
- Primary / Secondary / Tertiary colors
- Error / Success / Warning colors
- Surface colors (5 levels for light/dark)
- CategoryColors (16色プリセット)

**DiscordColors** (`lib/core/theme/app_colors.dart`)
- Brand: Blurple, Green, Yellow, Fuchsia, Red
- Light mode: background, surface, text colors
- Dark mode: background, surface, text colors
- Status: online, idle, dnd, offline

**AppTheme** (`lib/core/theme/app_theme.dart`)
- Light/Dark ThemeData構築
- Material 3 対応

**AppSpacing** (`lib/core/theme/app_spacing.dart`)
- xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48
- VGap / HGap widgets

**AppRadius** (`lib/core/theme/app_radius.dart`)
- Standard: xs(4), sm(8), md(12), lg(16), xl(20), full(9999)
- Discord presets: pill(24), discordInput(sm), discordSheet(lgTop)

### 3.2 Routing

**AppRouter** (`lib/core/router/app_router.dart`)
```
Routes:
├── /login (LoginRoute)
└── / (MainRoute) [AuthGuard]
    ├── /todos (TodoListRoute)
    ├── /settings (SettingsRoute)
    └── /todo/:id (TodoEditRoute)
```

**AuthGuard** (`lib/core/router/auth_guard.dart`)
- 未認証時は/loginにリダイレクト

### 3.3 Localization

**Supported Locales:** en, ja

**AppLocalizations**
- Source ARB files: `lib/l10n/` (`app_en.arb`, `app_ja.arb`)
- Generated Dart files: `lib/core/l10n/`
- 50+ localized strings
- `AppLocalizations.of(context)` でアクセス

### 3.4 Debug Tools

**DebugSettings** (`lib/core/debug/`)
- `useDebugRepository` toggle
- `DebugTodoRepository` でダミーデータ

**Talker** (`lib/core/dev_tools/talker.dart`)
- ルーター/Riverpodログ出力

**DiscordComponentGallery** (`lib/core/dev_tools/discord_component_gallery.dart`)
- 全Discordコンポーネントのプレビュー

---

## 4. UI Component Inventory

### 4.1 App Components (`lib/core/components/`)

| Component | Variants | Features |
|-----------|----------|----------|
| `AppButton` | filled, outlined, text, tonal | 3 sizes, loading state |
| `AppTextField` | - | label, hint, prefix/suffix |
| `AppSearchField` | - | AppTextFieldを内部使用、clearボタン付き検索用 |
| `AppCard` | - | elevation 0, Material3 |
| `AppLoadingOverlay` | - | スピナー表示 |
| `AppEmptyState` | - | icon, title, description |
| `AppErrorState` | - | エラー表示 |

### 4.2 Discord Components (`lib/core/components/discord/`)

| Component | Variants | Features |
|-----------|----------|----------|
| `DiscordPillButton` | filled, outlined, gray | icon, loading, expanded |
| `DiscordTextField` | - | Discord gray surface, blurple focus |
| `DiscordSegmentedControl` | - | pill shape, animated |
| `DiscordTabBar` | - | underline indicator (in discord_segmented_control.dart) |
| `DiscordListTile` | - | avatar support, divider |
| `DiscordAvatar` | - | status indicator (online/idle/dnd/offline) |
| `DiscordBottomSheet` | - | illustration, actions |
| `DiscordConfirmSheet` | - | confirm/cancel pattern |

---

## 5. Screen-by-Screen Material → Discord Mapping

### LoginScreen
| Current Widget | Discord Replacement |
|----------------|---------------------|
| `AppTextField` | `DiscordTextField` |
| `AppButton` | `DiscordPillButton` |
| Demo `Container` | `DiscordInfoCard` (新規) |
| `SnackBar` | `DiscordSnackbar` (新規) |

### MainScreen
| Current Widget | Discord Replacement |
|----------------|---------------------|
| `NavigationBar` | `DiscordBottomNavBar` (新規) |

### SettingsScreen
| Current Widget | Discord Replacement |
|----------------|---------------------|
| `ListTile` | `DiscordListTile` |
| `SwitchListTile` | `DiscordListTile` + `DiscordSwitch` (新規) |
| `CircleAvatar` | `DiscordAvatar` |
| `AlertDialog` | `DiscordConfirmSheet` |

### TodoListScreen
| Current Widget | Discord Replacement |
|----------------|---------------------|
| `FilterChip` | `DiscordChip` (新規) |
| `FloatingActionButton` | `DiscordFAB` (新規) |
| `SnackBar` | `DiscordSnackbar` (新規) |
| TodoTile styling | `DiscordCard` (新規) + `DiscordCheckbox` (新規) |

### TodoEditScreen
| Current Widget | Discord Replacement |
|----------------|---------------------|
| `AppTextField` | `DiscordTextField` |
| `AppButton` | `DiscordPillButton` |
| `AlertDialog` | `DiscordConfirmSheet` |
| `DatePicker` | Material維持 |

---

## 6. Required New Discord Components

| Component | Priority | Used In |
|-----------|----------|---------|
| `DiscordBottomNavBar` | High | MainScreen |
| `DiscordChip` | High | TodoListScreen |
| `DiscordFAB` | High | TodoListScreen |
| `DiscordSwitch` | High | SettingsScreen |
| `DiscordSnackbar` | High | Login, TodoList |
| `DiscordCheckbox` | Medium | TodoTile |
| `DiscordCard` | Medium | TodoTile |
| `DiscordInfoCard` | Medium | LoginScreen |
