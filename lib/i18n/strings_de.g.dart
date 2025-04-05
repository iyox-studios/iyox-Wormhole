///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsDe extends Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsDe(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.de,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ),
        super(
            cardinalResolver: cardinalResolver,
            ordinalResolver: ordinalResolver) {
    super.$meta.setFlatMapFunction(
        $meta.getTranslation); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <de>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsDe _root = this; // ignore: unused_field

  @override
  TranslationsDe $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsDe(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsCommonDe common = _TranslationsCommonDe._(_root);
  @override
  late final _TranslationsPagesDe pages = _TranslationsPagesDe._(_root);
}

// Path: common
class _TranslationsCommonDe extends TranslationsCommonEn {
  _TranslationsCommonDe._(TranslationsDe root)
      : this._root = root,
        super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsCommonPageTitlesDe page_titles =
      _TranslationsCommonPageTitlesDe._(_root);
  @override
  late final _TranslationsCommonNavbarDe navbar =
      _TranslationsCommonNavbarDe._(_root);
  @override
  String get generic_error => 'Etwas ist schiefgelaufen';
  @override
  String get generic_acknowledge => 'Ok';
  @override
  String get cancel => 'Abbrechen';
}

// Path: pages
class _TranslationsPagesDe extends TranslationsPagesEn {
  _TranslationsPagesDe._(TranslationsDe root)
      : this._root = root,
        super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsPagesSendDe send = _TranslationsPagesSendDe._(_root);
  @override
  late final _TranslationsPagesReceiveDe receive =
      _TranslationsPagesReceiveDe._(_root);
  @override
  late final _TranslationsPagesSettingsDe settings =
      _TranslationsPagesSettingsDe._(_root);
}

// Path: common.page_titles
class _TranslationsCommonPageTitlesDe extends TranslationsCommonPageTitlesEn {
  _TranslationsCommonPageTitlesDe._(TranslationsDe root)
      : this._root = root,
        super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get settings => 'Einstellungen';
  @override
  String get send => 'Datei Senden';
  @override
  String get receive => 'Datei Empfangen';
}

// Path: common.navbar
class _TranslationsCommonNavbarDe extends TranslationsCommonNavbarEn {
  _TranslationsCommonNavbarDe._(TranslationsDe root)
      : this._root = root,
        super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get send => 'Senden';
  @override
  String get receive => 'Empfangen';
  @override
  String get settings => 'Einstellungen';
}

// Path: pages.send
class _TranslationsPagesSendDe extends TranslationsPagesSendEn {
  _TranslationsPagesSendDe._(TranslationsDe root)
      : this._root = root,
        super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get send_file => 'Datei Senden';
  @override
  String get send_folder => 'Ordner Senden';
  @override
  String get permission_denied => 'Berechtigung benötigt, um Ordner zu senden';
  @override
  String get abort_transfer_title => 'Dateiübertragung abbrechen?';
  @override
  String get abort_transfer_message =>
      'Möchten Sie die laufende Dateiübertragung abbrechen?';
  @override
  String get abort_transfer_yes => 'Abbrechen';
  @override
  String get abort_transfer_no => 'Weiter';
  @override
  String get zip_failed =>
      'Beim Erstellen des ZIP-Archivs ist ein Fehler aufgetreten';
  @override
  String get clipboard_copied => 'Code in die Zwischenablage kopiert';
  @override
  String get status_waiting => 'Warten auf Empfänger';
  @override
  String get status_transferring => 'Datei wird übertragen';
  @override
  String connection_info({required Object type}) => 'Übertragung über: ${type}';
  @override
  String get status_initializing => 'Übertragung wird initialisiert';
  @override
  String get status_zipping => 'Zip-Datei wird erstellt';
  @override
  String status_zipping_progress({required Object progress}) =>
      'Zip-Datei wird erstellt: ${progress}';
  @override
  String get status_starting_transfer => 'Übertragung wird gestartet';
}

// Path: pages.receive
class _TranslationsPagesReceiveDe extends TranslationsPagesReceiveEn {
  _TranslationsPagesReceiveDe._(TranslationsDe root)
      : this._root = root,
        super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get code_input_hint => 'Code eingeben';
  @override
  String get receive_button => 'Datei erhalten';
  @override
  String get status_connecting => 'Verbindung herstellen...';
  @override
  String get status_transferring => 'Datei wird übertragen';
  @override
  String status_finished({required Object name}) => 'Datei erhalten: ${name}';
}

// Path: pages.settings
class _TranslationsPagesSettingsDe extends TranslationsPagesSettingsEn {
  _TranslationsPagesSettingsDe._(TranslationsDe root)
      : this._root = root,
        super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get general_header => 'Allgemein';
  @override
  String get appearance_header => 'Erscheinungsbild';
  @override
  String get connection_header => 'Verbindung';
  @override
  String get language_label => 'Sprache';
  @override
  String get language_system => 'Systemstandard';
  @override
  String get theme_label => 'Design';
  @override
  String get theme_system => 'System';
  @override
  String get theme_light => 'Hell';
  @override
  String get theme_dark => 'Dunkel';
  @override
  String get dynamic_color_label => 'Dynamische Farben';
  @override
  String get dynamic_color_subtitle => 'Systemfarben verwenden (Android 12+)';
  @override
  String get rendezvous_url_label => 'Rendezvous Server URL';
  @override
  String get transmit_url_label => 'Transit Server URL';
  @override
  String get code_length_label => 'Code-Länge';
  @override
  String get accent_color_label => 'Akzentfarbe';
  @override
  String get reset_to_default => 'Auf Standard zurücksetzen';
  @override
  String get app_version_label => 'App-Version';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsDe {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'common.page_titles.settings':
        return 'Einstellungen';
      case 'common.page_titles.send':
        return 'Datei Senden';
      case 'common.page_titles.receive':
        return 'Datei Empfangen';
      case 'common.navbar.send':
        return 'Senden';
      case 'common.navbar.receive':
        return 'Empfangen';
      case 'common.navbar.settings':
        return 'Einstellungen';
      case 'common.generic_error':
        return 'Etwas ist schiefgelaufen';
      case 'common.generic_acknowledge':
        return 'Ok';
      case 'common.cancel':
        return 'Abbrechen';
      case 'pages.send.send_file':
        return 'Datei Senden';
      case 'pages.send.send_folder':
        return 'Ordner Senden';
      case 'pages.send.permission_denied':
        return 'Berechtigung benötigt, um Ordner zu senden';
      case 'pages.send.abort_transfer_title':
        return 'Dateiübertragung abbrechen?';
      case 'pages.send.abort_transfer_message':
        return 'Möchten Sie die laufende Dateiübertragung abbrechen?';
      case 'pages.send.abort_transfer_yes':
        return 'Abbrechen';
      case 'pages.send.abort_transfer_no':
        return 'Weiter';
      case 'pages.send.zip_failed':
        return 'Beim Erstellen des ZIP-Archivs ist ein Fehler aufgetreten';
      case 'pages.send.clipboard_copied':
        return 'Code in die Zwischenablage kopiert';
      case 'pages.send.status_waiting':
        return 'Warten auf Empfänger';
      case 'pages.send.status_transferring':
        return 'Datei wird übertragen';
      case 'pages.send.connection_info':
        return ({required Object type}) => 'Übertragung über: ${type}';
      case 'pages.send.status_initializing':
        return 'Übertragung wird initialisiert';
      case 'pages.send.status_zipping':
        return 'Zip-Datei wird erstellt';
      case 'pages.send.status_zipping_progress':
        return ({required Object progress}) =>
            'Zip-Datei wird erstellt: ${progress}';
      case 'pages.send.status_starting_transfer':
        return 'Übertragung wird gestartet';
      case 'pages.receive.code_input_hint':
        return 'Code eingeben';
      case 'pages.receive.receive_button':
        return 'Datei erhalten';
      case 'pages.receive.status_connecting':
        return 'Verbindung herstellen...';
      case 'pages.receive.status_transferring':
        return 'Datei wird übertragen';
      case 'pages.receive.status_finished':
        return ({required Object name}) => 'Datei erhalten: ${name}';
      case 'pages.settings.general_header':
        return 'Allgemein';
      case 'pages.settings.appearance_header':
        return 'Erscheinungsbild';
      case 'pages.settings.connection_header':
        return 'Verbindung';
      case 'pages.settings.language_label':
        return 'Sprache';
      case 'pages.settings.language_system':
        return 'Systemstandard';
      case 'pages.settings.theme_label':
        return 'Design';
      case 'pages.settings.theme_system':
        return 'System';
      case 'pages.settings.theme_light':
        return 'Hell';
      case 'pages.settings.theme_dark':
        return 'Dunkel';
      case 'pages.settings.dynamic_color_label':
        return 'Dynamische Farben';
      case 'pages.settings.dynamic_color_subtitle':
        return 'Systemfarben verwenden (Android 12+)';
      case 'pages.settings.rendezvous_url_label':
        return 'Rendezvous Server URL';
      case 'pages.settings.transmit_url_label':
        return 'Transit Server URL';
      case 'pages.settings.code_length_label':
        return 'Code-Länge';
      case 'pages.settings.accent_color_label':
        return 'Akzentfarbe';
      case 'pages.settings.reset_to_default':
        return 'Auf Standard zurücksetzen';
      case 'pages.settings.app_version_label':
        return 'App-Version';
      default:
        return null;
    }
  }
}
