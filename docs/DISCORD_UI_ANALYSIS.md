# Discord UI Analysis & TODO App Adaptation Plan

## Discord UIの特徴（参考画像より）

### 1. レイアウト構造

| 要素 | 特徴 |
|------|------|
| **左サイドバー** | サーバーアイコンが縦に並ぶ（丸角正方形）、選択時に左に白いインジケーターバー |
| **メインエリア** | 白/ダーク背景のカード式リスト、大きめの余白 |
| **下部ナビゲーション** | アイコン＋ラベル（ホーム、通知、あなた）、選択時にアイコン塗りつぶし |
| **FAB** | Blurple色の丸いボタン（例：「DMの作成」） |

### 2. メッセージ/チャット画面

#### メッセージ構造
```
[アバター] [ユーザー名] [バッジ] [タイムスタンプ]
          [タイトル（太字）]
          [本文テキスト]
          [@メンション（黄色ハイライト）]
          [リアクション絵文字バー: 💯1 ❤️177 🙏47]
```

#### 日付セパレーター
- 水平ライン + 中央に日付テキスト（「August 7, 2025」）
- メッセージをグループ化

#### 入力バー
```
[+] [テキストフィールド @ユーザー...] [😊] [🎤]
```

### 3. リスト表示

#### DM一覧
```
[アバター] [ユーザー名]          [時刻]
          [最新メッセージプレビュー]
```

#### チャンネル一覧
```
[#] [チャンネル名]
    [● X人がオンライン]
```

### 4. コンポーネント詳細

| コンポーネント | 特徴 |
|--------------|------|
| **ボタン** | Blurple(#5865F2)の pill 形状、大きめのパディング |
| **セグメントコントロール** | 選択: 白背景 pill、非選択: 透明 |
| **チェックボックス** | 丸角四角(radius 6)、チェック時Blurple塗りつぶし |
| **選択カード** | 右端にBlurple丸チェックマーク |
| **アバター** | 丸形、オンライン時に緑のステータスドット |
| **バッジ** | 小さい pill 形状（例: ⚡0 MS） |

---

## TODO アプリへの適用計画

### Phase 1: チャット風レイアウトへの変換

#### 現在のTODO一覧 → メッセージ風表示

**Before (カードリスト)**:
```
┌─────────────────────────────┐
│ [□] タスクタイトル          │
│     説明テキスト            │
│     📅 明日                 │
└─────────────────────────────┘
```

**After (メッセージ風)**:
```
────────── Today ──────────

[Avatar] You           9:30 AM
         買い物に行く
         牛乳、卵、パンを買う
         [✓完了] [😊]

[Avatar] You           Yesterday
         レポートを提出
         ✅ 完了済み
```

### Phase 2: 新規コンポーネント

| コンポーネント | 用途 |
|--------------|------|
| `DiscordMessageBubble` | TODO項目をメッセージ風に表示 |
| `DiscordDateSeparator` | 日付でTODOをグループ化 |
| `DiscordReactionBar` | カテゴリーや優先度を絵文字風に表示 |
| `DiscordInputBar` | TODO追加用の入力バー（FABの代替） |
| `DiscordAvatar` | ユーザーアバター（オンラインステータス付き） |

### Phase 3: 画面別リデザイン

#### TodoListScreen
1. FAB → 画面下部の入力バー
2. フィルターチップ → セグメントコントロール（上部）
3. カードリスト → メッセージ風リスト + 日付セパレーター
4. Dismissible削除 → 長押しでアクションメニュー

#### TodoEditScreen
1. 従来のフォーム形式は維持
2. 入力フィールドをDiscordスタイルに
3. カテゴリー選択をリアクション風に

### Phase 4: ナビゲーション

#### 現在
```
[BottomNav: TODO | 設定]
```

#### 提案
```
左サイドバー: カテゴリーアイコン（仕事、個人、買い物...）
下部ナビ: [ホーム | 通知 | あなた]
```

---

## 実装優先順位

### 高優先度（コアUI変更）
1. `DiscordMessageBubble` - TODOをメッセージ風に
2. `DiscordDateSeparator` - 日付グループ化
3. `DiscordInputBar` - 画面下部のTODO追加バー

### 中優先度（UX向上）
4. `DiscordReactionBar` - カテゴリー/優先度表示
5. `DiscordAvatar` - ユーザー表示
6. 長押しアクションメニュー

### 低優先度（オプション）
7. 左サイドバー（カテゴリー切り替え）
8. アニメーション強化

---

## 色・スタイル参照

```dart
// Discord Colors (既存)
static const blurple = Color(0xFF5865F2);
static const green = Color(0xFF57F287);  // オンライン
static const yellow = Color(0xFFFEE75C); // メンションハイライト
static const red = Color(0xFFED4245);
static const backgroundDark = Color(0xFF313338);
static const surfaceDark = Color(0xFF2B2D31);
```

## ファイル構成（予定）

```
lib/core/components/discord/
├── discord_message_bubble.dart    # NEW
├── discord_date_separator.dart    # NEW
├── discord_input_bar.dart         # NEW
├── discord_reaction_bar.dart      # NEW
├── discord_avatar.dart            # NEW
├── ... (既存コンポーネント)
```
