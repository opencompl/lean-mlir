module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 9 : index} {
    %c8618564919846881285_i64 = arith.constant 8618564919846881285 : i64
    %0 = arith.xori %c8618564919846881285_i64, %arg0 : i64
    return %0 : i64
  }
}
