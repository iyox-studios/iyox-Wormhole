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
class TranslationsIt extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsIt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsIt _root = this; // ignore: unused_field

	@override 
	TranslationsIt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsIt(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonIt common = _TranslationsCommonIt._(_root);
	@override late final _TranslationsPagesIt pages = _TranslationsPagesIt._(_root);
}

// Path: common
class _TranslationsCommonIt extends TranslationsCommonEn {
	_TranslationsCommonIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsCommonPageTitlesIt page_titles = _TranslationsCommonPageTitlesIt._(_root);
	@override late final _TranslationsCommonNavbarIt navbar = _TranslationsCommonNavbarIt._(_root);
	@override String get generic_error => 'Qualcosa è andato storto';
	@override String get generic_acknowledge => 'Ok';
	@override String get cancel => 'Annulla';
}

// Path: pages
class _TranslationsPagesIt extends TranslationsPagesEn {
	_TranslationsPagesIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesSendIt send = _TranslationsPagesSendIt._(_root);
	@override late final _TranslationsPagesReceiveIt receive = _TranslationsPagesReceiveIt._(_root);
	@override late final _TranslationsPagesSettingsIt settings = _TranslationsPagesSettingsIt._(_root);
}

// Path: common.page_titles
class _TranslationsCommonPageTitlesIt extends TranslationsCommonPageTitlesEn {
	_TranslationsCommonPageTitlesIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Opzioni';
	@override String get send => 'Invia File';
	@override String get receive => 'Ricevi File';
}

// Path: common.navbar
class _TranslationsCommonNavbarIt extends TranslationsCommonNavbarEn {
	_TranslationsCommonNavbarIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get send => 'Invia';
	@override String get receive => 'Ricevi';
	@override String get settings => 'Opzioni';
}

// Path: pages.send
class _TranslationsPagesSendIt extends TranslationsPagesSendEn {
	_TranslationsPagesSendIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get send_file => 'Invia file';
	@override String get send_folder => 'Invia cartella';
	@override String get permission_denied => 'È richiesto il permesso per inviare cartelle';
	@override String get abort_transfer_title => 'Annullare il trasferimento dei file?';
	@override String get abort_transfer_message => 'Vuoi annullare il trasferimento dei file in corso?';
	@override String get abort_transfer_yes => 'Si';
	@override String get abort_transfer_no => 'No';
	@override String get zip_failed => 'Vi è stato un errore nella creazione del file compresso ZIP';
	@override String get clipboard_copied => 'Codice copiato nella clipboard';
	@override String get status_waiting => 'Aspettando il destinatario';
	@override String get status_transferring => 'Trasferendo i file';
	@override String connection_info({required Object type}) => 'Trasferimento via: ${type}';
	@override String get status_initializing => 'Initializzando il trasferimento';
	@override String get status_zipping => 'Creando il file zip';
	@override String status_zipping_progress({required Object progress}) => 'Creando il file zip: ${progress}';
	@override String get status_starting_transfer => 'Iniziando il trasferimento';
}

// Path: pages.receive
class _TranslationsPagesReceiveIt extends TranslationsPagesReceiveEn {
	_TranslationsPagesReceiveIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get code_input_hint => 'Inserisci il Codice';
	@override String get receive_button => 'Ricevendo i File';
	@override String get status_connecting => 'Connettendo...';
	@override String get status_transferring => 'Trasfeendo i file';
	@override String status_finished({required Object name}) => 'Riceivuto file: ${name}';
}

