module {
  func.func @main() -> i1 attributes {seed = 45 : index} {
    %true = arith.constant true
    return %true : i1
  }
}
