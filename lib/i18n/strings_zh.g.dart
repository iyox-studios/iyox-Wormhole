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
class TranslationsZh extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsZh _root = this; // ignore: unused_field

	@override 
	TranslationsZh $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZh(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonZh common = _TranslationsCommonZh._(_root);
	@override late final _TranslationsPagesZh pages = _TranslationsPagesZh._(_root);
}

// Path: common
class _TranslationsCommonZh extends TranslationsCommonEn {
	_TranslationsCommonZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsCommonPageTitlesZh page_titles = _TranslationsCommonPageTitlesZh._(_root);
	@override late final _TranslationsCommonNavbarZh navbar = _TranslationsCommonNavbarZh._(_root);
	@override String get generic_error => '发生了错误';
	@override String get generic_acknowledge => '确定';
	@override String get cancel => '取消';
}

// Path: pages
class _TranslationsPagesZh extends TranslationsPagesEn {
	_TranslationsPagesZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesSendZh send = _TranslationsPagesSendZh._(_root);
	@override late final _TranslationsPagesReceiveZh receive = _TranslationsPagesReceiveZh._(_root);
	@override late final _TranslationsPagesSettingsZh settings = _TranslationsPagesSettingsZh._(_root);
}

// Path: common.page_titles
class _TranslationsCommonPageTitlesZh extends TranslationsCommonPageTitlesEn {
	_TranslationsCommonPageTitlesZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get settings => '设置';
	@override String get send => '发送文件';
	@override String get receive => '接收文件';
}

// Path: common.navbar
class _TranslationsCommonNavbarZh extends TranslationsCommonNavbarEn {
	_TranslationsCommonNavbarZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get send => '发送';
	@override String get receive => '接收';
	@override String get settings => '设置';
}

// Path: pages.send
class _TranslationsPagesSendZh extends TranslationsPagesSendEn {
	_TranslationsPagesSendZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get send_file => '发送文件';
	@override String get send_folder => '发送文件夹';
	@override String get permission_denied => '发送文件夹需要权限';
	@override String get abort_transfer_title => '中止文件传输？';
	@override String get abort_transfer_message => '你确定要中止当前的文件传输吗？';
	@override String get abort_transfer_yes => '中止';
	@override String get abort_transfer_no => '继续';
	@override String get zip_failed => '创建压缩文件时出错';
	@override String get clipboard_copied => '代码已复制到剪贴板';
	@override String get status_waiting => '等待接收方';
	@override String get status_transferring => '正在传输文件';
	@override String connection_info({required Object type}) => '传输方式：${type}';
	@override String get status_initializing => '正在初始化传输';
	@override String get status_zipping => '正在创建压缩包';
	@override String status_zipping_progress({required Object progress}) => '压缩中：${progress}';
	@override String get status_starting_transfer => '开始传输';
}

// Path: pages.receive
class _TranslationsPagesReceiveZh extends TranslationsPagesReceiveEn {
	_TranslationsPagesReceiveZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get code_input_hint => '输入代码';
	@override String get receive_button => '接收文件';
	@override String get status_connecting => '正在连接…';
	@override String get status_transferring => '正在传输文件';
	@override String status_finished({required Object name}) => '已接收文件：${name}';
}

// Path: pages.settings
class _TranslationsPagesSettingsZh extends TranslationsPagesSettingsEn {
	_TranslationsPagesSettingsZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get general_header => '通用';
	@override String get appearance_header => '外观';
	@override String get connection_header => '连接';
	@override String get language_label => '语言';
	@override String get language_system => '跟随系统';
	@override String get theme_label => '主题';
	@override String get theme_system => '系统';
	@override String get theme_light => '浅色';
	@override String get theme_dark => '深色';
	@override String get dynamic_color_label => '动态配色';
	@override String get dynamic_color_subtitle => '使用系统配色（Android 12+）';
	@override String get rendezvous_url_label => '中继服务器 URL';
	@override String get transmit_url_label => '传输服务器 URL';
	@override String get code_length_label => '验证码长度';
	@override String get accent_color_label => '强调色';
	@override String get reset_to_default => '恢复默认设置';
	@override String get app_version_label => '应用版本';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.page_titles.settings': return '设置';
			case 'common.page_titles.send': return '发送文件';
			case 'common.page_titles.receive': return '接收文件';
			case 'common.navbar.send': return '发送';
			case 'common.navbar.receive': return '接收';
			case 'common.navbar.settings': return '设置';
			case 'common.generic_error': return '发生了错误';
			case 'common.generic_acknowledge': return '确定';
			case 'common.cancel': return '取消';
			case 'pages.send.send_file': return '发送文件';
			case 'pages.send.send_folder': return '发送文件夹';
			case 'pages.send.permission_denied': return '发送文件夹需要权限';
			case 'pages.send.abort_transfer_title': return '中止文件传输？';
			case 'pages.send.abort_transfer_message': return '你确定要中止当前的文件传输吗？';
			case 'pages.send.abort_transfer_yes': return '中止';
			case 'pages.send.abort_transfer_no': return '继续';
			case 'pages.send.zip_failed': return '创建压缩文件时出错';
			case 'pages.send.clipboard_copied': return '代码已复制到剪贴板';
			case 'pages.send.status_waiting': return '等待接收方';
			case 'pages.send.status_transferring': return '正在传输文件';
			case 'pages.send.connection_info': return ({required Object type}) => '传输方式：${type}';
			case 'pages.send.status_initializing': return '正在初始化传输';
			case 'pages.send.status_zipping': return '正在创建压缩包';
			case 'pages.send.status_zipping_progress': return ({required Object progress}) => '压缩中：${progress}';
			case 'pages.send.status_starting_transfer': return '开始传输';
			case 'pages.receive.code_input_hint': return '输入代码';
			case 'pages.receive.receive_button': return '接收文件';
			case 'pages.receive.status_connecting': return '正在连接…';
			case 'pages.receive.status_transferring': return '正在传输文件';
			case 'pages.receive.status_finished': return ({required Object name}) => '已接收文件：${name}';
			case 'pages.settings.general_header': return '通用';
			case 'pages.settings.appearance_header': return '外观';
			case 'pages.settings.connection_header': return '连接';
			case 'pages.settings.language_label': return '语言';
			case 'pages.settings.language_system': return '跟随系统';
			case 'pages.settings.theme_label': return '主题';
			case 'pages.settings.theme_system': return '系统';
			case 'pages.settings.theme_light': return '浅色';
			case 'pages.settings.theme_dark': return '深色';
			case 'pages.settings.dynamic_color_label': return '动态配色';
			case 'pages.settings.dynamic_color_subtitle': return '使用系统配色（Android 12+）';
			case 'pages.settings.rendezvous_url_label': return '中继服务器 URL';
			case 'pages.settings.transmit_url_label': return '传输服务器 URL';
			case 'pages.settings.code_length_label': return '验证码长度';
			case 'pages.settings.accent_color_label': return '强调色';
			case 'pages.settings.reset_to_default': return '恢复默认设置';
			case 'pages.settings.app_version_label': return '应用版本';
			default: return null;
		}
	}
}

