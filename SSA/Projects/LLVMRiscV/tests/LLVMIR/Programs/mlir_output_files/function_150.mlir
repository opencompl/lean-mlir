module {
  func.func @main() -> i1 attributes {seed = 149 : index} {
    %true = arith.constant true
    return %true : i1
  }
}
