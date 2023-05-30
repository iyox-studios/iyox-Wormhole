// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bridge_definitions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Value {
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) int,
    required TResult Function(String field0) string,
    required TResult Function(ErrorType field0, String field1) errorValue,
    required TResult Function(ErrorType field0) error,
    required TResult Function(ConnectionType field0, String field1)
        connectionType,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? int,
    TResult? Function(String field0)? string,
    TResult? Function(ErrorType field0, String field1)? errorValue,
    TResult? Function(ErrorType field0)? error,
    TResult? Function(ConnectionType field0, String field1)? connectionType,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? int,
    TResult Function(String field0)? string,
    TResult Function(ErrorType field0, String field1)? errorValue,
    TResult Function(ErrorType field0)? error,
    TResult Function(ConnectionType field0, String field1)? connectionType,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Value_Int value) int,
    required TResult Function(Value_String value) string,
    required TResult Function(Value_ErrorValue value) errorValue,
    required TResult Function(Value_Error value) error,
    required TResult Function(Value_ConnectionType value) connectionType,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_Int value)? int,
    TResult? Function(Value_String value)? string,
    TResult? Function(Value_ErrorValue value)? errorValue,
    TResult? Function(Value_Error value)? error,
    TResult? Function(Value_ConnectionType value)? connectionType,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_Int value)? int,
    TResult Function(Value_String value)? string,
    TResult Function(Value_ErrorValue value)? errorValue,
    TResult Function(Value_Error value)? error,
    TResult Function(Value_ConnectionType value)? connectionType,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValueCopyWith<$Res> {
  factory $ValueCopyWith(Value value, $Res Function(Value) then) =
      _$ValueCopyWithImpl<$Res, Value>;
}

/// @nodoc
class _$ValueCopyWithImpl<$Res, $Val extends Value>
    implements $ValueCopyWith<$Res> {
  _$ValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$Value_IntCopyWith<$Res> {
  factory _$$Value_IntCopyWith(
          _$Value_Int value, $Res Function(_$Value_Int) then) =
      __$$Value_IntCopyWithImpl<$Res>;
  @useResult
  $Res call({int field0});
}

/// @nodoc
class __$$Value_IntCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_Int>
    implements _$$Value_IntCopyWith<$Res> {
  __$$Value_IntCopyWithImpl(
      _$Value_Int _value, $Res Function(_$Value_Int) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Value_Int(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$Value_Int implements Value_Int {
  const _$Value_Int(this.field0);

  @override
  final int field0;

  @override
  String toString() {
    return 'Value.int(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_Int &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_IntCopyWith<_$Value_Int> get copyWith =>
      __$$Value_IntCopyWithImpl<_$Value_Int>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) int,
    required TResult Function(String field0) string,
    required TResult Function(ErrorType field0, String field1) errorValue,
    required TResult Function(ErrorType field0) error,
    required TResult Function(ConnectionType field0, String field1)
        connectionType,
  }) {
    return int(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? int,
    TResult? Function(String field0)? string,
    TResult? Function(ErrorType field0, String field1)? errorValue,
    TResult? Function(ErrorType field0)? error,
    TResult? Function(ConnectionType field0, String field1)? connectionType,
  }) {
    return int?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? int,
    TResult Function(String field0)? string,
    TResult Function(ErrorType field0, String field1)? errorValue,
    TResult Function(ErrorType field0)? error,
    TResult Function(ConnectionType field0, String field1)? connectionType,
    required TResult orElse(),
  }) {
    if (int != null) {
      return int(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Value_Int value) int,
    required TResult Function(Value_String value) string,
    required TResult Function(Value_ErrorValue value) errorValue,
    required TResult Function(Value_Error value) error,
    required TResult Function(Value_ConnectionType value) connectionType,
  }) {
    return int(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_Int value)? int,
    TResult? Function(Value_String value)? string,
    TResult? Function(Value_ErrorValue value)? errorValue,
    TResult? Function(Value_Error value)? error,
    TResult? Function(Value_ConnectionType value)? connectionType,
  }) {
    return int?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_Int value)? int,
    TResult Function(Value_String value)? string,
    TResult Function(Value_ErrorValue value)? errorValue,
    TResult Function(Value_Error value)? error,
    TResult Function(Value_ConnectionType value)? connectionType,
    required TResult orElse(),
  }) {
    if (int != null) {
      return int(this);
    }
    return orElse();
  }
}

