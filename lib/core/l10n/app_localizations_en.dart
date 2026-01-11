// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter App';

  @override
  String get welcome => 'Welcome';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageJapanese => 'Japanese';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get ok => 'OK';

  @override
  String get todos => 'TODOs';

  @override
  String get todoAdd => 'Add TODO';

  @override
  String get todoEdit => 'Edit TODO';

  @override
  String get todoNew => 'New TODO';

  @override
  String get todoTitle => 'Title';

  @override
  String get todoTitleHint => 'What needs to be done?';

  @override
  String get todoTitleRequired => 'Please enter a title';

  @override
  String get todoDescription => 'Description';

  @override
  String get todoDescriptionOptional => 'Description (optional)';

  @override
  String get todoDescriptionHint => 'Add some details...';

  @override
  String get todoDueDate => 'Due date';

  @override
  String get todoDueDateOptional => 'Due date (optional)';

  @override
  String get todoDueDateNone => 'No due date';

  @override
  String get todoEmptyTitle => 'No TODOs yet';

  @override
  String get todoEmptyDescription => 'Tap + to add your first TODO';

  @override
  String todoDeleted(String title) {
    return 'Deleted \"$title\"';
  }

  @override
  String get todoDeleteTitle => 'Delete TODO?';

  @override
  String todoDeleteConfirm(String title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get saveChanges => 'Save changes';

  @override
  String get filterAll => 'All';

  @override
  String get filterActive => 'Active';

  @override
  String get filterCompleted => 'Completed';

  @override
  String filterAllCount(int count) {
    return 'All ($count)';
  }

  @override
  String filterActiveCount(int count) {
    return 'Active ($count)';
  }

  @override
  String filterDoneCount(int count) {
    return 'Done ($count)';
  }

  @override
  String get clearCompleted => 'Clear completed';

  @override
  String get markComplete => 'Mark complete';

  @override
  String get markIncomplete => 'Mark incomplete';

  @override
  String get about => 'About';

  @override
  String get signIn => 'Sign In';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get emailRequired => 'Please enter your email';

  @override
  String get emailInvalid => 'Please enter a valid email';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get demoMode => 'Demo Mode';

  @override
  String get demoModeDescription =>
      'This is a mock login. Enter any email and password to sign in.';

  @override
  String loginFailed(String error) {
    return 'Login failed: $error';
  }

  @override
  String get account => 'Account';

  @override
  String get signOut => 'Sign Out';

  @override
  String get signOutConfirm => 'Are you sure you want to sign out?';

  @override
  String get debugInfo => 'Debug Info';

  @override
  String get repositoryDebug => 'Repository Debug';

  @override
  String get useDebugRepository => 'Use Debug Repository';

  @override
  String get useDebugRepositoryDesc => 'Show dummy data for screenshots';

  @override
  String get resetToDefaults => 'Reset to Defaults';

  @override
  String get dateToday => 'Today';

  @override
  String get dateTomorrow => 'Tomorrow';

  @override
  String get dateYesterday => 'Yesterday';

  @override
  String dateInDays(int count) {
    return 'In $count days';
  }

  @override
  String dateDaysAgo(int count) {
    return '$count days ago';
  }
}
