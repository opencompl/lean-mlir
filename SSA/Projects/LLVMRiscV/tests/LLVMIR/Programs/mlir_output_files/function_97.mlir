module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 96 : index} {
    %c-8255981647209066626_i64 = arith.constant -8255981647209066626 : i64
    %0 = arith.ori %c-8255981647209066626_i64, %arg0 : i64
    return %0 : i64
  }
}
