module {
  func.func @main() -> i1 attributes {seed = 150 : index} {
    %false = arith.constant false
    return %false : i1
  }
}
