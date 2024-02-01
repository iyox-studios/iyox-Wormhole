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
abstract class _$$Value_IntImplCopyWith<$Res> {
  factory _$$Value_IntImplCopyWith(
          _$Value_IntImpl value, $Res Function(_$Value_IntImpl) then) =
      __$$Value_IntImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int field0});
}

/// @nodoc
class __$$Value_IntImplCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_IntImpl>
    implements _$$Value_IntImplCopyWith<$Res> {
  __$$Value_IntImplCopyWithImpl(
      _$Value_IntImpl _value, $Res Function(_$Value_IntImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Value_IntImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$Value_IntImpl implements Value_Int {
  const _$Value_IntImpl(this.field0);

  @override
  final int field0;

  @override
  String toString() {
    return 'Value.int(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_IntImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_IntImplCopyWith<_$Value_IntImpl> get copyWith =>
      __$$Value_IntImplCopyWithImpl<_$Value_IntImpl>(this, _$identity);

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
  const factory Value_Int(final int field0) = _$Value_IntImpl;

  @override
  int get field0;
  @JsonKey(ignore: true)
  _$$Value_IntImplCopyWith<_$Value_IntImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Value_StringImplCopyWith<$Res> {
  factory _$$Value_StringImplCopyWith(
          _$Value_StringImpl value, $Res Function(_$Value_StringImpl) then) =
      __$$Value_StringImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$Value_StringImplCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_StringImpl>
    implements _$$Value_StringImplCopyWith<$Res> {
  __$$Value_StringImplCopyWithImpl(
      _$Value_StringImpl _value, $Res Function(_$Value_StringImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Value_StringImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Value_StringImpl implements Value_String {
  const _$Value_StringImpl(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'Value.string(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_StringImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_StringImplCopyWith<_$Value_StringImpl> get copyWith =>
      __$$Value_StringImplCopyWithImpl<_$Value_StringImpl>(this, _$identity);

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
  const factory Value_String(final String field0) = _$Value_StringImpl;

  @override
  String get field0;
  @JsonKey(ignore: true)
  _$$Value_StringImplCopyWith<_$Value_StringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Value_ErrorValueImplCopyWith<$Res> {
  factory _$$Value_ErrorValueImplCopyWith(_$Value_ErrorValueImpl value,
          $Res Function(_$Value_ErrorValueImpl) then) =
      __$$Value_ErrorValueImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ErrorType field0, String field1});
}

/// @nodoc
class __$$Value_ErrorValueImplCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_ErrorValueImpl>
    implements _$$Value_ErrorValueImplCopyWith<$Res> {
  __$$Value_ErrorValueImplCopyWithImpl(_$Value_ErrorValueImpl _value,
      $Res Function(_$Value_ErrorValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
    Object? field1 = null,
  }) {
    return _then(_$Value_ErrorValueImpl(
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

class _$Value_ErrorValueImpl implements Value_ErrorValue {
  const _$Value_ErrorValueImpl(this.field0, this.field1);

  @override
  final ErrorType field0;
  @override
  final String field1;

  @override
  String toString() {
    return 'Value.errorValue(field0: $field0, field1: $field1)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_ErrorValueImpl &&
            (identical(other.field0, field0) || other.field0 == field0) &&
            (identical(other.field1, field1) || other.field1 == field1));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0, field1);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_ErrorValueImplCopyWith<_$Value_ErrorValueImpl> get copyWith =>
      __$$Value_ErrorValueImplCopyWithImpl<_$Value_ErrorValueImpl>(
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
      _$Value_ErrorValueImpl;

  @override
  ErrorType get field0;
  String get field1;
  @JsonKey(ignore: true)
  _$$Value_ErrorValueImplCopyWith<_$Value_ErrorValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Value_ErrorImplCopyWith<$Res> {
  factory _$$Value_ErrorImplCopyWith(
          _$Value_ErrorImpl value, $Res Function(_$Value_ErrorImpl) then) =
      __$$Value_ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ErrorType field0});
}

/// @nodoc
class __$$Value_ErrorImplCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_ErrorImpl>
    implements _$$Value_ErrorImplCopyWith<$Res> {
  __$$Value_ErrorImplCopyWithImpl(
      _$Value_ErrorImpl _value, $Res Function(_$Value_ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Value_ErrorImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as ErrorType,
    ));
  }
}

/// @nodoc

class _$Value_ErrorImpl implements Value_Error {
  const _$Value_ErrorImpl(this.field0);

  @override
  final ErrorType field0;

  @override
  String toString() {
    return 'Value.error(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_ErrorImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_ErrorImplCopyWith<_$Value_ErrorImpl> get copyWith =>
      __$$Value_ErrorImplCopyWithImpl<_$Value_ErrorImpl>(this, _$identity);

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
  const factory Value_Error(final ErrorType field0) = _$Value_ErrorImpl;

  @override
  ErrorType get field0;
  @JsonKey(ignore: true)
  _$$Value_ErrorImplCopyWith<_$Value_ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Value_ConnectionTypeImplCopyWith<$Res> {
  factory _$$Value_ConnectionTypeImplCopyWith(_$Value_ConnectionTypeImpl value,
          $Res Function(_$Value_ConnectionTypeImpl) then) =
      __$$Value_ConnectionTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ConnectionType field0, String field1});
}

/// @nodoc
class __$$Value_ConnectionTypeImplCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_ConnectionTypeImpl>
    implements _$$Value_ConnectionTypeImplCopyWith<$Res> {
  __$$Value_ConnectionTypeImplCopyWithImpl(_$Value_ConnectionTypeImpl _value,
      $Res Function(_$Value_ConnectionTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
    Object? field1 = null,
  }) {
    return _then(_$Value_ConnectionTypeImpl(
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

class _$Value_ConnectionTypeImpl implements Value_ConnectionType {
  const _$Value_ConnectionTypeImpl(this.field0, this.field1);

  @override
  final ConnectionType field0;
  @override
  final String field1;

  @override
  String toString() {
    return 'Value.connectionType(field0: $field0, field1: $field1)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_ConnectionTypeImpl &&
            (identical(other.field0, field0) || other.field0 == field0) &&
            (identical(other.field1, field1) || other.field1 == field1));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0, field1);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_ConnectionTypeImplCopyWith<_$Value_ConnectionTypeImpl>
      get copyWith =>
          __$$Value_ConnectionTypeImplCopyWithImpl<_$Value_ConnectionTypeImpl>(
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
      _$Value_ConnectionTypeImpl;

  @override
  ConnectionType get field0;
  String get field1;
  @JsonKey(ignore: true)
  _$$Value_ConnectionTypeImplCopyWith<_$Value_ConnectionTypeImpl>
      get copyWith => throw _privateConstructorUsedError;
}
