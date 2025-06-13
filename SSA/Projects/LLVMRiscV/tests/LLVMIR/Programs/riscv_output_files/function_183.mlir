module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 182 : index} {
    %c-2212314380819112449_i64 = arith.constant -2212314380819112449 : i64
    %0 = arith.remsi %c-2212314380819112449_i64, %arg0 : i64
    return %0 : i64
  }
}