abstract class Value_Int implements Value {
  const factory Value_Int(final int field0) = _$Value_Int;

  @override
  int get field0;
  @JsonKey(ignore: true)
  _$$Value_IntCopyWith<_$Value_Int> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Value_StringCopyWith<$Res> {
  factory _$$Value_StringCopyWith(
          _$Value_String value, $Res Function(_$Value_String) then) =
      __$$Value_StringCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$Value_StringCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_String>
    implements _$$Value_StringCopyWith<$Res> {
  __$$Value_StringCopyWithImpl(
      _$Value_String _value, $Res Function(_$Value_String) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Value_String(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Value_String implements Value_String {
  const _$Value_String(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'Value.string(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_String &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_StringCopyWith<_$Value_String> get copyWith =>
      __$$Value_StringCopyWithImpl<_$Value_String>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) int,
    required TResult Function(String field0) string,
    required TResult Function(ErrorType field0, String field1) errorValue,
    required TResult Function(ErrorType field0) error,
    required TResult Function(ConnectionType field0, String field1)
        connectionType,
  }) {
    return string(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? int,
    TResult? Function(String field0)? string,
    TResult? Function(ErrorType field0, String field1)? errorValue,
    TResult? Function(ErrorType field0)? error,
    TResult? Function(ConnectionType field0, String field1)? connectionType,
  }) {
    return string?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? int,
    TResult Function(String field0)? string,
    TResult Function(ErrorType field0, String field1)? errorValue,
    TResult Function(ErrorType field0)? error,
    TResult Function(ConnectionType field0, String field1)? connectionType,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Value_Int value) int,
    required TResult Function(Value_String value) string,
    required TResult Function(Value_ErrorValue value) errorValue,
    required TResult Function(Value_Error value) error,
    required TResult Function(Value_ConnectionType value) connectionType,
  }) {
    return string(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_Int value)? int,
    TResult? Function(Value_String value)? string,
    TResult? Function(Value_ErrorValue value)? errorValue,
    TResult? Function(Value_Error value)? error,
    TResult? Function(Value_ConnectionType value)? connectionType,
  }) {
    return string?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_Int value)? int,
    TResult Function(Value_String value)? string,
    TResult Function(Value_ErrorValue value)? errorValue,
    TResult Function(Value_Error value)? error,
    TResult Function(Value_ConnectionType value)? connectionType,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(this);
    }
    return orElse();
  }
}

abstract class Value_String implements Value {
  const factory Value_String(final String field0) = _$Value_String;

