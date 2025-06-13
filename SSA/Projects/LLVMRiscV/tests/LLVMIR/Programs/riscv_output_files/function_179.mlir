module {
  func.func @main() -> i1 attributes {seed = 178 : index} {
    %true = arith.constant true
    %false = arith.constant false
    %0 = arith.shrui %true, %false : i1
    return %0 : i1
  }
}
