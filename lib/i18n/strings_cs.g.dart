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
class TranslationsCs extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsCs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.cs,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <cs>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsCs _root = this; // ignore: unused_field

	@override 
	TranslationsCs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsCs(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonCs common = _TranslationsCommonCs._(_root);
	@override late final _TranslationsPagesCs pages = _TranslationsPagesCs._(_root);
}

// Path: common
class _TranslationsCommonCs extends TranslationsCommonEn {
	_TranslationsCommonCs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsCommonPageTitlesCs page_titles = _TranslationsCommonPageTitlesCs._(_root);
	@override late final _TranslationsCommonNavbarCs navbar = _TranslationsCommonNavbarCs._(_root);
	@override String get generic_error => 'Něco se nepovedlo';
	@override String get generic_acknowledge => 'OK';
	@override String get cancel => 'Zrušit';
}

// Path: pages
class _TranslationsPagesCs extends TranslationsPagesEn {
	_TranslationsPagesCs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesSendCs send = _TranslationsPagesSendCs._(_root);
	@override late final _TranslationsPagesReceiveCs receive = _TranslationsPagesReceiveCs._(_root);
	@override late final _TranslationsPagesSettingsCs settings = _TranslationsPagesSettingsCs._(_root);
}

// Path: common.page_titles
class _TranslationsCommonPageTitlesCs extends TranslationsCommonPageTitlesEn {
	_TranslationsCommonPageTitlesCs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Nastavení';
	@override String get send => 'Odeslat soubor';
	@override String get receive => 'Přijmout soubor';
}

// Path: common.navbar
class _TranslationsCommonNavbarCs extends TranslationsCommonNavbarEn {
	_TranslationsCommonNavbarCs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get send => 'Odeslat';
	@override String get receive => 'Přijmout';
	@override String get settings => 'Nastavení';
}

// Path: pages.send
class _TranslationsPagesSendCs extends TranslationsPagesSendEn {
	_TranslationsPagesSendCs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get send_file => 'Odeslat soubor';
	@override String get send_folder => 'Odeslat složku';
	@override String get permission_denied => 'Pro odeslání složek je potřeba oprávnění';
	@override String get abort_transfer_title => 'Zrušit probíhající přenos?';
	@override String get abort_transfer_message => 'Opravdu chcete zrušit aktuálně běžící přenos souboru?';
	@override String get abort_transfer_yes => 'Ano';
	@override String get abort_transfer_no => 'Ne';
	@override String get zip_failed => 'Při vytváření ZIP archivu došlo k chybě';
	@override String get clipboard_copied => 'Kód byl zkopírován do schránky';
	@override String get status_waiting => 'Čeká se na příjemce';
	@override String get status_transferring => 'Probíhá přenos';
	@override String connection_info({required Object type}) => 'Přenos přes: ${type}';
	@override String get status_initializing => 'Přenos se připravuje';
	@override String get status_zipping => 'Vytváření ZIP archivu';
	@override String status_zipping_progress({required Object progress}) => 'Vytváření ZIP: ${progress}';
	@override String get status_starting_transfer => 'Zahajování přenosu';
}

// Path: pages.receive
class _TranslationsPagesReceiveCs extends TranslationsPagesReceiveEn {
	_TranslationsPagesReceiveCs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get code_input_hint => 'Zadejte kód';
	@override String get receive_button => 'Přijmout soubor';
	@override String get status_connecting => 'Připojování...';
	@override String get status_transferring => 'Přenášení souboru';
	@override String status_finished({required Object name}) => 'Přijatý soubor: ${name}';
}

