module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 17 : index} {
    %c-8016584723174229753_i64 = arith.constant -8016584723174229753 : i64
    %c1713136009960174413_i64 = arith.constant 1713136009960174413 : i64
    %0 = arith.xori %c-8016584723174229753_i64, %c1713136009960174413_i64 : i64
    %1 = arith.andi %arg0, %0 : i64
    return %1 : i64
  }
}