  @override
  String get field0;
  @JsonKey(ignore: true)
  _$$Value_StringCopyWith<_$Value_String> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Value_ErrorValueCopyWith<$Res> {
  factory _$$Value_ErrorValueCopyWith(
          _$Value_ErrorValue value, $Res Function(_$Value_ErrorValue) then) =
      __$$Value_ErrorValueCopyWithImpl<$Res>;
  @useResult
  $Res call({ErrorType field0, String field1});
}

/// @nodoc
class __$$Value_ErrorValueCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_ErrorValue>
    implements _$$Value_ErrorValueCopyWith<$Res> {
  __$$Value_ErrorValueCopyWithImpl(
      _$Value_ErrorValue _value, $Res Function(_$Value_ErrorValue) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
    Object? field1 = null,
  }) {
    return _then(_$Value_ErrorValue(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as ErrorType,
      null == field1
          ? _value.field1
          : field1 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Value_ErrorValue implements Value_ErrorValue {
  const _$Value_ErrorValue(this.field0, this.field1);

  @override
  final ErrorType field0;
  @override
  final String field1;

  @override
  String toString() {
    return 'Value.errorValue(field0: $field0, field1: $field1)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_ErrorValue &&
            (identical(other.field0, field0) || other.field0 == field0) &&
            (identical(other.field1, field1) || other.field1 == field1));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0, field1);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_ErrorValueCopyWith<_$Value_ErrorValue> get copyWith =>
      __$$Value_ErrorValueCopyWithImpl<_$Value_ErrorValue>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) int,
    required TResult Function(String field0) string,
    required TResult Function(ErrorType field0, String field1) errorValue,
    required TResult Function(ErrorType field0) error,
    required TResult Function(ConnectionType field0, String field1)
        connectionType,
  }) {
    return errorValue(field0, field1);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? int,
    TResult? Function(String field0)? string,
    TResult? Function(ErrorType field0, String field1)? errorValue,
    TResult? Function(ErrorType field0)? error,
    TResult? Function(ConnectionType field0, String field1)? connectionType,
  }) {
    return errorValue?.call(field0, field1);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? int,
    TResult Function(String field0)? string,
    TResult Function(ErrorType field0, String field1)? errorValue,
    TResult Function(ErrorType field0)? error,
    TResult Function(ConnectionType field0, String field1)? connectionType,
    required TResult orElse(),
  }) {
    if (errorValue != null) {
      return errorValue(field0, field1);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Value_Int value) int,
    required TResult Function(Value_String value) string,
    required TResult Function(Value_ErrorValue value) errorValue,
    required TResult Function(Value_Error value) error,
    required TResult Function(Value_ConnectionType value) connectionType,
  }) {
    return errorValue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_Int value)? int,
    TResult? Function(Value_String value)? string,
    TResult? Function(Value_ErrorValue value)? errorValue,
    TResult? Function(Value_Error value)? error,
    TResult? Function(Value_ConnectionType value)? connectionType,
  }) {
    return errorValue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_Int value)? int,
    TResult Function(Value_String value)? string,
    TResult Function(Value_ErrorValue value)? errorValue,
    TResult Function(Value_Error value)? error,
    TResult Function(Value_ConnectionType value)? connectionType,
    required TResult orElse(),
  }) {
    if (errorValue != null) {
      return errorValue(this);
    }
    return orElse();
  }
}

abstract class Value_ErrorValue implements Value {
  const factory Value_ErrorValue(final ErrorType field0, final String field1) =
      _$Value_ErrorValue;

  @override
  ErrorType get field0;
  String get field1;
  @JsonKey(ignore: true)
  _$$Value_ErrorValueCopyWith<_$Value_ErrorValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Value_ErrorCopyWith<$Res> {
  factory _$$Value_ErrorCopyWith(
          _$Value_Error value, $Res Function(_$Value_Error) then) =
      __$$Value_ErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({ErrorType field0});
}

/// @nodoc
class __$$Value_ErrorCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_Error>
    implements _$$Value_ErrorCopyWith<$Res> {
  __$$Value_ErrorCopyWithImpl(
      _$Value_Error _value, $Res Function(_$Value_Error) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Value_Error(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as ErrorType,
    ));
  }
}

/// @nodoc

class _$Value_Error implements Value_Error {
  const _$Value_Error(this.field0);

  @override
  final ErrorType field0;

