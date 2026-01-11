// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Flutterアプリ';

  @override
  String get welcome => 'ようこそ';

  @override
  String get settings => '設定';

  @override
  String get language => '言語';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageJapanese => '日本語';

  @override
  String get theme => 'テーマ';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeSystem => 'システム';

  @override
  String get cancel => 'キャンセル';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get ok => 'OK';

  @override
  String get todos => 'TODO';

  @override
  String get todoAdd => 'TODOを追加';

  @override
  String get todoEdit => 'TODOを編集';

  @override
  String get todoNew => '新規TODO';

  @override
  String get todoTitle => 'タイトル';

  @override
  String get todoTitleHint => '何をしますか？';

  @override
  String get todoTitleRequired => 'タイトルを入力してください';

  @override
  String get todoDescription => '説明';

  @override
  String get todoDescriptionOptional => '説明（任意）';

  @override
  String get todoDescriptionHint => '詳細を追加...';

  @override
  String get todoDueDate => '期限';

  @override
  String get todoDueDateOptional => '期限（任意）';

  @override
  String get todoDueDateNone => '期限なし';

  @override
  String get todoEmptyTitle => 'TODOがありません';

  @override
  String get todoEmptyDescription => '+をタップしてTODOを追加してください';

  @override
  String todoDeleted(String title) {
    return '「$title」を削除しました';
  }

  @override
  String get todoDeleteTitle => 'TODOを削除しますか？';

  @override
  String todoDeleteConfirm(String title) {
    return '「$title」を削除してもよろしいですか？';
  }

  @override
  String get saveChanges => '変更を保存';

  @override
  String get filterAll => 'すべて';

  @override
  String get filterActive => '未完了';

  @override
  String get filterCompleted => '完了済み';

  @override
  String filterAllCount(int count) {
    return 'すべて ($count)';
  }

  @override
  String filterActiveCount(int count) {
    return '未完了 ($count)';
  }

  @override
  String filterDoneCount(int count) {
    return '完了 ($count)';
  }

  @override
  String get clearCompleted => '完了を削除';

  @override
  String get markComplete => '完了にする';

  @override
  String get markIncomplete => '未完了にする';

  @override
  String get about => 'アプリについて';

  @override
  String get signIn => 'サインイン';

  @override
  String get welcomeBack => 'おかえりなさい';

  @override
  String get signInToContinue => '続けるにはサインインしてください';

  @override
  String get email => 'メールアドレス';

  @override
  String get emailHint => 'メールアドレスを入力';

  @override
  String get emailRequired => 'メールアドレスを入力してください';

  @override
  String get emailInvalid => '有効なメールアドレスを入力してください';

  @override
  String get password => 'パスワード';

  @override
  String get passwordHint => 'パスワードを入力';

  @override
  String get passwordRequired => 'パスワードを入力してください';

  @override
  String get demoMode => 'デモモード';

  @override
  String get demoModeDescription => 'これはモックログインです。任意のメールアドレスとパスワードでサインインできます。';

  @override
  String loginFailed(String error) {
    return 'ログイン失敗: $error';
  }

  @override
  String get account => 'アカウント';

  @override
  String get signOut => 'サインアウト';

  @override
  String get signOutConfirm => 'サインアウトしてもよろしいですか？';

  @override
  String get debugInfo => 'デバッグ情報';

  @override
  String get repositoryDebug => 'リポジトリデバッグ';

  @override
  String get useDebugRepository => 'デバッグリポジトリを使用';

  @override
  String get useDebugRepositoryDesc => 'スクリーンショット用のダミーデータを表示';

  @override
  String get resetToDefaults => 'デフォルトに戻す';

  @override
  String get dateToday => '今日';

  @override
  String get dateTomorrow => '明日';

  @override
  String get dateYesterday => '昨日';

  @override
  String dateInDays(int count) {
    return '$count日後';
  }

  @override
  String dateDaysAgo(int count) {
    return '$count日前';
  }
}
