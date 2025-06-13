module {
  func.func @main() -> i64 attributes {seed = 168 : index} {
    %true = arith.constant true
    %0 = arith.extsi %true : i1 to i64
    %1 = arith.shli %0, %0 : i64
    return %1 : i64
  }
}