// Path: pages.settings
class _TranslationsPagesSettingsCs extends TranslationsPagesSettingsEn {
	_TranslationsPagesSettingsCs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get general_header => 'Obecné';
	@override String get appearance_header => 'Vzhled';
	@override String get connection_header => 'Připojení';
	@override String get language_label => 'Jazyk';
	@override String get language_system => 'Výchozí (systém)';
	@override String get theme_label => 'Vzhled';
	@override String get theme_system => 'Dle nastavení systému';
	@override String get theme_light => 'Světlý';
	@override String get theme_dark => 'Tmavý';
	@override String get dynamic_color_label => 'Paleta barev';
	@override String get dynamic_color_subtitle => 'Použít systémové barvy (Android 12+)';
	@override String get rendezvous_url_label => 'URL Rendezvous serveru';
	@override String get transmit_url_label => 'URL Transit serveru';
	@override String get code_length_label => 'Délka kódu';
	@override String get accent_color_label => 'Doplňková barva';
	@override String get reset_to_default => 'Resetovat nastavení';
	@override String get app_version_label => 'Verze aplikace';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsCs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.page_titles.settings': return 'Nastavení';
			case 'common.page_titles.send': return 'Odeslat soubor';
			case 'common.page_titles.receive': return 'Přijmout soubor';
			case 'common.navbar.send': return 'Odeslat';
			case 'common.navbar.receive': return 'Přijmout';
			case 'common.navbar.settings': return 'Nastavení';
			case 'common.generic_error': return 'Něco se nepovedlo';
			case 'common.generic_acknowledge': return 'OK';
			case 'common.cancel': return 'Zrušit';
			case 'pages.send.send_file': return 'Odeslat soubor';
			case 'pages.send.send_folder': return 'Odeslat složku';
			case 'pages.send.permission_denied': return 'Pro odeslání složek je potřeba oprávnění';
			case 'pages.send.abort_transfer_title': return 'Zrušit probíhající přenos?';
			case 'pages.send.abort_transfer_message': return 'Opravdu chcete zrušit aktuálně běžící přenos souboru?';
			case 'pages.send.abort_transfer_yes': return 'Ano';
			case 'pages.send.abort_transfer_no': return 'Ne';
			case 'pages.send.zip_failed': return 'Při vytváření ZIP archivu došlo k chybě';
			case 'pages.send.clipboard_copied': return 'Kód byl zkopírován do schránky';
			case 'pages.send.status_waiting': return 'Čeká se na příjemce';
			case 'pages.send.status_transferring': return 'Probíhá přenos';
			case 'pages.send.connection_info': return ({required Object type}) => 'Přenos přes: ${type}';
			case 'pages.send.status_initializing': return 'Přenos se připravuje';
			case 'pages.send.status_zipping': return 'Vytváření ZIP archivu';
			case 'pages.send.status_zipping_progress': return ({required Object progress}) => 'Vytváření ZIP: ${progress}';
			case 'pages.send.status_starting_transfer': return 'Zahajování přenosu';
			case 'pages.receive.code_input_hint': return 'Zadejte kód';
			case 'pages.receive.receive_button': return 'Přijmout soubor';
			case 'pages.receive.status_connecting': return 'Připojování...';
			case 'pages.receive.status_transferring': return 'Přenášení souboru';
			case 'pages.receive.status_finished': return ({required Object name}) => 'Přijatý soubor: ${name}';
			case 'pages.settings.general_header': return 'Obecné';
			case 'pages.settings.appearance_header': return 'Vzhled';
			case 'pages.settings.connection_header': return 'Připojení';
			case 'pages.settings.language_label': return 'Jazyk';
			case 'pages.settings.language_system': return 'Výchozí (systém)';
			case 'pages.settings.theme_label': return 'Vzhled';
			case 'pages.settings.theme_system': return 'Dle nastavení systému';
			case 'pages.settings.theme_light': return 'Světlý';
			case 'pages.settings.theme_dark': return 'Tmavý';
			case 'pages.settings.dynamic_color_label': return 'Paleta barev';
			case 'pages.settings.dynamic_color_subtitle': return 'Použít systémové barvy (Android 12+)';
			case 'pages.settings.rendezvous_url_label': return 'URL Rendezvous serveru';
			case 'pages.settings.transmit_url_label': return 'URL Transit serveru';
			case 'pages.settings.code_length_label': return 'Délka kódu';
			case 'pages.settings.accent_color_label': return 'Doplňková barva';
			case 'pages.settings.reset_to_default': return 'Resetovat nastavení';
			case 'pages.settings.app_version_label': return 'Verze aplikace';
			default: return null;
		}
	}
}

