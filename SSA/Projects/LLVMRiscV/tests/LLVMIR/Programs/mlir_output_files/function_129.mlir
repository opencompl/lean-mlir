module {
  func.func @main() -> i64 attributes {seed = 128 : index} {
    %true = arith.constant true
    %0 = arith.extsi %true : i1 to i64
    return %0 : i64
  }
}
