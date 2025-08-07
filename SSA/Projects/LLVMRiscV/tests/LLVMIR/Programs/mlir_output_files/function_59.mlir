module {
  func.func @main() -> i1 attributes {seed = 58 : index} {
    %true = arith.constant true
    return %true : i1
  }
}