  @override
  String toString() {
    return 'Value.error(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_Error &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_ErrorCopyWith<_$Value_Error> get copyWith =>
      __$$Value_ErrorCopyWithImpl<_$Value_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) int,
    required TResult Function(String field0) string,
    required TResult Function(ErrorType field0, String field1) errorValue,
    required TResult Function(ErrorType field0) error,
    required TResult Function(ConnectionType field0, String field1)
        connectionType,
  }) {
    return error(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? int,
    TResult? Function(String field0)? string,
    TResult? Function(ErrorType field0, String field1)? errorValue,
    TResult? Function(ErrorType field0)? error,
    TResult? Function(ConnectionType field0, String field1)? connectionType,
  }) {
    return error?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? int,
    TResult Function(String field0)? string,
    TResult Function(ErrorType field0, String field1)? errorValue,
    TResult Function(ErrorType field0)? error,
    TResult Function(ConnectionType field0, String field1)? connectionType,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Value_Int value) int,
    required TResult Function(Value_String value) string,
    required TResult Function(Value_ErrorValue value) errorValue,
    required TResult Function(Value_Error value) error,
    required TResult Function(Value_ConnectionType value) connectionType,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_Int value)? int,
    TResult? Function(Value_String value)? string,
    TResult? Function(Value_ErrorValue value)? errorValue,
    TResult? Function(Value_Error value)? error,
    TResult? Function(Value_ConnectionType value)? connectionType,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_Int value)? int,
    TResult Function(Value_String value)? string,
    TResult Function(Value_ErrorValue value)? errorValue,
    TResult Function(Value_Error value)? error,
    TResult Function(Value_ConnectionType value)? connectionType,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Value_Error implements Value {
  const factory Value_Error(final ErrorType field0) = _$Value_Error;

  @override
  ErrorType get field0;
  @JsonKey(ignore: true)
  _$$Value_ErrorCopyWith<_$Value_Error> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Value_ConnectionTypeCopyWith<$Res> {
  factory _$$Value_ConnectionTypeCopyWith(_$Value_ConnectionType value,
          $Res Function(_$Value_ConnectionType) then) =
      __$$Value_ConnectionTypeCopyWithImpl<$Res>;
  @useResult
  $Res call({ConnectionType field0, String field1});
}

/// @nodoc
class __$$Value_ConnectionTypeCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_ConnectionType>
    implements _$$Value_ConnectionTypeCopyWith<$Res> {
  __$$Value_ConnectionTypeCopyWithImpl(_$Value_ConnectionType _value,
      $Res Function(_$Value_ConnectionType) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
    Object? field1 = null,
  }) {
    return _then(_$Value_ConnectionType(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as ConnectionType,
      null == field1
          ? _value.field1
          : field1 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Value_ConnectionType implements Value_ConnectionType {
  const _$Value_ConnectionType(this.field0, this.field1);

  @override
  final ConnectionType field0;
  @override
  final String field1;

  @override
  String toString() {
    return 'Value.connectionType(field0: $field0, field1: $field1)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_ConnectionType &&
            (identical(other.field0, field0) || other.field0 == field0) &&
            (identical(other.field1, field1) || other.field1 == field1));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0, field1);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_ConnectionTypeCopyWith<_$Value_ConnectionType> get copyWith =>
      __$$Value_ConnectionTypeCopyWithImpl<_$Value_ConnectionType>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) int,
    required TResult Function(String field0) string,
    required TResult Function(ErrorType field0, String field1) errorValue,
    required TResult Function(ErrorType field0) error,
    required TResult Function(ConnectionType field0, String field1)
        connectionType,
  }) {
    return connectionType(field0, field1);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? int,
    TResult? Function(String field0)? string,
    TResult? Function(ErrorType field0, String field1)? errorValue,
    TResult? Function(ErrorType field0)? error,
    TResult? Function(ConnectionType field0, String field1)? connectionType,
  }) {
    return connectionType?.call(field0, field1);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? int,
    TResult Function(String field0)? string,
    TResult Function(ErrorType field0, String field1)? errorValue,
    TResult Function(ErrorType field0)? error,
    TResult Function(ConnectionType field0, String field1)? connectionType,
    required TResult orElse(),
  }) {
    if (connectionType != null) {
      return connectionType(field0, field1);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Value_Int value) int,
    required TResult Function(Value_String value) string,
    required TResult Function(Value_ErrorValue value) errorValue,
    required TResult Function(Value_Error value) error,
    required TResult Function(Value_ConnectionType value) connectionType,
  }) {
    return connectionType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_Int value)? int,
    TResult? Function(Value_String value)? string,
    TResult? Function(Value_ErrorValue value)? errorValue,
    TResult? Function(Value_Error value)? error,
    TResult? Function(Value_ConnectionType value)? connectionType,
  }) {
    return connectionType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_Int value)? int,
    TResult Function(Value_String value)? string,
    TResult Function(Value_ErrorValue value)? errorValue,
    TResult Function(Value_Error value)? error,
    TResult Function(Value_ConnectionType value)? connectionType,
    required TResult orElse(),
  }) {
    if (connectionType != null) {
      return connectionType(this);
    }
    return orElse();
  }
}

abstract class Value_ConnectionType implements Value {
  const factory Value_ConnectionType(
          final ConnectionType field0, final String field1) =
      _$Value_ConnectionType;

  @override
  ConnectionType get field0;
  String get field1;
  @JsonKey(ignore: true)
  _$$Value_ConnectionTypeCopyWith<_$Value_ConnectionType> get copyWith =>
      throw _privateConstructorUsedError;
}
