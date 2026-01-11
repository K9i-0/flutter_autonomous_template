import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Flutter App'**
  String get appTitle;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Japanese language option
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get languageJapanese;

  /// Theme setting label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// TODOs screen title
  ///
  /// In en, this message translates to:
  /// **'TODOs'**
  String get todos;

  /// Add TODO button
  ///
  /// In en, this message translates to:
  /// **'Add TODO'**
  String get todoAdd;

  /// Edit TODO screen title
  ///
  /// In en, this message translates to:
  /// **'Edit TODO'**
  String get todoEdit;

  /// New TODO screen title
  ///
  /// In en, this message translates to:
  /// **'New TODO'**
  String get todoNew;

  /// TODO title field label
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get todoTitle;

  /// TODO title field hint
  ///
  /// In en, this message translates to:
  /// **'What needs to be done?'**
  String get todoTitleHint;

  /// TODO title validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get todoTitleRequired;

  /// TODO description field label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get todoDescription;

  /// TODO description field label with optional
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get todoDescriptionOptional;

  /// TODO description field hint
  ///
  /// In en, this message translates to:
  /// **'Add some details...'**
  String get todoDescriptionHint;

  /// TODO due date field label
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get todoDueDate;

  /// TODO due date field label with optional
  ///
  /// In en, this message translates to:
  /// **'Due date (optional)'**
  String get todoDueDateOptional;

  /// No due date selected
  ///
  /// In en, this message translates to:
  /// **'No due date'**
  String get todoDueDateNone;

  /// Empty TODO list title
  ///
  /// In en, this message translates to:
  /// **'No TODOs yet'**
  String get todoEmptyTitle;

  /// Empty TODO list description
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first TODO'**
  String get todoEmptyDescription;

  /// TODO deleted snackbar message
  ///
  /// In en, this message translates to:
  /// **'Deleted \"{title}\"'**
  String todoDeleted(String title);

  /// Delete TODO dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete TODO?'**
  String get todoDeleteTitle;

  /// Delete TODO confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"?'**
  String todoDeleteConfirm(String title);

  /// Save changes button
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// All filter option
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// Active filter option
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get filterActive;

  /// Completed filter option
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get filterCompleted;

  /// All filter with count
  ///
  /// In en, this message translates to:
  /// **'All ({count})'**
  String filterAllCount(int count);

  /// Active filter with count
  ///
  /// In en, this message translates to:
  /// **'Active ({count})'**
  String filterActiveCount(int count);

  /// Done filter with count
  ///
  /// In en, this message translates to:
  /// **'Done ({count})'**
  String filterDoneCount(int count);

  /// Clear completed button
  ///
  /// In en, this message translates to:
  /// **'Clear completed'**
  String get clearCompleted;

  /// Mark TODO as complete
  ///
  /// In en, this message translates to:
  /// **'Mark complete'**
  String get markComplete;

  /// Mark TODO as incomplete
  ///
  /// In en, this message translates to:
  /// **'Mark incomplete'**
  String get markIncomplete;

  /// About menu item
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Sign in button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Email field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// Email required validation
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailRequired;

  /// Email invalid validation
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailInvalid;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// Password required validation
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordRequired;

  /// Demo mode section title
  ///
  /// In en, this message translates to:
  /// **'Demo Mode'**
  String get demoMode;

  /// Demo mode description
  ///
  /// In en, this message translates to:
  /// **'This is a mock login. Enter any email and password to sign in.'**
  String get demoModeDescription;

  /// Login failed error message
  ///
  /// In en, this message translates to:
  /// **'Login failed: {error}'**
  String loginFailed(String error);

  /// Account section title
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Sign out button
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Sign out confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirm;

  /// Debug info section title
  ///
  /// In en, this message translates to:
  /// **'Debug Info'**
  String get debugInfo;

  /// Repository debug section title
  ///
  /// In en, this message translates to:
  /// **'Repository Debug'**
  String get repositoryDebug;

  /// Use debug repository toggle
  ///
  /// In en, this message translates to:
  /// **'Use Debug Repository'**
  String get useDebugRepository;

  /// Use debug repository description
  ///
  /// In en, this message translates to:
  /// **'Show dummy data for screenshots'**
  String get useDebugRepositoryDesc;

  /// Reset to defaults button
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get resetToDefaults;

  /// Today date label
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dateToday;

  /// Tomorrow date label
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get dateTomorrow;

  /// Yesterday date label
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dateYesterday;

  /// In N days
  ///
  /// In en, this message translates to:
  /// **'In {count} days'**
  String dateInDays(int count);

  /// N days ago
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String dateDaysAgo(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
