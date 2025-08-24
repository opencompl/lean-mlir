module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 129 : index} {
    %c-5554505298628650495_i64 = arith.constant -5554505298628650495 : i64
    %0 = arith.divui %c-5554505298628650495_i64, %arg1 : i64
    %1 = arith.divui %arg0, %0 : i64
    return %1 : i64
  }
}