// Path: pages.settings
class _TranslationsPagesSettingsIt extends TranslationsPagesSettingsEn {
	_TranslationsPagesSettingsIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get general_header => 'Generali';
	@override String get appearance_header => 'Aspetto';
	@override String get connection_header => 'Connessione';
	@override String get language_label => 'Lingue';
	@override String get language_system => 'Default di sistema';
	@override String get theme_label => 'Tema';
	@override String get theme_system => 'Sistema';
	@override String get theme_light => 'Chiaro';
	@override String get theme_dark => 'Scuro';
	@override String get dynamic_color_label => 'Colori Dinamici';
	@override String get dynamic_color_subtitle => 'Usa colori di sistema (Android 12+)';
	@override String get rendezvous_url_label => 'URL del Server Rendezvous';
	@override String get transmit_url_label => 'URL del Server di Transito';
	@override String get code_length_label => 'Lunghezza del Codice';
	@override String get accent_color_label => 'Colore di Accento';
	@override String get reset_to_default => 'Resetta al Default';
	@override String get app_version_label => 'Versione App';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.page_titles.settings': return 'Opzioni';
			case 'common.page_titles.send': return 'Invia File';
			case 'common.page_titles.receive': return 'Ricevi File';
			case 'common.navbar.send': return 'Invia';
			case 'common.navbar.receive': return 'Ricevi';
			case 'common.navbar.settings': return 'Opzioni';
			case 'common.generic_error': return 'Qualcosa è andato storto';
			case 'common.generic_acknowledge': return 'Ok';
			case 'common.cancel': return 'Annulla';
			case 'pages.send.send_file': return 'Invia file';
			case 'pages.send.send_folder': return 'Invia cartella';
			case 'pages.send.permission_denied': return 'È richiesto il permesso per inviare cartelle';
			case 'pages.send.abort_transfer_title': return 'Annullare il trasferimento dei file?';
			case 'pages.send.abort_transfer_message': return 'Vuoi annullare il trasferimento dei file in corso?';
			case 'pages.send.abort_transfer_yes': return 'Si';
			case 'pages.send.abort_transfer_no': return 'No';
			case 'pages.send.zip_failed': return 'Vi è stato un errore nella creazione del file compresso ZIP';
			case 'pages.send.clipboard_copied': return 'Codice copiato nella clipboard';
			case 'pages.send.status_waiting': return 'Aspettando il destinatario';
			case 'pages.send.status_transferring': return 'Trasferendo i file';
			case 'pages.send.connection_info': return ({required Object type}) => 'Trasferimento via: ${type}';
			case 'pages.send.status_initializing': return 'Initializzando il trasferimento';
			case 'pages.send.status_zipping': return 'Creando il file zip';
			case 'pages.send.status_zipping_progress': return ({required Object progress}) => 'Creando il file zip: ${progress}';
			case 'pages.send.status_starting_transfer': return 'Iniziando il trasferimento';
			case 'pages.receive.code_input_hint': return 'Inserisci il Codice';
			case 'pages.receive.receive_button': return 'Ricevendo i File';
			case 'pages.receive.status_connecting': return 'Connettendo...';
			case 'pages.receive.status_transferring': return 'Trasfeendo i file';
			case 'pages.receive.status_finished': return ({required Object name}) => 'Riceivuto file: ${name}';
			case 'pages.settings.general_header': return 'Generali';
			case 'pages.settings.appearance_header': return 'Aspetto';
			case 'pages.settings.connection_header': return 'Connessione';
			case 'pages.settings.language_label': return 'Lingue';
			case 'pages.settings.language_system': return 'Default di sistema';
			case 'pages.settings.theme_label': return 'Tema';
			case 'pages.settings.theme_system': return 'Sistema';
			case 'pages.settings.theme_light': return 'Chiaro';
			case 'pages.settings.theme_dark': return 'Scuro';
			case 'pages.settings.dynamic_color_label': return 'Colori Dinamici';
			case 'pages.settings.dynamic_color_subtitle': return 'Usa colori di sistema (Android 12+)';
			case 'pages.settings.rendezvous_url_label': return 'URL del Server Rendezvous';
			case 'pages.settings.transmit_url_label': return 'URL del Server di Transito';
			case 'pages.settings.code_length_label': return 'Lunghezza del Codice';
			case 'pages.settings.accent_color_label': return 'Colore di Accento';
			case 'pages.settings.reset_to_default': return 'Resetta al Default';
			case 'pages.settings.app_version_label': return 'Versione App';
			default: return null;
		}
	}
}

