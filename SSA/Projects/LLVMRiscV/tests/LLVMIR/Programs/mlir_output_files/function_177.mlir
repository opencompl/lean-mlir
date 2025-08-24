module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 176 : index} {
    %c-4571148209368180742_i64 = arith.constant -4571148209368180742 : i64
    %0 = arith.xori %c-4571148209368180742_i64, %arg0 : i64
    %false = arith.constant false
    %1 = arith.select %false, %0, %0 : i64
    %2 = arith.muli %1, %1 : i64
    %3 = arith.ori %0, %2 : i64
    return %3 : i64
  }
}
