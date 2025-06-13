module {
  func.func @main() -> i1 attributes {seed = 100 : index} {
    %false = arith.constant false
    return %false : i1
  }
}
