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
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsCommonDe common = _TranslationsCommonDe._(_root);
	@override late final _TranslationsPagesDe pages = _TranslationsPagesDe._(_root);
}

// Path: common
class _TranslationsCommonDe extends TranslationsCommonEn {
	_TranslationsCommonDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsCommonPageTitlesDe page_titles = _TranslationsCommonPageTitlesDe._(_root);
	@override late final _TranslationsCommonNavbarDe navbar = _TranslationsCommonNavbarDe._(_root);
	@override String get generic_error => 'Etwas ist schiefgelaufen';
	@override String get generic_acknowledge => 'Ok';
}

// Path: pages
class _TranslationsPagesDe extends TranslationsPagesEn {
	_TranslationsPagesDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesSendDe send = _TranslationsPagesSendDe._(_root);
	@override late final _TranslationsPagesReceiveDe receive = _TranslationsPagesReceiveDe._(_root);
}

// Path: common.page_titles
class _TranslationsCommonPageTitlesDe extends TranslationsCommonPageTitlesEn {
	_TranslationsCommonPageTitlesDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Einstellungen';
	@override String get send => 'Datei Senden';
	@override String get receive => 'Datei Empfangen';
}

// Path: common.navbar
class _TranslationsCommonNavbarDe extends TranslationsCommonNavbarEn {
	_TranslationsCommonNavbarDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get send => 'Senden';
	@override String get receive => 'Empfangen';
	@override String get settings => 'Einstellungen';
}

// Path: pages.send
class _TranslationsPagesSendDe extends TranslationsPagesSendEn {
	_TranslationsPagesSendDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get send_file => 'Datei Senden';
	@override String get send_folder => 'Ordner Senden';
	@override String get permission_denied => 'Berechtigung benötigt, um Ordner zu senden';
	@override String get abort_transfer_title => 'Dateiübertragung abbrechen?';
	@override String get abort_transfer_message => 'Möchten Sie die laufende Dateiübertragung abbrechen?';
	@override String get abort_transfer_yes => 'Abbrechen';
	@override String get abort_transfer_no => 'Weiter';
	@override String get zip_failed => 'Beim Erstellen des ZIP-Archivs ist ein Fehler aufgetreten';
}

// Path: pages.receive
class _TranslationsPagesReceiveDe extends TranslationsPagesReceiveEn {
	_TranslationsPagesReceiveDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get code_input_hint => 'Code eingeben';
	@override String get receive_button => 'Datei erhalten';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.page_titles.settings': return 'Einstellungen';
			case 'common.page_titles.send': return 'Datei Senden';
			case 'common.page_titles.receive': return 'Datei Empfangen';
			case 'common.navbar.send': return 'Senden';
			case 'common.navbar.receive': return 'Empfangen';
			case 'common.navbar.settings': return 'Einstellungen';
			case 'common.generic_error': return 'Etwas ist schiefgelaufen';
			case 'common.generic_acknowledge': return 'Ok';
			case 'pages.send.send_file': return 'Datei Senden';
			case 'pages.send.send_folder': return 'Ordner Senden';
			case 'pages.send.permission_denied': return 'Berechtigung benötigt, um Ordner zu senden';
			case 'pages.send.abort_transfer_title': return 'Dateiübertragung abbrechen?';
			case 'pages.send.abort_transfer_message': return 'Möchten Sie die laufende Dateiübertragung abbrechen?';
			case 'pages.send.abort_transfer_yes': return 'Abbrechen';
			case 'pages.send.abort_transfer_no': return 'Weiter';
			case 'pages.send.zip_failed': return 'Beim Erstellen des ZIP-Archivs ist ein Fehler aufgetreten';
			case 'pages.receive.code_input_hint': return 'Code eingeben';
			case 'pages.receive.receive_button': return 'Datei erhalten';
			default: return null;
		}
	}
}

