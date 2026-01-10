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
  String get todoTitle => 'タイトル';

  @override
  String get todoDescription => '説明';

  @override
  String get todoDueDate => '期限';

  @override
  String get todoEmptyTitle => 'TODOがありません';

  @override
  String get todoEmptyDescription => '+をタップしてTODOを追加してください';

  @override
  String get filterAll => 'すべて';

  @override
  String get filterActive => '未完了';

  @override
  String get filterCompleted => '完了済み';

  @override
  String get clearCompleted => '完了を削除';

  @override
  String get about => 'アプリについて';
}
