module {
  func.func @main() -> i64 attributes {seed = 67 : index} {
    %c-5828893222867816574_i64 = arith.constant -5828893222867816574 : i64
    %c-6521698882570605103_i64 = arith.constant -6521698882570605103 : i64
    %c-9119562089868481024_i64 = arith.constant -9119562089868481024 : i64
    %0 = arith.remsi %c-6521698882570605103_i64, %c-9119562089868481024_i64 : i64
    %1 = arith.shrsi %c-5828893222867816574_i64, %0 : i64
    return %1 : i64
  }
}
