module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 193 : index} {
    %c-5031414492951839593_i64 = arith.constant -5031414492951839593 : i64
    %0 = arith.divsi %c-5031414492951839593_i64, %arg0 : i64
    return %0 : i64
  }
}
