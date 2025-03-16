///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element

class Translations implements BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.en,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  // Translations
  late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
  late final TranslationsPagesEn pages = TranslationsPagesEn.internal(_root);
}

// Path: common
class TranslationsCommonEn {
  TranslationsCommonEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsCommonPageTitlesEn page_titles =
      TranslationsCommonPageTitlesEn.internal(_root);
  late final TranslationsCommonNavbarEn navbar =
      TranslationsCommonNavbarEn.internal(_root);
  String get generic_error => 'Something went wrong';
  String get generic_acknowledge => 'Ok';
}

// Path: pages
class TranslationsPagesEn {
  TranslationsPagesEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsPagesSendEn send =
      TranslationsPagesSendEn.internal(_root);
}

// Path: common.page_titles
class TranslationsCommonPageTitlesEn {
  TranslationsCommonPageTitlesEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get settings => 'Settings';
  String get send => 'Send File';
  String get receive => 'Receive File';
}

// Path: common.navbar
class TranslationsCommonNavbarEn {
  TranslationsCommonNavbarEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get send => 'Send';
  String get receive => 'Receive';
  String get settings => 'Settings';
}

// Path: pages.send
class TranslationsPagesSendEn {
  TranslationsPagesSendEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get send_file => 'Send file';
  String get send_folder => 'Send folder';
  String get permission_denied => 'Permission required to send folders';
  String get abort_transfer_title => 'Abort file transfer?';
  String get abort_transfer_message =>
      'Do you want to abort the current file transfer?';
  String get abort_transfer_yes => 'Abort';
  String get abort_transfer_no => 'Continue';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'common.page_titles.settings':
        return 'Settings';
      case 'common.page_titles.send':
        return 'Send File';
      case 'common.page_titles.receive':
        return 'Receive File';
      case 'common.navbar.send':
        return 'Send';
      case 'common.navbar.receive':
        return 'Receive';
      case 'common.navbar.settings':
        return 'Settings';
      case 'common.generic_error':
        return 'Something went wrong';
      case 'common.generic_acknowledge':
        return 'Ok';
      case 'pages.send.send_file':
        return 'Send file';
      case 'pages.send.send_folder':
        return 'Send folder';
      case 'pages.send.permission_denied':
        return 'Permission required to send folders';
      case 'pages.send.abort_transfer_title':
        return 'Abort file transfer?';
      case 'pages.send.abort_transfer_message':
        return 'Do you want to abort the current file transfer?';
      case 'pages.send.abort_transfer_yes':
        return 'Abort';
      case 'pages.send.abort_transfer_no':
        return 'Continue';
      default:
        return null;
    }
  }
}
