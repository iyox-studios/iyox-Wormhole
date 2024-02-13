import '../../gen/bridge_definitions.dart';

extension GetValue<T> on TUpdate {
  T getValue() {
    final val = value.field0;
    return val as T;
  }
}
