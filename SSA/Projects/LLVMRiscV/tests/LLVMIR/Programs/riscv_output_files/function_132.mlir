module {
  func.func @main() -> i64 attributes {seed = 131 : index} {
    %false = arith.constant false
    %0 = arith.extsi %false : i1 to i64
    return %0 : i64
  }
}
