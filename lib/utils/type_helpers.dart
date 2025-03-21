import 'package:iyox_wormhole/rust/wormhole/types/t_update.dart';

extension GetValue<T> on TUpdate {
  T getValue() {
    final val = value.field0;
    return val as T;
  }
}
