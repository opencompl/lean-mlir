module {
  func.func @main() -> i1 attributes {seed = 70 : index} {
    %true = arith.constant true
    return %true : i1
  }
}
