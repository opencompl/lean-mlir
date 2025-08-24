module {
  func.func @main() -> i64 attributes {seed = 135 : index} {
    %true = arith.constant true
    %0 = arith.extui %true : i1 to i64
    return %0 : i64
  }
}
