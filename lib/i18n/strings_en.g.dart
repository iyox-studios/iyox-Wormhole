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
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
	late final TranslationsPagesEn pages = TranslationsPagesEn.internal(_root);
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsCommonPageTitlesEn page_titles = TranslationsCommonPageTitlesEn.internal(_root);
	late final TranslationsCommonNavbarEn navbar = TranslationsCommonNavbarEn.internal(_root);
	String get generic_error => 'Something went wrong';
	String get generic_acknowledge => 'Ok';
	String get cancel => 'Cancel';
}

// Path: pages
class TranslationsPagesEn {
	TranslationsPagesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesSendEn send = TranslationsPagesSendEn.internal(_root);
	late final TranslationsPagesReceiveEn receive = TranslationsPagesReceiveEn.internal(_root);
	late final TranslationsPagesSettingsEn settings = TranslationsPagesSettingsEn.internal(_root);
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
	String get abort_transfer_message => 'Do you want to abort the current file transfer?';
	String get abort_transfer_yes => 'Yes';
	String get abort_transfer_no => 'No';
	String get zip_failed => 'An error occurred while creating the ZIP archive';
	String get clipboard_copied => 'Code copied to clipboard';
	String get status_waiting => 'Waiting for receiver';
	String get status_transferring => 'Transferring file';
	String connection_info({required Object type}) => 'Transferring via: ${type}';
	String get status_initializing => 'Initializing transfer';
	String get status_zipping => 'Creating zipfile';
	String status_zipping_progress({required Object progress}) => 'Creating zipfile: ${progress}';
	String get status_starting_transfer => 'Starting transfer';
}

// Path: pages.receive
class TranslationsPagesReceiveEn {
	TranslationsPagesReceiveEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get code_input_hint => 'Enter Code';
	String get receive_button => 'Receive File';
	String get status_connecting => 'Connecting...';
	String get status_transferring => 'Transferring file';
	String status_finished({required Object name}) => 'Received file: ${name}';
}

// Path: pages.settings
class TranslationsPagesSettingsEn {
	TranslationsPagesSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get general_header => 'General';
	String get appearance_header => 'Appearance';
	String get connection_header => 'Connection';
	String get language_label => 'Language';
	String get language_system => 'System Default';
	String get theme_label => 'Theme';
	String get theme_system => 'System';
	String get theme_light => 'Light';
	String get theme_dark => 'Dark';
	String get dynamic_color_label => 'Dynamic Colors';
	String get dynamic_color_subtitle => 'Use system colors (Android 12+)';
	String get rendezvous_url_label => 'Rendezvous Server URL';
	String get transmit_url_label => 'Transit Server URL';
	String get code_length_label => 'Code Length';
	String get accent_color_label => 'Accent Color';
	String get reset_to_default => 'Reset to default';
	String get app_version_label => 'App Version';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.page_titles.settings': return 'Settings';
			case 'common.page_titles.send': return 'Send File';
			case 'common.page_titles.receive': return 'Receive File';
			case 'common.navbar.send': return 'Send';
			case 'common.navbar.receive': return 'Receive';
			case 'common.navbar.settings': return 'Settings';
			case 'common.generic_error': return 'Something went wrong';
			case 'common.generic_acknowledge': return 'Ok';
			case 'common.cancel': return 'Cancel';
			case 'pages.send.send_file': return 'Send file';
			case 'pages.send.send_folder': return 'Send folder';
			case 'pages.send.permission_denied': return 'Permission required to send folders';
			case 'pages.send.abort_transfer_title': return 'Abort file transfer?';
			case 'pages.send.abort_transfer_message': return 'Do you want to abort the current file transfer?';
			case 'pages.send.abort_transfer_yes': return 'Yes';
			case 'pages.send.abort_transfer_no': return 'No';
			case 'pages.send.zip_failed': return 'An error occurred while creating the ZIP archive';
			case 'pages.send.clipboard_copied': return 'Code copied to clipboard';
			case 'pages.send.status_waiting': return 'Waiting for receiver';
			case 'pages.send.status_transferring': return 'Transferring file';
			case 'pages.send.connection_info': return ({required Object type}) => 'Transferring via: ${type}';
			case 'pages.send.status_initializing': return 'Initializing transfer';
			case 'pages.send.status_zipping': return 'Creating zipfile';
			case 'pages.send.status_zipping_progress': return ({required Object progress}) => 'Creating zipfile: ${progress}';
			case 'pages.send.status_starting_transfer': return 'Starting transfer';
			case 'pages.receive.code_input_hint': return 'Enter Code';
			case 'pages.receive.receive_button': return 'Receive File';
			case 'pages.receive.status_connecting': return 'Connecting...';
			case 'pages.receive.status_transferring': return 'Transferring file';
			case 'pages.receive.status_finished': return ({required Object name}) => 'Received file: ${name}';
			case 'pages.settings.general_header': return 'General';
			case 'pages.settings.appearance_header': return 'Appearance';
			case 'pages.settings.connection_header': return 'Connection';
			case 'pages.settings.language_label': return 'Language';
			case 'pages.settings.language_system': return 'System Default';
			case 'pages.settings.theme_label': return 'Theme';
			case 'pages.settings.theme_system': return 'System';
			case 'pages.settings.theme_light': return 'Light';
			case 'pages.settings.theme_dark': return 'Dark';
			case 'pages.settings.dynamic_color_label': return 'Dynamic Colors';
			case 'pages.settings.dynamic_color_subtitle': return 'Use system colors (Android 12+)';
			case 'pages.settings.rendezvous_url_label': return 'Rendezvous Server URL';
			case 'pages.settings.transmit_url_label': return 'Transit Server URL';
			case 'pages.settings.code_length_label': return 'Code Length';
			case 'pages.settings.accent_color_label': return 'Accent Color';
			case 'pages.settings.reset_to_default': return 'Reset to default';
			case 'pages.settings.app_version_label': return 'App Version';
			default: return null;
		}
	}
}

